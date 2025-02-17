import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
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
    final searchProvider = Provider.of<SearchProvider>(context);

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
          if (searchProvider.isLoading)
            Center(child: CircularProgressIndicator())
          else if (searchProvider.errorMessage.isNotEmpty)
            Center(child: Text("Error: ${searchProvider.errorMessage}"))
          else if (searchProvider.searchResult != null)
            Expanded(
              child: ListView.builder(
                itemCount: searchProvider.searchResult!.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant =
                      searchProvider.searchResult!.restaurants[index];
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
            )
          else
            Text("No data found. Enter a keyword to search."),
        ],
      ),
    );
  }
}
