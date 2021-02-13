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
  final int index;
  const LikeButton({this.photo, this.index});

  @override
  Widget build(BuildContext context) {
    final _cubit = BlocProvider.of<PhotoCubit>(context);
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (context, state) {
        if (state is PhotosLoadSuccess)
          return GestureDetector(
            onTap: () {
              state.photoList.photos[index].likedByUser
                  ? _cubit.unlikePhoto(photo)
                  : _cubit.likePhoto(photo);
            },
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 23.3),
                  Icon(state.photoList.photos[index].likedByUser
                      ? AppIcons.like_fill
                      : AppIcons.like),
                  const SizedBox(width: 4.21),
                  Text(
                    state.photoList.photos[index].likes.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                  ),
                ],
              ),
            ),
          );
        if (state is SearchPhotoLoadSuccess)
          return GestureDetector(
            onTap: () {
              state.searchPhotoList.results[index].likedByUser
                  ? _cubit.unlikePhoto(photo)
                  : _cubit.likePhoto(photo);
            },
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 23.3),
                  Icon(state.searchPhotoList.results[index].likedByUser
                      ? AppIcons.like_fill
                      : AppIcons.like),
                  const SizedBox(width: 4.21),
                  Text(
                    state.searchPhotoList.results[index].likes.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                  ),
                ],
              ),
            ),
          );
        else if (state is PhotosLoadFailure) return ErrorLoadingBanner();
        return ErrorLoadingBanner();
      },
    );
  }
}
