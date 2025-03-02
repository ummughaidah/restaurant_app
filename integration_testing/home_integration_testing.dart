import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/local_db_service.dart';
import 'package:restaurant_app/data/service/local_notification_service.dart';
import 'package:restaurant_app/data/service/service_api.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/index_nav_provider.dart';
import 'package:restaurant_app/provider/local_db_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/screen/restaurant/restaurant_screen.dart';
import 'package:restaurant_app/screen/setting/setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final notificationService = LocalNotificationService();

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Test navigasi BottomNavigationBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => RestaurantProvider(ServiceApi())),
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
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(RestaurantScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pumpAndSettle();
    expect(find.byType(FavoriteScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    expect(find.byType(SettingScreen), findsOneWidget);
  });
}
