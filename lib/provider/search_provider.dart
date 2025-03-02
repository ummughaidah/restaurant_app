import 'package:flutter/material.dart';
import 'package:restaurant_app/data/service/service_api.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ServiceApi _serviceApi;

  SearchProvider(this._serviceApi);

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();

  RestaurantSearchResultState get resultState => _resultState;

  Future<void> searchRestaurants(String query) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _serviceApi.getSearchRestaurant(query);

      if (result!.error) {
        _resultState = RestaurantSearchErrorState('Data not found');
        notifyListeners();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
        notifyListeners();
      }
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(
          'Failed to load data. Please check your connections.');
      notifyListeners();
    }
  }
}
