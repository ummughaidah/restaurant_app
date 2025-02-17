import 'package:flutter/material.dart';
import 'package:restaurant_app/model/search_model.dart';
import 'package:restaurant_app/service/service_api.dart';

class SearchProvider extends ChangeNotifier {
  final ServiceApi _serviceApi;

  SearchProvider({required ServiceApi serviceApi}) : _serviceApi = serviceApi;

  SearchModel? _searchResult;
  bool _isLoading = false;
  String _errorMessage = '';
  String _query = '';

  SearchModel? get searchResult => _searchResult;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isSearching => _query.isNotEmpty;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> searchRestaurants(String query) async {
    _query = query;
    if (query.isEmpty) {
      _searchResult = null;
      notifyListeners();
      return;
    }

    _setLoading(true);
    _errorMessage = '';

    try {
      _searchResult = await _serviceApi.getSearchRestaurant(query);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }
}
