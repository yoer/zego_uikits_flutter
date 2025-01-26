// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

String avatarURL(String userID) {
  return 'http://robohash.org/$userID.png';
}

Widget avatar(String userID) {
  return CachedNetworkImage(
    imageUrl: avatarURL(userID),
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        CircularProgressIndicator(value: downloadProgress.progress),
    errorWidget: (context, url, error) {
      return const Icon(Icons.person, color: Colors.blue);
    },
  );
}
