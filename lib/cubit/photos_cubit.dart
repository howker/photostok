import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/repository/photo_repository.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final PhotoRepository photoRepository;
  PhotoList photoList;

  PhotoCubit(this.photoRepository) : super(PhotosInitial());

  Future fetchAllPhotos(int page, int perPage) async {
    try {
      final photos = await photoRepository.getPhotos(page, perPage);
      photoList = photos;
      emit(PhotosLoadSuccess().copyWith(photoList: photoList));
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

      for (int i = 0; i < photoList.photos.length; i++) {
        if (photo.id == photoList.photos[i].id) {
          index = i;
          break;
        }
      }

      if (index != null) {
        photoList.photos[index].likedByUser = true;
        photoList.photos[index].likes += 1;
      }

      emit(PhotosLoadSuccess().copyWith(photoList: photoList));
    } catch (e) {
      emit(LikePhotoFailure());
    }
  }

  Future unlikePhoto(Photo photo) async {
    try {
      await PhotoRepository.unlikePhoto(photo.id);
      int index;
      for (int i = 0; i < photoList.photos.length; i++) {
        if (photo.id == photoList.photos[i].id) {
          index = i;
          break;
        }
      }
      photoList.photos[index].likedByUser = false;
      photoList.photos[index].likes -= 1;

      emit(PhotosLoadSuccess().copyWith(photoList: photoList));
    } catch (e) {
      emit(PhotosLoadFailure(e.toString()));
    }
  }
}
