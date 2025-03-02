import 'package:flutter/material.dart';
import 'package:restaurant_app/data/service/service_api.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ServiceApi _serviceApi;

  DetailRestaurantProvider(this._serviceApi);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resurtState => _resultState;

  Future<void> fetchDetailRestaurant(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _serviceApi.getDetailRestaurant(id);

      if (result!.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(
          'Failed to load data. Please check your connections.');
      notifyListeners();
    }
  }
}
