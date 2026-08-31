import 'package:flutter/material.dart';

class AssetImageFallback extends StatelessWidget {
  const AssetImageFallback({super.key});

  @override
  Widget build(BuildContext context) {
    final fallbackColor = ColorScheme.of(context).surfaceContainerHighest;

    return ColoredBox(
      color: fallbackColor,
      child: const Center(
        child: Icon(Icons.image_not_supported_outlined),
      ),
    );
  }
}
