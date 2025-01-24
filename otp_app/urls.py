from django.urls import path
from . import views 

urlpatterns = [
    path("", views.index, name="index"),
    path("register/", views.signup, name="register"),
    path('verify-email/<str:email>/', views.verify_email, name='verify_email'),
    path("resend-otp/", views.resend_otp, name="resend-otp"),
    path("login/", views.signin, name="signin")
]
