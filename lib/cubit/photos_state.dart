import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:photostok/models/photo_list.dart';
import 'package:photostok/models/related_photo_list.dart';

@immutable
abstract class PhotoState extends Equatable {
  const PhotoState();
  @override
  List<Object> get props => [];
}

class PhotosLoadSuccess extends PhotoState {
  final PhotoList photoList;

  const PhotosLoadSuccess({this.photoList});

  @override
  List<Object> get props => [photoList, this.photoList];

  PhotosLoadSuccess copyWith({
    PhotoList photoList,
  }) {
    return PhotosLoadSuccess(
      photoList: photoList ?? this.photoList,
    );
  }
}

class PhotosInitial extends PhotoState {
  @override
  List<Object> get props => [];
}

class PhotosLoadFailure extends PhotoState {
  final String errorMessage;
  PhotosLoadFailure(this.errorMessage);

  @override
  List<Object> get props => [];
}

class LikePhotoFailure extends PhotoState {
  LikePhotoFailure();

  @override
  List<Object> get props => [];
}

class SearchPhotoLoadSuccess extends PhotoState {
  final RelatedPhotoList searchPhotoList;

  SearchPhotoLoadSuccess({this.searchPhotoList});

  @override
  List<Object> get props => [searchPhotoList, this.searchPhotoList];

  SearchPhotoLoadSuccess copyWith({
    RelatedPhotoList searchPhotoList,
  }) {
    return SearchPhotoLoadSuccess(
      searchPhotoList: searchPhotoList ?? this.searchPhotoList,
    );
  }
}

class SearchPhotoLoadFailure extends PhotoState {
  @override
  List<Object> get props => [];
}

class LikePhotoSuccess extends PhotoState {
  final bool isLike;

  LikePhotoSuccess({
    this.isLike,
  });

  @override
  List<Object> get props => [];

  LikePhotoSuccess copyWith({
    bool isLike,
  }) {
    return LikePhotoSuccess(
      isLike: isLike ?? this.isLike,
    );
  }
}
