import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageTile extends StatelessWidget {
  final Photo photo;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;

  const ImageTile({
    super.key,
    required this.photo,
    this.onTap,
    this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double _width = constraints.maxWidth;
          double _height = photo.h * _width / photo.w;
          return Container(
            height: _height,
            width: _width,
            child: Hero(
                tag: photo.id,
                child: CachedNetworkImage(
                  imageUrl: photo.resourceUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )),
          );
        }));
  }
}
