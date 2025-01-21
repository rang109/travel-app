# Generated by Django 5.1.4 on 2025-01-16 04:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('itineraries', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='place',
            name='category',
            field=models.CharField(default='uncategorized', max_length=100),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='place',
            name='city',
            field=models.CharField(default='unknown', max_length=100),
            preserve_default=False,
        ),
    ]
