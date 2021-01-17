import 'package:photostok/res/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoView extends StatelessWidget {
  PhotoView({
    Key key,
    this.photoLink,
    this.placeholderColor,
    this.photoWidth,
    this.photoHeigh,
  }) : super(key: key);

  final String photoLink;
  final String placeholderColor;
  final double photoWidth, photoHeigh;

  @override
  Widget build(BuildContext context) {
    var color = '0xFF${placeholderColor.replaceAll(RegExp(r"[#]"), '')}';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        color: AppColors.grayChateau,
        child: CachedNetworkImage(
          imageUrl: photoLink,
          fit: BoxFit.fill,
          placeholder: (context, url) => Center(
            child: Container(
              height: photoHeigh,
              width: photoWidth,
              color: Color(int.parse(color)),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
