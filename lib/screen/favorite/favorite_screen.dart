import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/local_db_provider.dart';
import 'package:restaurant_app/widget/card_restaurant_list.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<LocalDbProvider>().loadAllRestaurantValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: TextTheme.of(context).headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: Icon(
              Icons.search,
              size: 24,
            ),
          ),
        ],
      ),
      body: Consumer<LocalDbProvider>(builder: (_, provider, child) {
        final favoriteList = provider.restaurantList ?? [];
        return switch (favoriteList.isNotEmpty) {
          true => ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (_, index) {
                final restaurant = favoriteList[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
          _ => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No data favorite found"),
                ],
              ),
            ),
        };
      }),
    );
  }
}
