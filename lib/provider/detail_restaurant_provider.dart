import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_model.dart';
import 'package:restaurant_app/service/service_api.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ServiceApi serviceApi;
  DetailRestaurantModel? _restaurant;
  bool _isLoading = false;
  String _errorMessage = '';

  DetailRestaurantProvider({required this.serviceApi});

  DetailRestaurantModel? get restaurant => _restaurant;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchDetailRestaurant(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _restaurant = await serviceApi.getDetailRestaurant(id);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
      _restaurant = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
