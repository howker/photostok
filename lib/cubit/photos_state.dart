import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:photostok/models/photo_list.dart';

@immutable
abstract class PhotoState {}

class PhotosLoadSuccess extends PhotoState {
  final UnmodifiableListView<Photo> photoList;
  PhotosLoadSuccess({this.photoList});

  //final UnmodifiableListView<PhotoList> photoList;
}

class PhotosInitial extends PhotoState {}

class PhotosLoadFailure extends PhotoState {
  final String errorMessage;
  PhotosLoadFailure(this.errorMessage);
}
