import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/repository/photo_repository.dart';

class PhotoCubit extends Cubit<PhotosState> {
  final PhotoRepository photoRepository;

  PhotoCubit(this.photoRepository) : super(PhotosLoading());

  Future fetchAllPhotos(int page, int perPage) async {
    try {
      emit(PhotosLoading());
      photoRepository.photoList =
          await photoRepository.getPhotos(page, perPage);
      emit(state.copyWith(photoList: photoRepository.photoList));
    } catch (_) {
      emit(PhotosLoadFailure());
    }
  }
}
