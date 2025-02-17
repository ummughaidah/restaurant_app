import 'package:restaurant_app/model/restaurant.dart';

class SearchModel {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  SearchModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      error: json['error'],
      founded: json['founded'],
      restaurants: List<Restaurant>.from(
          json['restaurants'].map((x) => Restaurant.fromJson(x))),
    );
  }
}
