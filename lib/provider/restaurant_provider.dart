import 'package:flutter/material.dart';
import 'package:restaurant_app/data/service/service_api.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ServiceApi _serviceApi;

  RestaurantProvider(this._serviceApi);

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurants() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _serviceApi.getListRestaurants();

      if (result!.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception {
      _resultState = RestaurantListErrorState(
          'Failed to load data. Please check your connections.');
      notifyListeners();
    }
  }
}
