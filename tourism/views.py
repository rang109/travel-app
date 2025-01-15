from django.http import JsonResponse
from .models import TouristSpot
from django.shortcuts import render

def sorted_tourist_spots(request):

    # API endpoint to fetch and sort tourist spots by reviews in descending order.

    spots = TouristSpot.objects.all().order_by('-reviews') #Sort by reviews in descending order.

    data = [
        {
            'id': spot.id,
            'place_name': spot.place_name,
            'place_city': spot.place_city,
            'address': spot.address,
            'category': spot.category,
            'description': spot.description,
            'reviews': float(spot.reviews), #type- casted to float for JSON compatibility -- does that mean NUMERIC is not compatible with JSON?
        }
        for spot in spots

    ]
    return JsonResponse({'tourist_spots': data})

def sorted_tourist_spots_template(request):
    spots = TouristSpot.objects.order_by('-reviews')

    return render(request, 'tourism/sorted_list.html', {'spots': spots})

