import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';
import 'package:restaurant_app/widget/card_restaurant_list.dart';
import 'package:restaurant_app/widget/custom_form_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_searchFocus);
    });
  }

  final FocusNode _searchFocus = FocusNode();

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Search Restaurant",
        style: TextTheme.of(context).headlineSmall,
      )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomFormField(
              controller: _searchController,
              focusNode: _searchFocus,
              onChanged: (query) {
                context.read<SearchProvider>().searchRestaurants(query);
              },
            ),
          ),
          Expanded(child:
              Consumer<SearchProvider>(builder: (context, provider, child) {
            return switch (provider.resultState) {
              RestaurantSearchLoadingState() => Center(
                  child: CircularProgressIndicator(),
                ),
              RestaurantSearchLoadedState(data: var restaurants) =>
                ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];
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
              RestaurantSearchErrorState(error: var message) => Center(
                  child: Text(message),
                ),
              _ => Text("No data found. Enter a keyword to search."),
            };
          }))
        ],
      ),
    );
  }
}
