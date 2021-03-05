import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class LikeState extends Equatable {
  final bool isLike;

  const LikeState({this.isLike});

  @override
  List<Object> get props => [isLike];

  LikeState copyWith({
    bool isLike,
  }) {
    return LikeState(
      isLike: isLike ?? this.isLike,
    );
  }
}

class LikePhotoFailure extends LikeState {}
