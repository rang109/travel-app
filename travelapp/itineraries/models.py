from django.db import models
from django.contrib.auth.models import User
from django.db.models import Q 
from django.core.exceptions import ValidationError
from django.core.validators import MinValueValidator, MaxValueValidator

class Place(models.Model):
    title = models.CharField(max_length=100)
    city = models.CharField(max_length=100)
    location = models.CharField(max_length=100)
    category = models.CharField(max_length=100, default='uncategorized')
    description = models.TextField()
    rating = models.FloatField(
        default=0.0,
        validators=[MinValueValidator(0.0), MaxValueValidator(5.0)]
    )

    def __str__(self):
        return self.title

class Event(models.Model):
    title = models.CharField(max_length=100)
    from_date = models.DateField()
    to_date = models.DateField()
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)  # Optional: Link to a user

    def __str__(self):
        return self.title

class Itinerary(models.Model):
    event = models.ForeignKey(Event, on_delete=models.CASCADE, null=True, blank=True, related_name='itineraries')
    place = models.ForeignKey(Place, on_delete=models.CASCADE)
    from_date = models.DateField()  # Start date of the itinerary
    to_date = models.DateField(null=True, blank=True)    # End date of the itinerary
    from_time = models.TimeField()  # Start time of the itinerary
    to_time = models.TimeField(null=True, blank=True)    # End time of the itinerary

    def __str__(self):
        return f"{self.place.title} from {self.from_date} {self.from_time} to {self.to_date} {self.to_time}"

    def clean(self):
        super().clean()

        if self.event:
            # Ensure the itinerary's date range is within the event's date range
            if self.from_date < self.event.from_date or (self.to_date and self.to_date > self.event.to_date):
                raise ValidationError("The itinerary date range must be within the event's date range.")

            # Ensure the from_date is not after the to_date
            if self.to_date and self.from_date > self.to_date:
                raise ValidationError("The start date cannot be after the end date.")

            # Ensure the from_time is not after the to_time on the same day
            if self.from_date == self.to_date and self.from_time and self.to_time and self.from_time >= self.to_time:
                raise ValidationError("The start time must be before the end time on the same day.")

        # Check for overlapping itineraries across ALL events, excluding the current itinerary
        overlapping_itineraries = Itinerary.objects.filter(
            Q(from_date__lt=self.to_date) | (Q(from_date=self.to_date) & Q(from_time__lt=self.to_time)),
            Q(to_date__gt=self.from_date) | (Q(to_date=self.from_date) & Q(to_time__gt=self.from_time)),
        ).exclude(pk=self.pk)  # Exclude the current itinerar y

        if overlapping_itineraries.exists():
            overlapping_itinerary = overlapping_itineraries.first()
            raise ValidationError(
                f"This itinerary overlaps with another itinerary: "
                f"{overlapping_itinerary.place.title} (Event: {overlapping_itinerary.event.title}) "
                f"from {overlapping_itinerary.from_date.strftime('%b %d, %Y')} {overlapping_itinerary.from_time.strftime('%I:%M %p')} "
                f"to {overlapping_itinerary.to_date.strftime('%b %d, %Y')} {overlapping_itinerary.to_time.strftime('%I:%M %p')}."
            )