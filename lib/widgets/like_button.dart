import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/likes_cubit.dart';
import 'package:photostok/cubit/likes_state.dart';
import 'package:photostok/res/res.dart';

class LikeButton extends StatelessWidget {
  LikeButton({
    this.likeCount = 0,
    this.isLiked = false,
    this.photoId,
  });

  final int likeCount;
  final bool isLiked;
  final String photoId;

  @override
  Widget build(BuildContext context) {
    final _cubit = BlocProvider.of<LikeCubit>(context);
    //_cubit.setInitLikeState();
    return BlocBuilder<LikeCubit, LikeState>(
      builder: (context, state) {
        if (state is PhotoLikeSuccess) {
          return GestureDetector(
            onTap: () {
              state.photo.likedByUser
                  ? _cubit.unLikePhoto(photoId)
                  : _cubit.likePhoto(photoId);
              _cubit.setInitLikeState();
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(state.photo.likedByUser
                        ? AppIcons.like_fill
                        : AppIcons.like),
                    SizedBox(width: 4.21),
                    Text(
                      state.photo.likes.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF000000),
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
            ),
          );
        } else if (state is PhotoLikedInitState) {
          return GestureDetector(
            onTap: () {
              isLiked ? _cubit.unLikePhoto(photoId) : _cubit.likePhoto(photoId);
              //_cubit.setInitLikeState();
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(isLiked ? AppIcons.like_fill : AppIcons.like),
                    SizedBox(width: 4.21),
                    Text(
                      likeCount.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF000000),
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
            ),
          );
        } else
          return Container();
      },
    );
  }
}
