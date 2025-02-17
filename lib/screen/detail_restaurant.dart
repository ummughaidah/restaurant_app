import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';

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
      Provider.of<DetailRestaurantProvider>(context, listen: false)
          .fetchDetailRestaurant(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailRestaurantProvider>(
          builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage.isNotEmpty) {
          return Center(child: Text(provider.errorMessage));
        }

        if (provider.restaurant == null) {
          return Center(child: Text("Tidak ada data"));
        }

        final restaurant = provider.restaurant!.restaurant;

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}'),
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
                      restaurant.address!,
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
                Text("Ulasan Pelanggan:",
                    style: TextTheme.of(context).bodyMedium),
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
      }),
    );
  }
}
