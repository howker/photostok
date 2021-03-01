import 'package:equatable/equatable.dart';
import 'package:photostok/models/related_photo_list.dart';

class RelatedPhotoLoadSuccess extends Equatable {
  final RelatedPhotoList relatedPhotoList;

  RelatedPhotoLoadSuccess({this.relatedPhotoList});

  @override
  List<Object> get props => [relatedPhotoList, this.relatedPhotoList];

  RelatedPhotoLoadSuccess copyWith({
    RelatedPhotoList relatedPhotoList,
  }) {
    return RelatedPhotoLoadSuccess(
      relatedPhotoList: relatedPhotoList ?? this.relatedPhotoList,
    );
  }
}

class RelatedPhotoLoading extends RelatedPhotoLoadSuccess {}

class RelatedPhotoLoadFailure extends RelatedPhotoLoadSuccess {}
