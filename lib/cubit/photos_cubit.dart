import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/repository/photo_repository.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final PhotoRepository photoRepository;
  PhotoList photoList;

  PhotoCubit(this.photoRepository) : super(PhotosInitial());

  Future fetchAllPhotos() async {
    try {
      //photoRepository.doLogin();
      final photos = await photoRepository.getPhotos(1, 2);
      photoList = photos;
      //var unmodifiableView = UnmodifiableListView(photos.photos);
      emit(PhotosLoadSuccess(photoList: photoList));
    } catch (e) {
      emit(PhotosLoadFailure(e.toString()));
    }
  }

  Future likePhoto(String photoId) async {
    try {
      await PhotoRepository.likePhoto(photoId);

      emit(PhotosLoadSuccess(photoList: photoList));
    } catch (e) {
      emit(PhotosLoadFailure(e.toString()));
    }
  }

  Future unlikePhoto(String photoId) async {
    try {
      await PhotoRepository.likePhoto(photoId);

      emit(PhotosLoadSuccess(photoList: photoList));
    } catch (e) {
      emit(PhotosLoadFailure(e.toString()));
    }
  }
}
