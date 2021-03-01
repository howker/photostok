import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:photostok/models/photo_list.dart';

@immutable
class PhotosLoadSuccess extends Equatable {
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

class PhotosInitial {}

class PhotosLoadFailure {
  final String errorMessage;
  PhotosLoadFailure(this.errorMessage);
}
