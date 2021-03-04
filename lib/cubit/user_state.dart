import 'package:equatable/equatable.dart';
import 'package:photostok/models/user_profile.dart';

class UserState extends Equatable {
  final UserProfile userProfile;

  UserState({this.userProfile});

  @override
  List<Object> get props => [userProfile, this.userProfile];
  UserState copyWith({
    UserProfile userProfile,
  }) {
    return UserState(userProfile: userProfile ?? this.userProfile);
  }
}

class UserProfileLoading extends UserState {}

class UserProfileLoadFailure extends UserState {}
