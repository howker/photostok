import 'package:photostok/res/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///Виджет реализации отображения фотографии
class PhotoView extends StatelessWidget {
  PhotoView({
    Key key,
    this.photoLink,
    this.placeholderColor,
    this.isRounded,
    this.radiusPhoto,
  }) : super(key: key);

  final String photoLink;
  final String placeholderColor;
  final bool isRounded;
  final double radiusPhoto;

  @override
  Widget build(BuildContext context) {
    if (photoLink == null) return Container();
    var color = '0xFF${placeholderColor.replaceAll(RegExp(r"[#]"), '')}';
    if (!isRounded)
      return Container(
        color: AppColors.grayChateau,
        child: CachedNetworkImage(
          imageUrl: photoLink,
          fit: BoxFit.fill,
          placeholder: (context, url) => Center(
            child: Container(
              color: Color(int.parse(color)),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    else
      return ClipRRect(
        borderRadius: BorderRadius.circular(radiusPhoto ?? 17),
        child: Container(
          color: AppColors.grayChateau,
          child: CachedNetworkImage(
            imageUrl: photoLink,
            fit: BoxFit.fill,
            placeholder: (context, url) => Center(
              child: Container(
                color: Color(int.parse(color)),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      );
  }
}
