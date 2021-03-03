import 'package:equatable/equatable.dart';
import 'package:photostok/models/related_photo_list.dart';

class RelatedPhotoState extends Equatable {
  final RelatedPhotoList relatedPhotoList;

  RelatedPhotoState({this.relatedPhotoList});

  @override
  List<Object> get props => [relatedPhotoList, this.relatedPhotoList];

  RelatedPhotoState copyWith({
    RelatedPhotoList relatedPhotoList,
  }) {
    return RelatedPhotoState(
      relatedPhotoList: relatedPhotoList ?? this.relatedPhotoList,
    );
  }
}

class RelatedPhotoLoading extends RelatedPhotoState {}

class RelatedPhotoLoadFailure extends RelatedPhotoState {}
