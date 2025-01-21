from django import forms
from .models import Itinerary, Event
from datetime import date
from django.core.exceptions import ValidationError

class EventForm(forms.ModelForm):
    class Meta:
        model = Event
        fields = ['title', 'from_date', 'to_date']
        widgets = {
            'from_date': forms.DateInput(attrs={
                'type': 'date',
                'min': date.today().isoformat(), 
            }),
            'to_date': forms.DateInput(attrs={
                'type': 'date',
                'min': date.today().isoformat(),
            }),
        }

    def clean(self):
        cleaned_data = super().clean()
        from_date = cleaned_data.get('from_date')
        to_date = cleaned_data.get('to_date')

        if from_date and from_date < date.today():
            raise ValidationError("The start date cannot be in the past.")

        if to_date and to_date < date.today():
            raise ValidationError("The end date cannot be in the past.")

        if from_date and to_date and to_date < from_date:
            raise ValidationError("The end date must be after the start date.")

        return cleaned_data

class ItineraryForm(forms.ModelForm):
    class Meta:
        model = Itinerary
        fields = ['place', 'from_date', 'from_time', 'to_date', 'to_time']
        widgets = {
            'from_date': forms.DateInput(attrs={'type': 'date'}),
            'to_date': forms.DateInput(attrs={'type': 'date'}),
            'from_time': forms.TimeInput(attrs={'type': 'time'}),
            'to_time': forms.TimeInput(attrs={'type': 'time'}),
        }

    def __init__(self, *args, **kwargs):
        self.event = kwargs.pop('event', None)  # Get the event from kwargs
        super().__init__(*args, **kwargs)

        self.fields['place'].empty_label = "Select a place"

        if self.event:
            # Set the min and max attributes for the date fields
            self.fields['from_date'].widget.attrs['min'] = self.event.from_date.isoformat()
            self.fields['from_date'].widget.attrs['max'] = self.event.to_date.isoformat()
            self.fields['to_date'].widget.attrs['min'] = self.event.from_date.isoformat()
            self.fields['to_date'].widget.attrs['max'] = self.event.to_date.isoformat()

    def clean(self):
        cleaned_data = super().clean()
        from_date = cleaned_data.get('from_date')
        to_date = cleaned_data.get('to_date')
        from_time = cleaned_data.get('from_time')
        to_time = cleaned_data.get('to_time')
        place = cleaned_data.get('place')

        if self.event and from_date and to_date:
            # Ensure the itinerary's date range is within the event's date range
            if from_date < self.event.from_date or to_date > self.event.to_date:
                raise ValidationError("The itinerary date range must be within the event's date range.")

        # Ensure the from_date is not after the to_date
        if from_date and to_date and from_date > to_date:
            raise ValidationError("The start date cannot be after the end date.")

        # Ensure the from_time is not after the to_time on the same day
        if from_date == to_date and from_time and to_time and from_time >= to_time:
            raise ValidationError("The start time must be before the end time on the same day.")

        if from_date and to_date and from_time and to_time and place:
            # Create a temporary Itinerary instance to validate
            itinerary = Itinerary(
                event=self.event,
                place=place,
                from_date=from_date,
                to_date=to_date,
                from_time=from_time,
                to_time=to_time
            )
            if self.instance:  # If updating, set the PK to exclude the current itinerary
                itinerary.pk = self.instance.pk

            try:
                # Call the model's clean method to trigger validation
                itinerary.clean()
            except ValidationError as e:
                # Add the model's validation error to the form's non-field errors
                if not self.has_error(None, e):
                    self.add_error(None, e)

        return cleaned_data