import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/routes/navigation_route.dart';
import 'package:restaurant_app/screen/detail/detail_restaurant.dart';
import 'package:restaurant_app/screen/restaurant_screen.dart';
import 'package:restaurant_app/screen/search_screen.dart';
import 'package:restaurant_app/data/service/service_api.dart';
import 'package:restaurant_app/theme/restaurant_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProvider(ServiceApi())),
        ChangeNotifierProvider(
            create: (_) => DetailRestaurantProvider(ServiceApi())),
        ChangeNotifierProvider(create: (_) => SearchProvider(ServiceApi())),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.restaurantRoute.route,
      routes: {
        NavigationRoute.restaurantRoute.route: (context) => RestaurantScreen(),
        NavigationRoute.detailRoute.route: (context) => DetailRestaurant(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
        NavigationRoute.searchRoute.route: (context) => SearchScreen(),
      },
    );
  }
}
