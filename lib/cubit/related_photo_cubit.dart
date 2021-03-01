import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/related_photo_state.dart';

class RelatedPhotoCubit extends Cubit<RelatedPhotoLoadSuccess> {
  RelatedPhotoCubit(RelatedPhotoLoadSuccess state) : super(state);

  Future fetchRelatedPhotos(String photoId) async {
    emit(PhotosInitial());
    try {
      photoRepository.relatedPhotoList =
          await photoRepository.getRelatedPhotos(photoId);

      emit(RelatedPhotoLoadSuccess()
          .copyWith(relatedPhotoList: photoRepository.relatedPhotoList));
    } catch (e) {
      emit(RelatedPhotoLoadFailure());
    }
  }
}
