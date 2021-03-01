import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/repository/photo_repository.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final PhotoRepository photoRepository;

  PhotoCubit(this.photoRepository) : super(PhotosInitial());

  Future fetchAllPhotos(int page, int perPage) async {
    try {
      emit(PhotosInitial());
      photoRepository.photoList =
          await photoRepository.getPhotos(page, perPage);
      emit(PhotosLoadSuccess().copyWith(photoList: photoRepository.photoList));
    } catch (e) {
      emit(PhotosLoadFailure(e.toString()));
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
        // photoRepository.photoList.photos[index].likedByUser = true;
        // photoRepository.photoList.photos[index].likes += 1;
        emit(LikePhotoSuccess().copyWith(isLike: true));
        emit(
            PhotosLoadSuccess().copyWith(photoList: photoRepository.photoList));
      } else if (index == null &&
          photoRepository.relatedPhotoList.results.length != 0) {
        for (int i = 0;
            i < photoRepository.relatedPhotoList.results.length;
            i++) {
          if (photo.id == photoRepository.relatedPhotoList.results[i].id) {
            index = i;
            break;
          }
        }
        if (index != null) {
          photoRepository.relatedPhotoList.results[index].likedByUser = true;
          photoRepository.relatedPhotoList.results[index].likes += 1;
          emit(LikePhotoSuccess().copyWith(isLike: true));
          emit(SearchPhotoLoadSuccess()
              .copyWith(searchPhotoList: photoRepository.relatedPhotoList));
        }
      }
    } catch (e) {
      emit(LikePhotoFailure());
    }
  }

  Future unlikePhoto(Photo photo) async {
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
        photoRepository.photoList.photos[index].likedByUser = false;
        photoRepository.photoList.photos[index].likes -= 1;
        emit(LikePhotoSuccess().copyWith(isLike: false));
        emit(
            PhotosLoadSuccess().copyWith(photoList: photoRepository.photoList));
      } else if (index == null &&
          photoRepository.relatedPhotoList.results.length != 0) {
        for (int i = 0;
            i < photoRepository.relatedPhotoList.results.length;
            i++) {
          if (photo.id == photoRepository.relatedPhotoList.results[i].id) {
            index = i;
            break;
          }
        }
        if (index != null) {
          photoRepository.relatedPhotoList.results[index].likedByUser = false;
          photoRepository.relatedPhotoList.results[index].likes -= 1;
          emit(LikePhotoSuccess().copyWith(isLike: false));
          emit(SearchPhotoLoadSuccess()
              .copyWith(searchPhotoList: photoRepository.relatedPhotoList));
        }
      }
    } catch (e) {
      emit(LikePhotoFailure());
    }
  }
}
