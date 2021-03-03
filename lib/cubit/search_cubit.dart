import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/search_state.dart';
import 'package:photostok/models/related_photo_list.dart';
import 'package:photostok/repository/photo_repository.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.photoRepository) : super(SearchPhotoLoading());
  final PhotoRepository photoRepository;

  Future fetchSearchPhotos(String query) async {
    try {
      emit(SearchPhotoLoading());
      RelatedPhotoList searchPhotolist =
          await photoRepository.getSearchPhotos(1, 15, query);

      emit(state.copyWith(searchPhotoList: searchPhotolist));
    } catch (_) {
      emit(SearchPhotoLoadFailure());
    }
  }
}
