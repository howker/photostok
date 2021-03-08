// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:photostok/cubit/like_state.dart';
// import 'package:photostok/models/photo_list.dart';
// import 'package:photostok/repository/photo_repository.dart';

// class LikeCubit extends Cubit<LikeState> {
//   final bool isLiked;

//   LikeCubit(this.isLiked) : super(LikeState());

//   Future likePhoto(Photo photo) async {
//     try {
//       await PhotoRepository.likePhoto(photo.id);

//       emit(state.copyWith(isLike: true));
//     } catch (_) {
//       emit(LikePhotoFailure());
//     }
//   }

//   Future unlikePhoto(Photo photo) async {
//     try {
//       await PhotoRepository.unlikePhoto(photo.id);
//       // int index;

//       // for (int i = 0; i < photoRepository.photoList.photos.length; i++) {
//       //   if (photo.id == photoRepository.photoList.photos[i].id) {
//       //     index = i;
//       //     break;
//       //   }
//       // }
//       // if (index != null) {
//       //   photoRepository.photoList.photos[index].likedByUser = false;
//       //   photoRepository.photoList.photos[index].likes -= 1;
//       //   emit(LikePhotoSuccess().copyWith(isLike: false));
//       //   emit(
//       //       PhotosLoadSuccess().copyWith(photoList: photoRepository.photoList));
//       // } else if (index == null &&
//       //     photoRepository.relatedPhotoList.results.length != 0) {
//       //   for (int i = 0;
//       //       i < photoRepository.relatedPhotoList.results.length;
//       //       i++) {
//       //     if (photo.id == photoRepository.relatedPhotoList.results[i].id) {
//       //       index = i;
//       //       break;
//       //     }
//       //   }
//       //   if (index != null) {
//       //     photoRepository.relatedPhotoList.results[index].likedByUser = false;
//       //     photoRepository.relatedPhotoList.results[index].likes -= 1;
//       //     emit(LikePhotoSuccess().copyWith(isLike: false));
//       emit(state.copyWith(isLike: false));
//     } catch (_) {
//       emit(LikePhotoFailure());
//     }
//   }
// }
