import 'package:flutter/foundation.dart';
import 'package:photostok/models/photo_list.dart';

@immutable
abstract class LikeState {}

class PhotoLiked extends LikeState {
  final Photo photo;

  PhotoLiked(this.photo);
}

class PhotoUnliked extends LikeState {
  final Photo photo;

  PhotoUnliked(this.photo);
}

class LikeError extends LikeState {
  final String errorMessage;

  LikeError(this.errorMessage);
}

class PhotoLikeSuccess extends LikeState {
  final Photo photo;

  PhotoLikeSuccess(this.photo);
}

class PhotoLikedInitState extends LikeState {}
