from django.urls import path
from . import views

urlpatterns = [
    path('api/tourist-spots/', views.sorted_tourist_spots, name='sorted_tourist_spots_json'),
    path('sorted-tourist-spots/', views.sorted_tourist_spots_template, name='sorted_tourist_spots_template'),
]