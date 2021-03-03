import 'package:equatable/equatable.dart';
import 'package:photostok/models/related_photo_list.dart';

class SearchState extends Equatable {
  final RelatedPhotoList searchPhotoList;

  SearchState({this.searchPhotoList});

  @override
  List<Object> get props => [searchPhotoList, this.searchPhotoList];

  SearchState copyWith({
    RelatedPhotoList searchPhotoList,
  }) {
    return SearchState(
      searchPhotoList: searchPhotoList ?? this.searchPhotoList,
    );
  }
}

class SearchPhotoLoading extends SearchState {}

class SearchPhotoLoadFailure extends SearchState {}
