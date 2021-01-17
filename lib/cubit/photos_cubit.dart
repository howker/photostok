import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/repository/photo_repository.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final PhotoRepository photoRepository;

  PhotoCubit(this.photoRepository) : super(PhotosInitial());

  Future fetchAllPhotos() async {
    try {
      //photoRepository.doLogin();
      final photos = await photoRepository.getPhotos(1, 15);
      emit(PhotosLoadSuccess(photoList: photos));
    } catch (e) {
      emit(PhotosLoadFailure(e.toString()));
    }
  }
}
