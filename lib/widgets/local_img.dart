import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class LocalImageWidget extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;

  const LocalImageWidget({
    required this.imagePath,
    this.width,
    this.height,
    this.fit,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: DefaultCacheManager().getSingleFile(imagePath),
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Image.file(
              snapshot.data!,
              width: width,
              height: height,
              fit: fit,
              color: color,
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
        }
        return SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
