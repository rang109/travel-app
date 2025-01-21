from django.urls import path
from . import views

urlpatterns = [
    # Event URLs
    path('events/', views.event_list, name='event_list'),
    path('events/create/', views.event_create, name='event_create'),
    path('events/<int:pk>/', views.event_detail, name='event_detail'),
    path('events/<int:pk>/update/', views.event_update, name='event_update'),
    path('events/<int:pk>/delete/', views.event_delete, name='event_delete'),

    # Itinerary URLs
    path('events/<int:event_pk>/itineraries/create/', views.itinerary_create, name='itinerary_create'),
    path('itineraries/all/', views.all_itineraries, name='all_itineraries'), 
    path('itineraries/<int:pk>/', views.itinerary_detail, name='itinerary_details'),
    path('itineraries/<int:pk>/update/', views.itinerary_update, name='itinerary_update'),
    path('itineraries/<int:pk>/delete/', views.itinerary_delete, name='itinerary_delete'),
]