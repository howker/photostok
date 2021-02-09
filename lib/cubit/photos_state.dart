import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/models/related_photo_list.dart';

@immutable
abstract class PhotoState extends Equatable {}

class PhotosLoadSuccess extends PhotoState {
  final PhotoList photoList;

  PhotosLoadSuccess({this.photoList});

  PhotosLoadSuccess copyWith({
    PhotoList photoList,
  }) {
    return PhotosLoadSuccess(photoList: photoList);
  }

  @override
  List<Object> get props => [photoList];
}

class PhotosInitial extends PhotoState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class PhotosLoadFailure extends PhotoState {
  final String errorMessage;
  PhotosLoadFailure(this.errorMessage);

  @override
  List<Object> get props => throw UnimplementedError();
}

class LikePhotoFailure extends PhotoState {
  LikePhotoFailure();

  @override
  List<Object> get props => throw UnimplementedError();
}

class SearchPhotoLoadSuccess extends PhotoState {
  final RelatedPhotoList searchPhotoList;

  SearchPhotoLoadSuccess({this.searchPhotoList});

  @override
  List<Object> get props => [searchPhotoList];
}

class SearchPhotoLoadFailure extends PhotoState {
  @override
  List<Object> get props => throw UnimplementedError();
}
