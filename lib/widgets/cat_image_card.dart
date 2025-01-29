import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CatImageCard extends StatefulWidget {
  final String imageUrl;
  final VoidCallback onPressed;

  const CatImageCard({
    super.key,
    required this.imageUrl,
    required this.onPressed,
  });

  @override
  State<CatImageCard> createState() => _CatImageCardState();
}

class _CatImageCardState extends State<CatImageCard> {
  bool isFavorite = false;
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
              child: CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: widget.imageUrl,
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
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  widget.onPressed();
                },
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
