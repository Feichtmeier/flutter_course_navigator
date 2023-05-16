import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.index,
    this.height = 50,
    this.width = 50,
  });

  final int index;
  final int height;
  final int width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget container({Widget? child}) => Container(
          width: width.toDouble(),
          height: height.toDouble(),
          color: theme.colorScheme.background,
          child: child,
        );

    final fallBack = Shimmer.fromColors(
      baseColor: theme.colorScheme.onSurface.withOpacity(0.05),
      highlightColor: theme.colorScheme.onSurface.withOpacity(0.1),
      child: container(),
    );

    return Card(
      margin: EdgeInsets.zero,
      elevation: 3.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          'https://picsum.photos/$width/$height?image=$index',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return container(
              child: Icon(
                Icons.broken_image,
                size: width / 3,
              ),
            );
          },
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return frame == null ? fallBack : child;
          },
        ),
      ),
    );
  }
}
