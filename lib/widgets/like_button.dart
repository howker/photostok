import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/widgets/error_loading_banner.dart';

/// Кнопка лайк не-лайк фотографии
class LikeButton extends StatelessWidget {
  final Photo photo;

  const LikeButton({Key key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cubit = BlocProvider.of<PhotoCubit>(context);
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (context, state) {
        if (state is PhotosLoadSuccess || state is SearchPhotoLoadSuccess)
          return GestureDetector(
            onTap: () {
              photo.likedByUser
                  ? _cubit.unlikePhoto(photo)
                  : _cubit.likePhoto(photo);
            },
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 23.3),
                  Icon(photo.likedByUser ? AppIcons.like_fill : AppIcons.like),
                  const SizedBox(width: 4.21),
                  Text(
                    photo.likes.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      height: 16 / 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        else if (state is PhotosLoadFailure)
          return ErrorLoadingBanner();
        else
          return Center(
            child: Text(
                'detail photo screen error, state is $state'), //TODO remoove
          );
      },
    );
  }
}
