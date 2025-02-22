import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/favorite_icon_provider.dart';
import 'package:restaurant_app/screen/detail/favorite_icon_widget.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class BodyDetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  const BodyDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                ChangeNotifierProvider(
                  create: (context) => FavoriteIconProvider(),
                  child: Consumer<DetailRestaurantProvider>(
                      builder: (_, provider, child) {
                    return switch (provider.resurtState) {
                      RestaurantDetailLoadedState(data: var restaurant) =>
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: FavoriteIconWidget(restaurant: restaurant),
                        ),
                      _ => Center(
                          child: Text('No data favorite'),
                        ),
                    };
                  }),
                ),
              ],
            ),
            Text(
              restaurant.name,
              style: TextTheme.of(context).bodyLarge,
            ),
            Row(
              spacing: 4,
              children: [
                Icon(
                  Icons.location_on,
                  size: 12,
                ),
                Text(
                  '${restaurant.address!}, Kota ${restaurant.city}',
                  style: TextTheme.of(context).bodySmall,
                ),
              ],
            ),
            Row(
              spacing: 4,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
                Text(
                  restaurant.rating.toString(),
                  style: TextTheme.of(context).bodySmall,
                ),
              ],
            ),
            Text(
              'Description',
              style: TextTheme.of(context).bodyMedium,
            ),
            Text(restaurant.description,
                style: TextTheme.of(context).bodySmall),
            Text("Kategori:", style: TextTheme.of(context).bodyMedium),
            Wrap(
              spacing: 8,
              children: restaurant.categories!
                  .map((c) => Chip(
                          label: Text(
                        c.name,
                        style: TextTheme.of(context).bodySmall,
                      )))
                  .toList(),
            ),
            Text("Menu Makanan:", style: TextTheme.of(context).bodyMedium),
            Wrap(
              spacing: 8,
              children: restaurant.menus!.foods
                  .map((c) => Chip(
                          label: Text(
                        c.name,
                        style: TextTheme.of(context).bodySmall,
                      )))
                  .toList(),
            ),
            Text("Menu Minuman:", style: TextTheme.of(context).bodyMedium),
            Wrap(
              spacing: 8,
              children: restaurant.menus!.drinks
                  .map((c) => Chip(
                          label: Text(
                        c.name,
                        style: TextTheme.of(context).bodySmall,
                      )))
                  .toList(),
            ),
            Text("Ulasan Pelanggan:", style: TextTheme.of(context).bodyMedium),
            ...restaurant.customerReviews!.map((review) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.name,
                          style: TextTheme.of(context).labelLarge),
                      Text(review.review,
                          style: TextTheme.of(context).labelMedium),
                      Text(review.date,
                          style: TextTheme.of(context).labelSmall),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
