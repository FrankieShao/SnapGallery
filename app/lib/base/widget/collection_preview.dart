import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CollectionPreview extends StatelessWidget {
  final List<String> images;

  const CollectionPreview({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CachedNetworkImage(
            imageUrl: images.elementAtOrNull(0) ?? '',
            fit: BoxFit.cover,
            height: 220,
          ),
        ),
        const SizedBox(width: 4.0),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: images.elementAtOrNull(1) ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              Expanded(
                flex: 1,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: images.elementAtOrNull(2) ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
