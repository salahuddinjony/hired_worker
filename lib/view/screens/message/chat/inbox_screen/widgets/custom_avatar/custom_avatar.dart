import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double size;
  final double fontSize;
  final EdgeInsetsGeometry? padding;

  const CustomAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.size = 40,
    this.fontSize = 16,
    this.padding,
  });

  Color getColorFromName(String name) {
    final List<Color> colors = [
      const Color(0xFF9C27B0), // Purple
      const Color(0xFF673AB7), // Deep Purple
      const Color(0xFF3F51B5), // Indigo
      const Color(0xFF2196F3), // Blue
      const Color(0xFF00BCD4), // Cyan
      const Color(0xFF009688), // Teal
      const Color(0xFF4CAF50), // Green
      const Color(0xFFFF9800), // Orange
      const Color(0xFFFF5722), // Deep Orange
      const Color(0xFF795548), // Brown
    ];

    int hash = 0;
    for (int i = 0; i < name.length; i++) {
      hash = name.codeUnitAt(i) + ((hash << 5) - hash);
    }
    return colors[hash.abs() % colors.length];
  }

  Widget buildFallbackAvatar(String firstLetter) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: getColorFromName(name),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          firstLetter,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValidImage =
        imageUrl != null && imageUrl!.isNotEmpty && imageUrl != 'null';
    final String firstLetter = name.isNotEmpty ? name[0].toUpperCase() : 'U';

    Widget avatar;

    if (hasValidImage) {
      avatar = ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          height: size,
          width: size,
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: getColorFromName(name),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SizedBox(
                    width: size * 0.4,
                    height: size * 0.4,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          errorWidget:
              (context, url, error) => buildFallbackAvatar(firstLetter),
        ),
      );
    } else {
      avatar = buildFallbackAvatar(firstLetter);
    }

    if (padding != null) {
      return Padding(padding: padding!, child: avatar);
    }

    return avatar;
  }
}
