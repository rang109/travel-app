from django.shortcuts import render, get_object_or_404, redirect
from .models import Event, Itinerary, Place
from .forms import EventForm, ItineraryForm
from django.core.exceptions import ValidationError

# Event Views
def event_list(request):
    events = Event.objects.all()
    return render(request, 'itineraries/event_list.html', {'events': events})

def event_create(request):
    if request.method == 'POST':
        form = EventForm(request.POST)
        if form.is_valid():
            event = form.save()  # Save the event and get the instance
            return redirect('event_detail', pk=event.pk)  # Redirect to the event detail page
    else:
        form = EventForm()  # Create a new form for GET requests

    return render(request, 'itineraries/event_form.html', {'form': form})

def event_detail(request, pk):
    event = get_object_or_404(Event, pk=pk)
    itineraries = event.itineraries.all()  # Get all itineraries for this event
    return render(request, 'itineraries/event_detail.html', {'event': event, 'itineraries': itineraries})

def event_update(request, pk):
    event = get_object_or_404(Event, pk=pk)
    if request.method == 'POST':
        form = EventForm(request.POST, instance=event)
        if form.is_valid():
            form.save()
            return redirect('event_detail', pk=event.pk)
    else:
        form = EventForm(instance=event)
    return render(request, 'itineraries/event_form.html', {'form': form})

def event_delete(request, pk):
    event = get_object_or_404(Event, pk=pk)
    if request.method == 'POST':
        event.delete()
        return redirect('event_list')
    return render(request, 'itineraries/event_confirm_delete.html', {'event': event})

# Itinerary Views
def itinerary_create(request, event_pk):
    event = get_object_or_404(Event, pk=event_pk)
    if request.method == 'POST':
        form = ItineraryForm(request.POST, event=event)  # Pass the event to the form
        if form.is_valid():
            itinerary = form.save(commit=False)
            itinerary.event = event
            try:
                itinerary.full_clean()  # Call the model's clean method for validation
                itinerary.save()
                return redirect('event_detail', pk=event_pk)
            except ValidationError as e:
                # Ensure the error is only added once
                if not form.has_error(None, e):
                    form.add_error(None, e)
    else:
        form = ItineraryForm(event=event)  # Pass the event to the form
    return render(request, 'itineraries/itinerary_form.html', {'form': form, 'event': event})

def itinerary_update(request, pk):
    itinerary = get_object_or_404(Itinerary, pk=pk)
    event = itinerary.event  # Get the event from the itinerary
    if request.method == 'POST':
        form = ItineraryForm(request.POST, instance=itinerary, event=event)  # Pass the instance and event
        if form.is_valid():
            itinerary = form.save(commit=False)
            try:
                itinerary.full_clean()  # Call the model's clean method for validation
                itinerary.save()
                return redirect('event_detail', pk=event.pk)
            except ValidationError as e:
                # Ensure the error is only added once
                if not form.has_error(None, e):
                    form.add_error(None, e)
    else:
        form = ItineraryForm(instance=itinerary, event=event)  # Pass the instance and event
    return render(request, 'itineraries/itinerary_form.html', {'form': form, 'event': event})

from django.shortcuts import render, get_object_or_404
from .models import Itinerary

def itinerary_detail(request, pk):
    itinerary = get_object_or_404(Itinerary, pk=pk)
    return render(request, 'itineraries/itinerary_details.html', {'itinerary': itinerary})

def itinerary_delete(request, pk):
    itinerary = get_object_or_404(Itinerary, pk=pk)
    event_pk = itinerary.event.pk  # Save the event's primary key before deleting the itinerary
    if request.method == 'POST':
        itinerary.delete()
        return redirect('event_detail', pk=event_pk)
    return render(request, 'itineraries/itinerary_confirm_delete.html', {'itinerary': itinerary})

def all_itineraries(request):
    # Fetch all itineraries from the database
    itineraries = Itinerary.objects.all().order_by('from_date', 'from_time')
    return render(request, 'itineraries/all_itineraries.html', {'itineraries': itineraries})