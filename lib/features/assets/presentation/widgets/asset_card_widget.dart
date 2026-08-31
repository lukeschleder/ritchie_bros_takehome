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
    final colorScheme = ColorScheme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: Consts.cardMarginHorizontal,
        vertical: Consts.cardMarginVertical,
      ),
      child: Row(
        children: [
          SizedBox(
            width: Consts.thumbnailSize,
            height: Consts.thumbnailSize,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const AssetImageFallback(),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return ColoredBox(
                  color: ColorScheme.of(context).surfaceContainerHighest,
                );
              },
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
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                    maxLines: Consts.descriptionMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Consts.spaceAfterTitle),
                  _MetaLine(
                    icon: Icons.location_on_outlined,
                    text: location,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: Consts.spaceBetweenDetails),
                  _MetaLine(
                    icon: Icons.gavel_outlined,
                    text: eventName,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: Consts.spaceAfterTitle),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(Consts.cardRadius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Consts.dateChipHorizontalPadding,
                        vertical: Consts.dateChipVerticalPadding,
                      ),
                      child: Text(
                        date,
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({
    required this.icon,
    required this.text,
    required this.style,
  });

  final IconData icon;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: Consts.metaIconSize,
          color: style?.color,
        ),
        const SizedBox(width: Consts.spaceBetweenDetails),
        Expanded(
          child: Text(
            text,
            style: style,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
