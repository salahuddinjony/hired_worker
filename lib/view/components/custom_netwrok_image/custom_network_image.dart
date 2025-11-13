import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShape boxShape;
  final Color? backgroundColor;
  final Widget? child;
  final ColorFilter? colorFilter;
  final BoxFit fit;
  const CustomNetworkImage({
    super.key,
    this.child,
    this.colorFilter,
    required this.imageUrl,
    this.backgroundColor,
    required this.height,
    required this.width,
    this.border,
    this.borderRadius,
    this.boxShape = BoxShape.rectangle,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    // Add debug print and validation
    debugPrint("CustomNetworkImage loading URL: '$imageUrl'");

    // Check if URL is empty or invalid
    if (imageUrl.isEmpty || imageUrl == 'null') {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          color: Colors.grey.withValues(alpha: 0.6),
          borderRadius: borderRadius,
          shape: boxShape,
        ),
        child: Center(
          child: child ?? const Icon(Icons.person, color: Colors.white),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        debugPrint("SUCCESS: Image loaded successfully for URL: $imageUrl");
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: border,
            borderRadius: borderRadius,
            shape: boxShape,
            color: backgroundColor,
          ),
          child: Stack(
            children: [
              // Background image
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  shape: boxShape,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                    colorFilter: colorFilter,
                  ),
                ),
              ),
              // Overlay child (like AppBar)
              if (child != null) child!,
            ],
          ),
        );
      },
      placeholder:
          (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey.withValues(alpha: 0.6),
            highlightColor: Colors.grey.withValues(alpha: 0.3),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: border,
                color: Colors.grey.withValues(alpha: 0.6),
                borderRadius: borderRadius,
                shape: boxShape,
              ),
              child: child,
            ),
          ),
      errorWidget: (context, url, error) {
        debugPrint("Error loading image: $error");
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: border,
            color: Colors.grey.withValues(alpha: 0.6),
            borderRadius: borderRadius,
            shape: boxShape,
          ),
          child: child ?? const Icon(Icons.person, color: Colors.white),
        );
      },
    );
  }
}

class CustomNetworkImage2 extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final Border? border;
  final BoxShape boxShape;
  final Color? backgroundColor;
  final Widget? child;
  final ColorFilter? colorFilter;

  const CustomNetworkImage2({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.child,
    this.colorFilter,
    this.backgroundColor,
    this.border,
    this.boxShape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      // Ensures image is properly circular without unwanted cropping
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder:
            (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: border,
                shape: boxShape,
                color: backgroundColor,
                image: DecorationImage(
                  image: imageProvider,
                  fit:
                      BoxFit
                          .contain, // Ensures the face is fully visible inside the circle
                  //  alignment: Alignment.center, // Centers the image
                  colorFilter: colorFilter,
                ),
              ),
              child: child,
            ),
        placeholder:
            (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.withValues(alpha: 0.6),
              highlightColor: Colors.grey.withValues(alpha: 0.3),
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  border: border,
                  color: Colors.grey.withValues(alpha: 0.6),
                  shape: boxShape,
                ),
                child: child,
              ),
            ),
        errorWidget:
            (context, url, error) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: border,
                color: Colors.grey.withValues(alpha: 0.6),
                shape: boxShape,
              ),
              child: const Icon(Icons.error),
            ),
      ),
    );
  }
}
