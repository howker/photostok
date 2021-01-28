import 'package:flutter/material.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/models/related_photo_list.dart';
import 'package:photostok/repository/photo_repository.dart';
import 'package:photostok/widgets/widgets.dart';

class RelatedPhotoGrid extends StatelessWidget {
  final Photo photo;

  const RelatedPhotoGrid({Key key, this.photo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RelatedPhotoList>(
      future: PhotoRepository.getRelatedPhotos(photo.id),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return ErrorLoadingBanner();
        }

        if (snapshot.hasData) {
          return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //childAspectRatio: 170/215,
                  crossAxisSpacing: 11,
                  mainAxisSpacing: 9,
                  crossAxisCount: 3),
              itemBuilder: (ctx, index) {
                return PhotoView(
                  photoLink: snapshot.data.results[index].urls.small,
                  placeholderColor: snapshot.data.results[index].color,
                  isRounded: true,
                  radiusPhoto: 7,
                );
              },
              itemCount: snapshot.data.results.length);
        }
        return const SizedBox();
      },
    );
  }
}
