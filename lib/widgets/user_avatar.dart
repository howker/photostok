import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///Аватар пользователя
class UserAvatar extends StatelessWidget {
  UserAvatar({this.avatarLink, this.width, this.height});

  final String avatarLink;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CachedNetworkImage(
          width: width ?? 40,
          height: height ?? 40,
          imageUrl: avatarLink,
          fit: BoxFit.fill),
    );
  }
}
