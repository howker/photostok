import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:photostok/models/photo_list.dart';

@immutable
class PhotosState extends Equatable {
  final PhotoList photoList;

  const PhotosState({
    this.photoList,
  });

  @override
  List<Object> get props => [photoList];

  PhotosState copyWith({PhotoList photoList}) {
    return PhotosState(
      photoList: photoList ?? this.photoList,
    );
  }
}

class PhotosLoading extends PhotosState {}

class PhotosLoadFailure extends PhotosState {}
