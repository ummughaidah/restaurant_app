import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_response.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screen/restaurant/restaurant_screen.dart';
import 'package:restaurant_app/widget/custom_form_field.dart';
import 'package:restaurant_app/data/service/service_api.dart';

class MockServiceApi extends Mock implements ServiceApi {}

void main() {
  late MockServiceApi mockServiceApi;
  late RestaurantProvider restaurantProvider;

  setUp(() {
    mockServiceApi = MockServiceApi();
    restaurantProvider = RestaurantProvider(mockServiceApi);

    registerFallbackValue(RestaurantResponse(
      restaurants: [],
      error: false,
      message: '',
      count: 0,
    ));
  });

  testWidgets('Memeriksa tampilan awal RestaurantScreen',
      (WidgetTester tester) async {
    when(() => mockServiceApi.getListRestaurants()).thenAnswer((_) async {
      return Future.delayed(
        Duration(milliseconds: 500),
        () => RestaurantResponse(
          restaurants: [],
          error: false,
          message: '',
          count: 0,
        ),
      );
    });

    await tester.pumpWidget(
      ChangeNotifierProvider<RestaurantProvider>.value(
        value: restaurantProvider,
        child: MaterialApp(home: RestaurantScreen()),
      ),
    );

    expect(find.text('Restaurant'), findsOneWidget);

    expect(find.text('Recommendation restaurant for you!'), findsOneWidget);

    expect(find.byType(CustomFormField), findsOneWidget);

    restaurantProvider.fetchRestaurants();
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
  });
}
