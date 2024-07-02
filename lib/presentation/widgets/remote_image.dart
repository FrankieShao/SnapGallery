import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class RemoteImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String? placeholder;

  RemoteImage(
      {this.url,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.placeholder});

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url == null ? "" : url!,
      width: width,
      height: height,
      fit: fit,
      loadStateChanged: (ExtendedImageState state) {
        return _networkLoadState(state);
      },
    );
  }

  Widget? _networkLoadState(ExtendedImageState state) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        if (placeholder != null) {
          return Image.asset(placeholder!);
        } else {
          return Container(
            color: Colors.grey.shade300, // Grey background
          );
        }
      case LoadState.completed:
        return null;
      case LoadState.failed:
        if (placeholder != null) {
          return Image.asset(placeholder!);
        } else {
          return Container(
            color: Colors.grey.shade300, // Grey background
          );
        }
    }
  }
}
