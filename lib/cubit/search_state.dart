import 'package:equatable/equatable.dart';
import 'package:photostok/models/related_photo_list.dart';

class SearchPhotoLoadSuccess extends Equatable {
  final RelatedPhotoList searchPhotoList;

  SearchPhotoLoadSuccess({this.searchPhotoList});

  @override
  List<Object> get props => [searchPhotoList, this.searchPhotoList];

  SearchPhotoLoadSuccess copyWith({
    RelatedPhotoList searchPhotoList,
  }) {
    return SearchPhotoLoadSuccess(
      searchPhotoList: searchPhotoList ?? this.searchPhotoList,
    );
  }
}

class SearchPhotoLoading extends SearchPhotoLoadSuccess {}

class SearchPhotoLoadFailure extends SearchPhotoLoadSuccess {}
