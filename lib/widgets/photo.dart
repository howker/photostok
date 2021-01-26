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
  }) : super(key: key);

  final String photoLink;
  final String placeholderColor;
  final bool isRounded;

  @override
  Widget build(BuildContext context) {
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
        borderRadius: BorderRadius.circular(17),
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
