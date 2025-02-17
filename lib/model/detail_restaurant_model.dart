import 'package:restaurant_app/model/restaurant.dart';

class DetailRestaurantModel {
  final bool error;
  final String message;
  final Restaurant restaurant;

  DetailRestaurantModel({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory DetailRestaurantModel.fromJson(Map<String, dynamic> json) {
    return DetailRestaurantModel(
      error: json['error'],
      message: json['message'],
      restaurant: Restaurant.fromJson(json['restaurant']),
    );
  }
}
