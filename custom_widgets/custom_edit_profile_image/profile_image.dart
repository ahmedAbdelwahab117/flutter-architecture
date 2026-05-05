import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../shared/resources/assets_manager.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.image, this.size = 100});

  final String image;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      imageUrl: image,
      width: size,
      height: size,
      errorWidget: (context, url, error) => Image.network(
       'https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg?t=st=1740480586~exp=1740484186~hmac=1cf1546e6d2d267a76b1f7bfa444251e73cfdd693ad80263cd9c296503d04f6b&w=740'
      ,
          width: size, height: size, fit: BoxFit.cover),
    );
  }
}
