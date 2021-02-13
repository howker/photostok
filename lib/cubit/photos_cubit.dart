import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/repository/photo_repository.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final PhotoRepository photoRepository;

  PhotoCubit(this.photoRepository) : super(PhotosInitial());

  Future fetchAllPhotos(int page, int perPage) async {
    try {
      photoRepository.photoList =
          await photoRepository.getPhotos(page, perPage);
      // photoList = photos;
      emit(PhotosLoadSuccess().copyWith(photoList: photoRepository.photoList));
    } catch (e) {
      emit(PhotosLoadFailure(e.toString()));
    }
  }

  Future fetchSearchPhotos(String query) async {
    try {
      final searchPhotos = await photoRepository.getSearchPhotos(1, 15, query);

      emit(SearchPhotoLoadSuccess(searchPhotoList: searchPhotos));
    } catch (e) {
      emit(SearchPhotoLoadFailure());
    }
  }

  Future likePhoto(Photo photo) async {
    try {
      await PhotoRepository.likePhoto(photo.id);
      int index;

      for (int i = 0; i < photoRepository.photoList.photos.length; i++) {
        if (photo.id == photoRepository.photoList.photos[i].id) {
          index = i;
          break;
        }
      }

      if (index != null) {
        photoRepository.photoList.photos[index].likedByUser = true;
        photoRepository.photoList.photos[index].likes += 1;
      }

      emit(PhotosLoadSuccess().copyWith(photoList: photoRepository.photoList));
    } catch (e) {
      emit(LikePhotoFailure());
    }
  }

  Future unlikePhoto(Photo photo) async {
    try {
      await PhotoRepository.unlikePhoto(photo.id);
      int index;
      for (int i = 0; i < photoRepository.photoList.photos.length; i++) {
        if (photo.id == photoRepository.photoList.photos[i].id) {
          index = i;
          break;
        }
      }
      photoRepository.photoList.photos[index].likedByUser = false;
      photoRepository.photoList.photos[index].likes -= 1;

      emit(PhotosLoadSuccess().copyWith(photoList: photoRepository.photoList));
    } catch (e) {
      emit(PhotosLoadFailure(e.toString()));
    }
  }
}
