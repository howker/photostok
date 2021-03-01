import 'package:equatable/equatable.dart';
import 'package:photostok/models/related_photo_list.dart';

class SearchPhoto extends Equatable {
  final RelatedPhotoList searchPhotoList;

  SearchPhoto({this.searchPhotoList});

  @override
  List<Object> get props => [searchPhotoList, this.searchPhotoList];

  SearchPhoto copyWith({
    RelatedPhotoList searchPhotoList,
  }) {
    return SearchPhoto(
      searchPhotoList: searchPhotoList ?? this.searchPhotoList,
    );
  }
}

class SearchPhotoLoading extends SearchPhoto {}

class SearchPhotoLoadFailure extends SearchPhoto {}
