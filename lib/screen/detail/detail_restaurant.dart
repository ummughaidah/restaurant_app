import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/screen/detail/body_detail_screen.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class DetailRestaurant extends StatefulWidget {
  final String id;

  const DetailRestaurant({super.key, required this.id});

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailRestaurantProvider>().fetchDetailRestaurant(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailRestaurantProvider>(
          builder: (context, provider, child) {
        return switch (provider.resurtState) {
          RestaurantDetailLoadingState() => Center(
              child: CircularProgressIndicator(),
            ),
          RestaurantDetailLoadedState(data: var restaurant) =>
            BodyDetailScreen(restaurant: restaurant),
          RestaurantDetailErrorState(error: var message) => Center(
              child: Text(message),
            ),
          _ => SizedBox(),
        };
      }),
    );
  }
}
