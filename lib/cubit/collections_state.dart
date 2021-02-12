import 'package:photostok/models/photo_list.dart';
import 'package:photostok/models/user_collection.dart';

abstract class CollectionsState {}

class UserCollectionsLoadSuccess extends CollectionsState {
  final UserCollectionList userCollectionList;

  UserCollectionsLoadSuccess(this.userCollectionList);
}

class UserCollectionsLoadFailure extends CollectionsState {}

class UserCollectionsPhotoLoadSuccess extends CollectionsState {
  final PhotoList photoList;

  UserCollectionsPhotoLoadSuccess(this.photoList);
}

class UserCollectionsPhotoLoadFailure extends CollectionsState {}
