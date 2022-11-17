import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageFullScreens extends StatelessWidget {
  final String image;
  const ImageFullScreens({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(image),
        ),
      ),
    );
  }
}
