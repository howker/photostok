import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/repository/photo_repository.dart';

class PhotoCubit extends Cubit<PhotosState> {
  final PhotoRepository photoRepository;
  PhotoList photoList;

  PhotoCubit(this.photoRepository) : super(PhotosLoading());

  Future fetchAllPhotos(int page, int perPage) async {
    try {
      emit(PhotosLoading());
      photoList = await photoRepository.getPhotos(page, perPage);
      emit(state.copyWith(photoList: photoList));
    } catch (_) {
      emit(PhotosLoadFailure());
    }
  }

  Future likePhoto(Photo photo) async {
    try {
      await photoRepository.likePhoto(photo.id);
      int index;

      for (int i = 0; i < photoList.photos.length; i++) {
        if (photo.id == photoList.photos[i].id) {
          index = i;
          break;
        }
      }
      if (index != null) {
        photoList.photos[index] = photoList.photos[index].copyWith(
          likes: photoList.photos[index].likes + 1,
          likedByUser: !photoList.photos[index].likedByUser,
        );
        print(state.copyWith(photoList: photoList) == photoList);

        emit(state.copyWith(photoList: photoList));

        //state.copyWith(photoList: photoList),

      }

      // } else if (index == null && relatedPhotoList.results.length != 0) {
      //   for (int i = 0; i < relatedPhotoList.results.length; i++) {
      //     if (photo.id == relatedPhotoList.results[i].id) {
      //       index = i;
      //       break;
      //     }
      //   }
      //   if (index != null) {
      //     relatedPhotoList.results[index].likedByUser = true;
      //     relatedPhotoList.results[index].likes += 1;
      //     emit(LikePhotoSuccess().copyWith(isLike: true));
      //     emit(SearchPhotoLoadSuccess()
      //         .copyWith(searchPhotoList: relatedPhotoList));
      //   }
      // }

    } catch (_) {
      emit(PhotosLoadFailure());
    }
  }

  Future unlikePhoto(Photo photo) async {
    try {
      await photoRepository.unlikePhoto(photo.id);
      int index;

      for (int i = 0; i < photoList.photos.length; i++) {
        if (photo.id == photoList.photos[i].id) {
          index = i;
          break;
        }
      }
      if (index != null) {
        photoList.photos[index] = photoList.photos[index].copyWith(
          likes: photoList.photos[index].likes - 1,
          likedByUser: !photoList.photos[index].likedByUser,
        );
        print(state.copyWith(photoList: photoList) == photoList);
        emit(
          state.copyWith(photoList: photoList),
        );
      }

      //   try {
      //     await photoRepository.unlikePhoto(photo.id);
      //     int index;

      //     for (int i = 0; i < photoList.photos.length; i++) {
      //       if (photo.id == photoList.photos[i].id) {
      //         index = i;
      //         break;
      //       }
      //     }
      //     if (index != null) {
      //       photoList.photos[index].likedByUser = false;
      //       photoList.photos[index].likes -= 1;
      //       emit(LikePhotoSuccess().copyWith(isLike: false));
      //       emit(PhotosLoadSuccess().copyWith(photoList: photoList));
      //     } else if (index == null && relatedPhotoList.results.length != 0) {
      //       for (int i = 0; i < relatedPhotoList.results.length; i++) {
      //         if (photo.id == relatedPhotoList.results[i].id) {
      //           index = i;
      //           break;
      //         }
      //       }
      //       if (index != null) {
      //         relatedPhotoList.results[index].likedByUser = false;
      //         relatedPhotoList.results[index].likes -= 1;
      //         emit(LikePhotoSuccess().copyWith(isLike: false));
      //         emit(SearchPhotoLoadSuccess()
      //             .copyWith(searchPhotoList: relatedPhotoList));
      //       }
      //     }
    } catch (_) {
      emit(PhotosLoadFailure());
    }
  }
}
