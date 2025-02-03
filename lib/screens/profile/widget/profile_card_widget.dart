import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget {
  final String? image;
  final String? username;
  final String? email;
  final VoidCallback onPressed;

  const ProfileCardWidget({
    super.key,
    required this.image,
    required this.username,
    required this.email,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (image != null)
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  50,
                ),
                child: CachedNetworkImage(
                  imageUrl: image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(
            height: 40,
          ),
          Text(
            username ?? 'Unknown',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            email ?? 'No email',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
