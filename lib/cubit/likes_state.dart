import 'package:flutter/foundation.dart';
import 'package:photostok/models/photo_list.dart';

@immutable
abstract class LikeState {}

class PhotoLiked extends LikeState {
  final int likeCount;

  PhotoLiked(this.likeCount);

  // TODO final Photo photo;

  // PhotoLiked(this.photo);
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
