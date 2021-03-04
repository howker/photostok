import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/user_state.dart';
import 'package:photostok/repository/photo_repository.dart';

class UserCubit extends Cubit<UserState> {
  final PhotoRepository photoRepository;

  UserCubit(this.photoRepository) : super(UserProfileLoading());

  Future fetchMyProfile() async {
    try {
      emit(UserProfileLoading());

      final userProfile = await photoRepository.getMyProfile();

      emit(state.copyWith(userProfile: userProfile));
    } catch (_) {
      emit(UserProfileLoadFailure());
    }
  }

  Future fetchUserProfile(String userName) async {
    try {
      emit(UserProfileLoading());

      final userProfile = await photoRepository.getUserProfile(userName);

      emit(state.copyWith(userProfile: userProfile));
    } catch (_) {
      emit(UserProfileLoadFailure());
    }
  }
}
