import 'package:photostok/models/photo_list.dart';
import 'package:photostok/models/user_collection.dart';
import 'package:photostok/models/user_profile.dart';

abstract class UserState {}

class UserProfileLoadSuccess extends UserState {
  final UserProfile userProfile;

  UserProfileLoadSuccess(this.userProfile);
}

class UserProfileLoadFailure extends UserState {}

class UserCollectionsLoadSuccess extends UserState {
  final UserCollectionList userCollectionList;

  UserCollectionsLoadSuccess(this.userCollectionList);
}

class UserCollectionsLoadFailure extends UserState {}

class UserCollectionsPhotoLoadSuccess extends UserState {
  final PhotoList photoList;

  UserCollectionsPhotoLoadSuccess(this.photoList);
}

class UserCollectionsPhotoLoadFailure extends UserState {}
