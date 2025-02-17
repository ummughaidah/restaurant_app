import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/card_restaurant_list.dart';
import 'package:restaurant_app/widget/custom_form_field.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

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
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (provider.errorMessage != null) {
                    return Center(child: Text(provider.errorMessage!));
                  }

                  final listOfRestaurant = provider.restaurants;
                  return ListView.builder(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
