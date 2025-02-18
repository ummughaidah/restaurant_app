import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client, Response;
import 'package:restaurant_app/data/model/detail_restaurant_model.dart';
import 'package:restaurant_app/data/model/restaurant_response.dart';
import 'package:restaurant_app/data/model/search_model.dart';

class ServiceApi {
  final String _baseUrl = 'https://restaurant-api.dicoding.dev';
  final Client _client = http.Client();

  Future<RestaurantResponse?> getListRestaurants() async {
    Uri url = Uri.parse('$_baseUrl/list');
    Response response = await _client.get(url);

    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<DetailRestaurantModel?> getDetailRestaurant(String id) async {
    Uri url = Uri.parse('$_baseUrl/detail/$id');
    Response response = await _client.get(url);

    if (response.statusCode == 200) {
      return DetailRestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<SearchModel?> getSearchRestaurant(String query) async {
    Uri url = Uri.parse('$_baseUrl/search?q=$query');
    Response response = await _client.get(url);

    if (response.statusCode == 200) {
      return SearchModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant search');
    }
  }
}
