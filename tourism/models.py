from django.db import models

class TouristSpot(models.Model):
    place_name = models.CharField(max_length=255)
    place_city = models.CharField(max_length=100, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    category = models.CharField(max_length=255, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    reviews = models.DecimalField(max_digits=3, decimal_places=1, blank=True, null=True)

    class Meta:
        db_table = 'tourist_spots' # this maps directly to our database table

    def __str__(self):
        return self.place_name
