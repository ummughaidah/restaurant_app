import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/local_db_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final Restaurant restaurant;

  const FavoriteIconWidget({super.key, required this.restaurant});

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    super.initState();
    final localDbProvider = context.read<LocalDbProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await localDbProvider.loadRestaurantValueById(widget.restaurant.id);
      final value = localDbProvider.restaurant == null
          ? false
          : localDbProvider.restaurant!.id == widget.restaurant.id;
      favoriteIconProvider.isBookmarked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final localDbProvider = context.read<LocalDbProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isBookmarked = favoriteIconProvider.isBookmarked;

        if (isBookmarked) {
          await localDbProvider.removeRestaurantValueById(widget.restaurant.id);
        } else {
          await localDbProvider.saveRestaurantValue(widget.restaurant);
        }
        favoriteIconProvider.isBookmarked = !isBookmarked;
        localDbProvider.loadAllRestaurantValue();
      },
      icon: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).cardColor,
        ),
        child: Icon(
          context.watch<FavoriteIconProvider>().isBookmarked
              ? Icons.favorite
              : Icons.favorite_outline,
          size: 24,
          color: context.watch<FavoriteIconProvider>().isBookmarked
              ? Colors.red
              : Colors.grey,
        ),
      ),
    );
  }
}
