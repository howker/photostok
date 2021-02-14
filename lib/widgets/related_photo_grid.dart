import 'package:flutter/material.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/models/related_photo_list.dart';
import 'package:photostok/repository/photo_repository.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/widgets/widgets.dart';

class RelatedPhotoGrid extends StatelessWidget {
  final Photo photo;

  ///Сетка отображения связанных фотографий
  const RelatedPhotoGrid({Key key, this.photo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RelatedPhotoList>(
      future: PhotoRepository.getRelatedPhotos(photo.id),
      builder: (ctx, snapshot) {
        if (snapshot.hasError)
          return ErrorLoadingBanner();
        else if (snapshot.hasData) {
          if (snapshot.data.results.length == 0)
            return Center(child: Text('No related foto'));
          else
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 11,
                    mainAxisSpacing: 9,
                    crossAxisCount: 3),
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                      onTap: () {
                        Photo photo = Photo(
                          id: snapshot.data.results[index].id,
                          createdAt: snapshot.data.results[index].createdAt,
                          width: snapshot.data.results[index].width,
                          height: snapshot.data.results[index].height,
                          color: snapshot.data.results[index].color,
                          description: snapshot.data.results[index].description,
                          altDescription:
                              snapshot.data.results[index].altDescription,
                          urls: snapshot.data.results[index].urls,
                          likes: snapshot.data.results[index].likes,
                          likedByUser: snapshot.data.results[index].likedByUser,
                          user: snapshot.data.results[index].user,
                        );
                        Navigator.pushNamed(
                          context,
                          transitionToDetailScreen,
                          arguments: FullScreenImageArguments(
                            routeSettings: RouteSettings(),
                            photo: photo,
                            heroTag: photo.id,
                            index: index,
                          ),
                        );
                      },
                      child: PhotoView(
                        photoLink: snapshot.data.results[index].urls.small,
                        placeholderColor: snapshot.data.results[index].color,
                        isRounded: true,
                        radiusPhoto: 7,
                      ));
                },
                itemCount: 15);
        }
        return Center(child: TripleCircularIndicator());
      },
    );
  }
}
