import 'package:flutter/material.dart';

import '../../constants/consts.dart';

class AssetErrorView extends StatelessWidget {
  const AssetErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = ColorScheme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Consts.errorViewPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: Consts.errorIconSize,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: Consts.errorRetrySpacing),
            Text(
              'Couldn\'t load assets',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Consts.spaceAfterTitle),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: Consts.errorRetrySpacing),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
