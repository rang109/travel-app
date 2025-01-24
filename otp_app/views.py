import json
from django.shortcuts import render, redirect
from .forms import RegisterForm
from .models import OtpToken
from django.contrib import messages
from django.contrib.auth import get_user_model, authenticate, login, logout
from django.utils import timezone
from django.core.mail import send_mail
from django.utils.timezone import now
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.hashers import check_password
from django.http import JsonResponse
from django.contrib.auth import authenticate, get_user_model
from django.contrib.auth.hashers import check_password
from django.contrib.auth import logout
from django.middleware.csrf import get_token


from decouple import config
import os

def index(request):
    return render(request, "index.html")

@csrf_exempt
def signup(request):
    if request.method == 'POST':
        try:
            post_data_dict = json.loads(request.body.decode('utf-8'))  # Parse JSON from request body
            print(f"POST data as JSON: {post_data_dict}")  # Debugging: Log JSON data to console

            form = RegisterForm(post_data_dict)
            if form.is_valid():
                user = form.save(commit=False)  # Don't commit the save yet
                user.is_active = False  # Make sure the user is not active
                user.save()  # Now save the user

                response_data = {
                    'success': True,
                    'message': "Account created successfully! An OTP was sent to your Email."
                }
                return JsonResponse(response_data)
            else:
                print(f"Form errors: {form.errors}")  # Debugging: Log form errors to console
                return JsonResponse({
                    'success': False,
                    'message': 'Invalid form data',
                    'errors': form.errors
                }, status=400)
        except json.JSONDecodeError:
            return JsonResponse({
                'success': False,
                'message': 'Invalid JSON data in request body'
            }, status=400)
        
    elif request.method == 'GET':
        try:
            # Parse the raw body data
            body_unicode = request.body.decode('utf-8')
            body_data = json.loads(body_unicode)
            
            response_data = {
                'success': True,
                'message': 'Received signup data',
                'data': body_data
            }
            return JsonResponse(response_data)
        except json.JSONDecodeError:
            return JsonResponse({
                'success': False,
                'message': 'Invalid JSON in request body'
            }, status=400)

    # Fallback for other methods
    return JsonResponse({
        'success': False, 
        'message': 'Invalid request method'
    }, status=405)

@csrf_exempt
def verify_email(request, email):
    try:
        user = get_user_model().objects.get(email=email)
    except get_user_model().DoesNotExist:
        return JsonResponse({
            'success': False,
            'message': 'User with this email does not exist.'
        }, status=404)

    user_otp = OtpToken.objects.filter(user=user).last()
    if not user_otp:
        return JsonResponse({
            'success': False,
            'message': 'No OTP found for this user.'
        }, status=404)

    if request.method == 'POST':
        try:
            post_data_dict = json.loads(request.body.decode('utf-8'))  # Parse JSON body
            print(f"POST data as JSON: {post_data_dict}")  # Debugging: Log parsed JSON data
        except json.JSONDecodeError:
            return JsonResponse({
                'success': False,
                'message': 'Invalid JSON data in request body'
            }, status=400)

        if 'otp_code' not in post_data_dict:
            return JsonResponse({
                'success': False,
                'message': 'OTP code is required.'
            }, status=400)

        if user_otp.otp_code == post_data_dict['otp_code']:
            if user_otp.otp_expires_at > now():
                user.is_active = True
                user.save()

                return JsonResponse({
                    'success': True,
                    'message': "Account activated successfully! You can log in."
                })
            else:
                return JsonResponse({
                    'success': False,
                    'message': "The OTP has expired. Get a new OTP."
                })
        else:
            return JsonResponse({
                'success': False,
                'message': "Invalid OTP entered. Please try again."
            })

    return JsonResponse({
        'success': False,
        'message': "Invalid request method. Please use POST."
    }, status=405)

@csrf_exempt
def send_otp(request):
    if request.method == 'POST':
        try:
            post_data_dict = json.loads(request.body)  # Parse JSON body
            user_email = post_data_dict.get("otp_email")

            if not user_email:
                return JsonResponse({
                    'success': False,
                    'message': "Email field is required."
                }, status=400)
        except json.JSONDecodeError:
            return JsonResponse({
                'success': False,
                'message': "Invalid JSON format."
            }, status=400)

        if get_user_model().objects.filter(email=user_email).exists():
            user = get_user_model().objects.get(email=user_email)
            otp = OtpToken.objects.create(user=user, otp_expires_at=timezone.now() + timezone.timedelta(minutes=5))

            # Email variables
            subject = "Email Verification"
            message = f"""
                Hi {user.username}, here is your OTP {otp.otp_code}
                it expires in 5 minutes. Use the URL below to redirect back to the website:
                http://127.0.0.1:8000/verify-email/{user.username}
            """
            sender = config('EMAIL_HOST_USER')
            receiver = [user.email]

            # Send email
            send_mail(subject, message, sender, receiver, fail_silently=False)

            return JsonResponse({
                'success': True,
                'message': "A new OTP has been sent to your email address."
            })
        else:
            return JsonResponse({
                'success': False,
                'message': "This email doesn't exist in the database."
            })

    return JsonResponse({
        'success': False,
        'message': "Invalid request method. Please use POST."
    }, status=405)


@csrf_exempt
def signin(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            email = data.get('email')  # Ensure email is provided
            password = data.get('password')

            if not email or not password:
                return JsonResponse({
                    'success': False, 
                    'message': 'Email and password are required.'
                }, status=400)
        except json.JSONDecodeError:
            return JsonResponse({
                'success': False, 
                'message': 'Invalid JSON'
            }, status=400)

        # Authenticate using email (Custom Authentication Backend)
        user = authenticate(request, username=email, password=password)

        if user is not None:
            login(request, user)
            return JsonResponse({
                'success': True,
                'message': f"Hi {user.username}, logged in successfully."
            })
        else:
            return JsonResponse({
                'success': False,
                'message': "Invalid credentials."
            }, status=400)

    return JsonResponse({
        'success': False,
        'message': "Invalid request method. Please use POST."
    }, status=405)

@csrf_exempt
def change_password(request):
    if request.method == 'POST':
        try:
            post_data = json.loads(request.body)
            email = post_data.get("email")  # Identify the user by email
            current_password = post_data.get("current_password")
            new_password = post_data.get("new_password")
            confirm_password = post_data.get("confirm_password")

            if not all([email, current_password, new_password, confirm_password]):
                return JsonResponse({'success': False, 'message': "All fields are required."}, status=400)
        except json.JSONDecodeError:
            return JsonResponse({'success': False, 'message': "Invalid JSON format."}, status=400)

        user = get_user_model().objects.filter(email=email).first()

        if user is None:
            return JsonResponse({'success': False, 'message': "User not found."}, status=404)

        # Check if current password is correct
        if not check_password(current_password, user.password):
            return JsonResponse({'success': False, 'message': "Incorrect current password."}, status=400)

        # Validate new password
        if new_password != confirm_password:
            return JsonResponse({'success': False, 'message': "New passwords do not match."}, status=400)

        if len(new_password) < 8:  # Simple validation for length
            return JsonResponse({'success': False, 'message': "Password must be at least 8 characters long."}, status=400)

        # Update password securely
        user.set_password(new_password)
        user.save()

        return JsonResponse({'success': True, 'message': "Password changed successfully!"})

    return JsonResponse({'success': False, 'message': "Invalid request method. Please use POST."}, status=405)

@csrf_exempt
def logout_user(request):
    if request.method == 'POST':
        logout(request)
        return JsonResponse({'success': True, 'message': "User logged out successfully!"})
    
    return JsonResponse({'success': False, 'message': "Invalid request method. Please use POST."}, status=405)

@csrf_exempt
def get_csrf_token(request):
    csrf_token = get_token(request)
    return JsonResponse({'csrf_token': csrf_token})