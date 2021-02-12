import 'package:photostok/models/user_profile.dart';

abstract class UserState {}

class UserProfileLoadSuccess extends UserState {
  final UserProfile userProfile;

  UserProfileLoadSuccess(this.userProfile);
}

class UserProfileLoadFailure extends UserState {}
