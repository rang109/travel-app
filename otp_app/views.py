import json
from django.shortcuts import render, redirect
from .forms import RegisterForm
from .models import OtpToken
from django.contrib import messages
from django.contrib.auth import get_user_model, authenticate, login, logout
from django.utils import timezone
from django.core.mail import send_mail

from decouple import config
import os

def index(request):
    return render(request, "index.html")


# def signup(request):
#     form = RegisterForm()
#     if request.method == 'POST':
#         # Convert POST data to JSON
#         post_data_dict = request.POST.dict()  # Convert QueryDict to a standard dictionary
#         post_data_json = json.dumps(post_data_dict)  # Convert dictionary to JSON string
#         print(f"POST data as JSON: {post_data_json}")  # Debugging: Log JSON data to console

#         # Pass the dictionary to the form for processing
#         form = RegisterForm(post_data_dict)
#         if form.is_valid():
#             user = form.save(commit=False)  # Don't commit the save yet
#             user.is_active = False  # Make sure the user is not active
#             user.save()  # Now save the user
#             messages.success(request, "Account created successfully! An OTP was sent to your Email")
#             return redirect("verify-email", username=post_data_dict['username'])
#     context = {"form": form}
#     return render(request, "signup.html", context)


# def verify_email(request, username):
#     user = get_user_model().objects.get(username=username)
#     user_otp = OtpToken.objects.filter(user=user).last()

#     if request.method == 'POST':
#         # Convert POST data to JSON
#         post_data_dict = request.POST.dict()
#         post_data_json = json.dumps(post_data_dict)
#         print(f"POST data as JSON: {post_data_json}")

#         # Process the OTP verification
#         if user_otp.otp_code == post_data_dict['otp_code']:
#             if user_otp.otp_expires_at > timezone.now():
#                 user.is_active = True
#                 user.save()
#                 messages.success(request, "Account activated successfully!! You can Login.")
#                 return redirect("signin")
#             else:
#                 messages.warning(request, "The OTP has expired, get a new OTP!")
#                 return redirect("verify-email", username=user.username)
#         else:
#             messages.warning(request, "Invalid OTP entered, enter a valid OTP!")
#             return redirect("verify-email", username=user.username)

#     context = {}
#     return render(request, "verify_token.html", context)


# def resend_otp(request):
#     if request.method == 'POST':
#         # Convert POST data to JSON
#         post_data_dict = request.POST.dict()
#         post_data_json = json.dumps(post_data_dict)
#         print(f"POST data as JSON: {post_data_json}")

#         user_email = post_data_dict.get("otp_email")
#         if get_user_model().objects.filter(email=user_email).exists():
#             user = get_user_model().objects.get(email=user_email)
#             otp = OtpToken.objects.create(user=user, otp_expires_at=timezone.now() + timezone.timedelta(minutes=5))

#             # Email variables
#             subject = "Email Verification"
#             message = f"""
#                 Hi {user.username}, here is your OTP {otp.otp_code}
#                 it expires in 5 minutes. Use the URL below to redirect back to the website:
#                 http://127.0.0.1:8000/verify-email/{user.username}
#             """
#             sender = config('EMAIL_HOST_USER')
#             receiver = [user.email, ]

#             # Send email
#             send_mail(subject, message, sender, receiver, fail_silently=False)

#             messages.success(request, "A new OTP has been sent to your email address")
#             return redirect("verify-email", username=user.username)
#         else:
#             messages.warning(request, "This email doesn't exist in the database")
#             return redirect("resend-otp")

#     context = {}
#     return render(request, "resend_otp.html", context)


# def signin(request):
#     if request.method == 'POST':
#         # Convert POST data to JSON
#         post_data_dict = request.POST.dict()
#         post_data_json = json.dumps(post_data_dict)
#         print(f"POST data as JSON: {post_data_json}")

#         username = post_data_dict['username']
#         password = post_data_dict['password']
#         user = authenticate(request, username=username, password=password)

#         if user is not None:
#             login(request, user)
#             messages.success(request, f"Hi {request.user.username}, you are now logged in")
#             return redirect("index")
#         else:
#             messages.warning(request, "Invalid credentials")
#             return redirect("signin")

#     return render(request, "login.html")

from django.http import JsonResponse

def signup(request):
    if request.method == 'POST':
        post_data_dict = request.POST.dict()  # Convert QueryDict to a standard dictionary
        post_data_json = json.dumps(post_data_dict)  # Convert dictionary to JSON string
        print(f"POST data as JSON: {post_data_json}")  # Debugging: Log JSON data to console

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

def verify_email(request, username):
    user = get_user_model().objects.get(username=username)
    user_otp = OtpToken.objects.filter(user=user).last()

    if request.method == 'POST':
        post_data_dict = request.POST.dict()
        post_data_json = json.dumps(post_data_dict)
        print(f"POST data as JSON: {post_data_json}")

        if user_otp.otp_code == post_data_dict['otp_code']:
            if user_otp.otp_expires_at > timezone.now():
                user.is_active = True
                user.save()

                response_data = {
                    'success': True,
                    'message': "Account activated successfully! You can log in."
                }
                return JsonResponse(response_data)
            else:
                response_data = {
                    'success': False,
                    'message': "The OTP has expired. Get a new OTP."
                }
                return JsonResponse(response_data)
        else:
            response_data = {
                'success': False,
                'message': "Invalid OTP entered. Please try again."
            }
            return JsonResponse(response_data)
        
    response_data = {
        'success': False,
        'message': "Invalid request method. Please use POST."
    }
    return JsonResponse(response_data)

def resend_otp(request):
    if request.method == 'POST':
        post_data_dict = request.POST.dict()
        post_data_json = json.dumps(post_data_dict)
        print(f"POST data as JSON: {post_data_json}")

        user_email = post_data_dict.get("otp_email")
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
            receiver = [user.email, ]

            # Send email
            send_mail(subject, message, sender, receiver, fail_silently=False)

            response_data = {
                'success': True,
                'message': "A new OTP has been sent to your email address."
            }
            return JsonResponse(response_data)
        else:
            response_data = {
                'success': False,
                'message': "This email doesn't exist in the database."
            }
            return JsonResponse(response_data)

    response_data = {
        'success': False,
        'message': "Invalid request method. Please use POST."
    }
    return JsonResponse(response_data)

from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def signin(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            email = data.get('email')  # Changed from username
            password = data.get('password')
        except json.JSONDecodeError:
            return JsonResponse({
                'success': False, 
                'message': 'Invalid JSON'
            }, status=400)

        user = authenticate(username=email, password=password)
        if user is not None:
            login(request, user)
            return JsonResponse({
                'success': True,
                'message': f"Hi {user.username}, logged in."
            })
        else:
            return JsonResponse({
                'success': False,
                'message': "Invalid credentials."
            }, status=400)