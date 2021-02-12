import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/user_state.dart';
import 'package:photostok/repository/photo_repository.dart';

class UserCubit extends Cubit<UserState> {
  final PhotoRepository photoRepository;

  UserCubit(this.photoRepository) : super(null);

  Future fetchMyProfile() async {
    try {
      final userProfile = await photoRepository.getMyProfile();

      emit(UserProfileLoadSuccess(userProfile));
    } catch (e) {
      emit(UserProfileLoadFailure());
    }
  }

  Future fetchUserProfile(String userName) async {
    try {
      final userProfile = await photoRepository.getUserProfile(userName);

      emit(UserProfileLoadSuccess(userProfile));
    } catch (e) {
      emit(UserProfileLoadFailure());
    }
  }
}
