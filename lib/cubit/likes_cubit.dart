import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/likes_state.dart';
import 'package:photostok/repository/photo_repository.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit(LikeState state) : super(PhotoLikedInitState());

  Future likePhoto(String photoId, int likeCount) async {
    try {
      await PhotoRepository.likePhoto(photoId, likeCount);
      emit(PhotoLiked(likeCount + 1));
    } catch (e) {
      emit(LikeError(e.toString()));
    }
  }

  Future unLikePhoto(String photoId, int likeCount) async {
    try {
      await PhotoRepository.likePhoto(photoId, likeCount);
      emit(PhotoUnliked(likeCount - 1));
    } catch (e) {
      emit(LikeError(e.toString()));
    }
  }
}
