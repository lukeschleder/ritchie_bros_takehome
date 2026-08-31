import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Asset extends Equatable {
  const Asset({
    required this.assetDescription,
    required this.imageUrl,
    required this.locationCountry,
    required this.locationState,
    required this.locationCity,
    required this.eventAdvertisedName,
    required this.eventStartDate,
  });

  final String assetDescription;
  final String imageUrl;
  final String locationCountry;
  final String locationState;
  final String locationCity;
  final String eventAdvertisedName;
  final DateTime eventStartDate;

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      assetDescription: json['assetDescription'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      locationCountry: json['locationCountry'] as String? ?? '',
      locationState: json['locationState'] as String? ?? '',
      locationCity: json['locationCity'] as String? ?? '',
      eventAdvertisedName: json['eventAdvertisedName'] as String? ?? '',
      eventStartDate: DateTime.fromMillisecondsSinceEpoch(
        (json['eventStartDate'] as num).toInt(),
      ),
    );
  }

  /// USA assets include state; all others are city and country only.
  String get formattedLocation {
    final isUsa =
        locationCountry == 'USA' || locationCountry == 'United States';
    if (isUsa) {
      return '$locationCity, $locationState, $locationCountry';
    }
    return '$locationCity, $locationCountry';
  }

  String get formattedDate => DateFormat.yMMMd().format(eventStartDate);

  @override
  List<Object?> get props => [
        assetDescription,
        imageUrl,
        locationCountry,
        locationState,
        locationCity,
        eventAdvertisedName,
        eventStartDate,
      ];
}
