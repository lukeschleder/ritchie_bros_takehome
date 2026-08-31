import 'package:flutter/material.dart';

import '../../constants/consts.dart';
import 'asset_image_fallback.dart';

class AssetCardWidget extends StatelessWidget {
  const AssetCardWidget({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.location,
    required this.eventName,
    required this.date,
  });

  final String imageUrl;
  final String description;
  final String location;
  final String eventName;
  final String date;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: Consts.cardMarginHorizontal,
        vertical: Consts.cardMarginVertical,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Consts.thumbnailSize,
            height: Consts.thumbnailSize,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const AssetImageFallback(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Consts.cardContentPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: textTheme.titleMedium,
                    maxLines: Consts.descriptionMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Consts.spaceAfterTitle),
                  Text(location, style: textTheme.bodyMedium),
                  const SizedBox(height: Consts.spaceBetweenDetails),
                  Text(eventName, style: textTheme.bodySmall),
                  const SizedBox(height: Consts.spaceBetweenDetails),
                  Text(date, style: textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
