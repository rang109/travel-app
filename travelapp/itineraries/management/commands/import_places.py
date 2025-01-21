import csv
from django.core.management.base import BaseCommand
from itineraries.models import Place

class Command(BaseCommand):
    help = 'Import places from a CSV file'

    def add_arguments(self, parser):
        parser.add_argument('csv_file', type=str, help='Path to the CSV file')

    def handle(self, *args, **kwargs):
        csv_file = kwargs['csv_file']

        # Delete all existing Place records
        Place.objects.all().delete()
        self.stdout.write(self.style.SUCCESS('Deleted existing places'))

        with open(csv_file, newline='', encoding='utf-8') as file:
            reader = csv.DictReader(file)
            for row in reader:
                try:
                    rating = float(row['reviews'].strip()) if row['reviews'].strip() else 0.0

                    Place.objects.create(
                        title=row['place_name'],
                        city=row['place_city'],
                        location=row['address'],
                        category=row['category'],
                        description=row['description'],
                        rating=rating
                    )
                except ValueError as e:
                    self.stdout.write(self.style.ERROR(f'Error processing row: {row}. Error: {e}'))
                except KeyError as e:
                    self.stdout.write(self.style.ERROR(f'Missing expected column in row: {row}. Error: {e}'))

        self.stdout.write(self.style.SUCCESS('Successfully imported places'))