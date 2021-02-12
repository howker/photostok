import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/collections_state.dart';
import 'package:photostok/repository/photo_repository.dart';

class CollectionsCubit extends Cubit<CollectionsState> {
  final PhotoRepository photoRepository;

  CollectionsCubit(this.photoRepository) : super(null);

  Future fetchUserCollections(int page, int perPage, String userName) async {
    try {
      final userCollectionList =
          await photoRepository.getUserCollections(page, perPage, userName);

      emit(UserCollectionsLoadSuccess(userCollectionList));
    } catch (e) {
      emit(UserCollectionsLoadFailure());
    }
  }

  Future fetchUserCollectionsPhoto(
      int page, int perPage, String userName) async {
    try {
      final userCollectionPhotoList =
          await photoRepository.getCollectionPhotos(page, perPage, userName);

      emit(UserCollectionsPhotoLoadSuccess(userCollectionPhotoList));
    } catch (e) {
      emit(UserCollectionsPhotoLoadFailure());
    }
  }
}
