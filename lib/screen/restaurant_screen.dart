import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/widget/card_restaurant_list.dart';
import 'package:restaurant_app/widget/custom_form_field.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantProvider>().fetchRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restaurant',
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextTheme.of(context).headlineSmall,
            ),
          ],
        ),
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormField(
              readOnly: true,
              onTap: () {
                Navigator.pushNamed(context, "/search");
              },
            ),
            Text(
              'Recommendation restaurant for you!',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextTheme.of(context).titleLarge,
            ),
            Expanded(
              child: Consumer<RestaurantProvider>(
                builder: (context, provider, child) {
                  return switch (provider.resultState) {
                    RestaurantListLoadingState() => Center(
                        child: CircularProgressIndicator(),
                      ),
                    RestaurantListLoadedState(data: var listOfRestaurant) =>
                      ListView.builder(
                        itemCount: listOfRestaurant.length,
                        itemBuilder: (context, index) {
                          final restaurant = listOfRestaurant[index];

                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CardRestaurantList(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/detail',
                                  arguments: restaurant.id,
                                );
                              },
                              picture:
                                  'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                              title: restaurant.name,
                              address: restaurant.city,
                              rating: restaurant.rating,
                            ),
                          );
                        },
                      ),
                    RestaurantListErrorState(error: var message) => Center(
                        child: Text(message),
                      ),
                    _ => SizedBox(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
