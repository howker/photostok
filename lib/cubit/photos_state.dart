import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/models/related_photo_list.dart';

@immutable
abstract class PhotoState {}

class PhotosLoadSuccess extends PhotoState {
  final PhotoList photoList;

  PhotosLoadSuccess({this.photoList});

  PhotosLoadSuccess copyWith({
    PhotoList photoList,
  }) {
    return PhotosLoadSuccess(photoList: photoList ?? this.photoList);
  }
}

class PhotosInitial extends PhotoState {}

class PhotosLoadFailure extends PhotoState {
  final String errorMessage;
  PhotosLoadFailure(this.errorMessage);
}

class LikePhotoFailure extends PhotoState {
  LikePhotoFailure();
}

class SearchPhotoLoadSuccess extends PhotoState {
  final RelatedPhotoList searchPhotoList;

  SearchPhotoLoadSuccess({this.searchPhotoList});
}

class SearchPhotoLoadFailure extends PhotoState {}
