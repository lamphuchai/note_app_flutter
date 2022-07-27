import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage(
      {Key? key, required this.imageUrl, this.fit, this.width, this.height})
      : super(key: key);
  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => Container(
        height: width,
        width: height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: const Center(
            child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Colors.grey,
          ),
        )),
      ),
      errorWidget: (context, url, error) => SizedBox(
          height: height,
          width: width,
          child: const Center(
              child: Icon(
            Icons.error,
            color: Colors.red,
          ))),
    );
  }
}
