import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/likes_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/repository/photo_repository.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit(LikeState state) : super(PhotoLikedInitState());

  Future likePhoto(String photoId) async {
    try {
      await PhotoRepository.likePhoto(photoId);
      Photo photoById = await PhotoRepository.getPhotoById(photoId);
      emit(PhotoLikeSuccess(photoById));
    } catch (e) {
      emit(LikeError(e.toString()));
    }
  }

  Future unLikePhoto(String photoId) async {
    try {
      await PhotoRepository.unlikePhoto(photoId);
      Photo photoById = await PhotoRepository.getPhotoById(photoId);
      emit(PhotoLikeSuccess(photoById));
    } catch (e) {
      emit(LikeError(e.toString()));
    }
  }

  setInitLikeState() {
    try {
      emit(PhotoLikedInitState());
    } catch (e) {
      emit(LikeError(e.toString()));
    }
  }
}
