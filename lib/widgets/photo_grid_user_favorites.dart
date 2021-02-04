import 'package:flutter/material.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/repository/photo_repository.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/widgets/widgets.dart';

class PhotoGridUserFavorites extends StatelessWidget {
  final Photo photo;
  final String userName;

  ///Сетка отображения понравившехся фотографий пользователя
  const PhotoGridUserFavorites({Key key, this.photo, this.userName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PhotoList>(
      future: PhotoRepository.getUserFavoritesPhotos(1, 15, userName),
      builder: (ctx, snapshot) {
        if (snapshot.hasError)
          return ErrorLoadingBanner();
        else if (snapshot.hasData) {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 11, mainAxisSpacing: 9, crossAxisCount: 3),
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    Photo photo = Photo(
                      id: snapshot.data.photos[index].id,
                      createdAt: snapshot.data.photos[index].createdAt,
                      width: snapshot.data.photos[index].width,
                      height: snapshot.data.photos[index].height,
                      color: snapshot.data.photos[index].color,
                      description: snapshot.data.photos[index].description,
                      altDescription:
                          snapshot.data.photos[index].altDescription,
                      urls: snapshot.data.photos[index].urls,
                      likes: snapshot.data.photos[index].likes,
                      likedByUser: snapshot.data.photos[index].likedByUser,
                      user: snapshot.data.photos[index].user,
                    );
                    Navigator.pushNamed(
                      context,
                      transitionToDetailScreen,
                      arguments: FullScreenImageArguments(
                        routeSettings: RouteSettings(
                          arguments: 'Some title',
                        ),
                        photo: photo,
                        heroTag: photo.id,
                        index: index,
                      ),
                    );
                  },
                  child: PhotoView(
                    photoLink: snapshot.data.photos[index].urls.small,
                    placeholderColor: snapshot.data.photos[index].color,
                    isRounded: true,
                    radiusPhoto: 7,
                  ),
                );
              },
              itemCount: snapshot.data.photos.length);
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TripleCircularIndicator(),
          ],
        );
      },
    );
  }
}
