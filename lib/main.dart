import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/local_db_service.dart';
import 'package:restaurant_app/data/service/local_notification_service.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/index_nav_provider.dart';
import 'package:restaurant_app/provider/local_db_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:restaurant_app/routes/navigation_route.dart';
import 'package:restaurant_app/screen/detail/detail_restaurant.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/screen/restaurant/restaurant_screen.dart';
import 'package:restaurant_app/screen/search/search_screen.dart';
import 'package:restaurant_app/data/service/service_api.dart';
import 'package:restaurant_app/screen/setting/setting_screen.dart';
import 'package:restaurant_app/theme/restaurant_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationService = LocalNotificationService();
  await notificationService.configureLocalTimeZone();
  await notificationService.initializeNotifications();
  await notificationService.requestPermissions();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProvider(ServiceApi())),
        ChangeNotifierProvider(
            create: (_) => DetailRestaurantProvider(ServiceApi())),
        ChangeNotifierProvider(create: (_) => SearchProvider(ServiceApi())),
        ChangeNotifierProvider(create: (_) => IndexNavProvider()),
        Provider(
          create: (_) => LocalDbService(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDbProvider(
            context.read<LocalDbService>(),
          ),
        ),
        ChangeNotifierProvider(
            create: (_) => SettingProvider(notificationService)),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, provider, _) {
        final Brightness systemBrightness =
            MediaQuery.of(context).platformBrightness;
        final bool isSystemDark = systemBrightness == Brightness.dark;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: RestaurantTheme.lightTheme,
          darkTheme: RestaurantTheme.darkTheme,
          themeMode: provider.isDarkTheme
              ? ThemeMode.dark
              : (isSystemDark ? ThemeMode.light : ThemeMode.light),
          initialRoute: NavigationRoute.homeRoute.route,
          routes: {
            NavigationRoute.restaurantRoute.route: (context) =>
                RestaurantScreen(),
            NavigationRoute.detailRoute.route: (context) => DetailRestaurant(
                  id: ModalRoute.of(context)?.settings.arguments as String,
                ),
            NavigationRoute.searchRoute.route: (context) => SearchScreen(),
            NavigationRoute.homeRoute.route: (context) => HomeScreen(),
            NavigationRoute.favoriteRoute.route: (context) => FavoriteScreen(),
            NavigationRoute.settingRoute.route: (context) => SettingScreen(),
          },
        );
      },
    );
  }
}
