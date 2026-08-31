import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/asset_model.dart';
import '../../constants/consts.dart';

class AssetRepository {
  AssetRepository({http.Client? client}) : _client = client ?? http.Client();

  static const _searchUrl =
      'https://api.marketplace.ritchiebros.com/marketplace-listings-service/v1/api/search';

  final http.Client _client;

  Future<List<Asset>> fetchAssets({
    int offset = 0,
    int limit = Consts.pageSize,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(_searchUrl),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({'from': offset, 'size': limit}),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to fetch assets: HTTP ${response.statusCode}',
        );
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final records = body['records'] as List<dynamic>? ?? const [];

      return [
        for (final item in records)
          if (item is Map<String, dynamic>) Asset.fromJson(item),
      ];
    } catch (error, stackTrace) {
      if (error is Exception) {
        Error.throwWithStackTrace(error, stackTrace);
      }
      throw Exception('Failed to fetch assets: $error');
    }
  }
}
