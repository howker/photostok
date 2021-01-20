import 'package:flutter/cupertino.dart';

@immutable
abstract class LikeState {}

class PhotoLiked extends LikeState {
  final int likeCount;

  PhotoLiked(this.likeCount);
}

class PhotoUnliked extends LikeState {
  final int likeCount;

  PhotoUnliked(this.likeCount);
}

class LikeError extends LikeState {
  final String errorMessage;

  LikeError(this.errorMessage);
}

class PhotoLikedInitState extends LikeState {}
