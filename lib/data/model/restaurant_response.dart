import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantResponse(
      error: json['error'],
      message: json['message'],
      count: json['count'],
      restaurants: (json['restaurants'] as List)
          .map((e) => Restaurant.fromJson(e))
          .toList(),
    );
  }
}
