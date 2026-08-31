import 'package:flutter_excercise/features/assets/data/models/asset_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Asset buildAsset({
    String locationCountry = 'CAN',
    String locationState = 'AB',
    String locationCity = 'Grande Prairie',
  }) {
    return Asset(
      assetDescription: '2026 Tigercat 875E Short Wood Log Loader',
      imageUrl: 'https://example.com/image.jpg',
      locationCountry: locationCountry,
      locationState: locationState,
      locationCity: locationCity,
      eventAdvertisedName: 'Grande Prairie, AB, CAN - Sep 02, 2026',
      eventStartDate: DateTime(2026, 9, 2),
    );
  }

  group('formattedLocation', () {
    test('should include city, state, and country for USA', () {
      final asset = buildAsset(
        locationCity: 'Houston',
        locationState: 'TX',
        locationCountry: 'USA',
      );

      expect(asset.formattedLocation, 'Houston, TX, USA');
    });

    test('should include city, state, and country for US', () {
      final asset = buildAsset(
        locationCity: 'Houston',
        locationState: 'TX',
        locationCountry: 'US',
      );

      expect(asset.formattedLocation, 'Houston, TX, US');
    });

    test('should include city, state, and country for United States', () {
      final asset = buildAsset(
        locationCity: 'Phoenix',
        locationState: 'AZ',
        locationCountry: 'United States',
      );

      expect(asset.formattedLocation, 'Phoenix, AZ, United States');
    });

    test('should include only city and country for international locations',
        () {
      final asset = buildAsset(
        locationCity: 'County Of Grande Prairie No. 1',
        locationState: 'AB',
        locationCountry: 'CAN',
      );

      expect(
        asset.formattedLocation,
        'County Of Grande Prairie No. 1, CAN',
      );
    });
  });
}
