import 'package:domain/domain.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:share_plus/share_plus.dart';

///
///A page to display the details of a photo.
///
class PhotoDetailPage extends StatefulWidget {
  final Photo photo;
  const PhotoDetailPage({super.key, required this.photo});

  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  bool isFavorite = false;
  bool isCollected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: widget.photo.id,
        child: Scaffold(
          backgroundColor: Colors.black45,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: Colors.transparent,
                child: ExtendedImage.network(
                  widget.photo.resourceUrl,
                  fit: BoxFit.contain,
                  //enableLoadState: false,
                  mode: ExtendedImageMode.gesture,
                  enableSlideOutPage: true,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      minScale: 0.9,
                      animationMinScale: 0.7,
                      maxScale: 3.0,
                      animationMaxScale: 3.5,
                      speed: 1.0,
                      inertialSpeed: 100.0,
                      initialScale: 1.0,
                      inPageView: false,
                      initialAlignment: InitialAlignment.center,
                    );
                  },
                ),

                // You can also use a color instead of an image
              ),
              // Bottom actions and author info
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Author info
                      Text(
                        'Photo by ${widget.photo.user.name}',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(
                            icon: Icons.favorite,
                            color: isFavorite ? Colors.red : Colors.white,
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                              // TODO: Implement favorite functionality
                            },
                          ),
                          _buildActionButton(
                            icon: Icons.collections_bookmark,
                            color: isCollected ? Colors.yellow : Colors.white,
                            onPressed: () {
                              setState(() {
                                isCollected = !isCollected;
                              });
                              // TODO: Implement collect functionality
                            },
                          ),
                          _buildActionButton(
                            icon: Icons.share,
                            onPressed: () {
                              Share.share(widget.photo.links.html);
                            },
                          ),
                          _buildActionButton(
                            icon: Icons.file_download,
                            onPressed: () async {
                              var file = await DefaultCacheManager()
                                  .getSingleFile(widget.photo.resourceUrl);
                              await ImageGallerySaver.saveFile(file.path);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Image saved to gallery')),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color color = Colors.white,
  }) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
    );
  }
}
