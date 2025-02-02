import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CatImageCard extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onPressed;
  final bool isFavorite;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const CatImageCard({
    super.key,
    required this.imageUrl,
    required this.onPressed,
    required this.isFavorite,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: AnimatedSize(
        duration: const Duration(microseconds: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: GestureDetector(
                onTap: onTap,
                child: CachedNetworkImage(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: imageUrl,
                  placeholder: (context, url) => const Skeletonizer(
                    enabled: true,
                    child: Skeleton.replace(
                      replacement: Bone(
                        width: double.infinity,
                        height: 200,
                      ),
                      child: SizedBox(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  icon,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
