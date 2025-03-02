import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_response.dart';
import 'package:restaurant_app/data/service/service_api.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class MockServiceApi extends Mock implements ServiceApi {}

void main() {
  late RestaurantProvider provider;
  late MockServiceApi mockServiceApi;

  setUp(() {
    mockServiceApi = MockServiceApi();
    provider = RestaurantProvider(mockServiceApi);
  });

  test('Memastikan state awal provider harus didefinisikan', () {
    expect(provider.resultState, isA<RestaurantListNoneState>());
  });

  test(
      'Memastikan harus mengembalikan daftar restoran ketika pengambilan data API berhasil',
      () async {
    final mockResult = RestaurantResponse(
      error: false,
      message: 'Success',
      count: 2,
      restaurants: [
        Restaurant(
          id: "1",
          name: "Restoran A",
          description: "Description A",
          city: "City A",
          pictureId: "PictureIdA",
          rating: 4.5,
        ),
        Restaurant(
          id: "2",
          name: "Restoran B",
          description: "Description B",
          city: "City B",
          pictureId: "PictureIdB",
          rating: 4.0,
        ),
      ],
    );

    when(() => mockServiceApi.getListRestaurants())
        .thenAnswer((_) async => mockResult);

    await provider.fetchRestaurants();

    expect(provider.resultState, isA<RestaurantListLoadedState>());
    final state = provider.resultState as RestaurantListLoadedState;
    expect(state.data.length, 2);
  });

  test(
      'Memastikan harus mengembalikan kesalahan ketika pengambilan data API gagal',
      () async {
    when(() => mockServiceApi.getListRestaurants())
        .thenThrow(Exception("Gagal mengambil data"));

    await provider.fetchRestaurants();

    expect(provider.resultState, isA<RestaurantListErrorState>());
    final state = provider.resultState as RestaurantListErrorState;
    expect(state.error, contains("Gagal mengambil data"));
  });
}
