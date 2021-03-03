import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/related_photo_state.dart';
import 'package:photostok/repository/photo_repository.dart';

class RelatedPhotoCubit extends Cubit<RelatedPhotoState> {
  RelatedPhotoCubit(this.photoRepository) : super(RelatedPhotoLoading());

  final PhotoRepository photoRepository;

  Future fetchRelatedPhotos(String photoId) async {
    emit(RelatedPhotoLoading());
    try {
      photoRepository.relatedPhotoList =
          await photoRepository.getRelatedPhotos(photoId);

      emit(state.copyWith(relatedPhotoList: photoRepository.relatedPhotoList));
    } catch (_) {
      emit(RelatedPhotoLoadFailure());
    }
  }
}
