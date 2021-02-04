import 'package:flutter/material.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/models/user_collection.dart';
import 'package:photostok/repository/photo_repository.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/widgets/widgets.dart';

class PhotoGridUserCollections extends StatelessWidget {
  final Photo photo;
  final String userName;

  ///Сетка отображения коллекций пользователя
  const PhotoGridUserCollections({Key key, this.photo, this.userName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserCollectionList>(
      future: PhotoRepository.getUserCollections(1, 15, userName),
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
                    Photo photo = Photo();
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
                    photoLink: snapshot
                        .data.userCollectionList[index].coverPhoto.urls.small,
                    placeholderColor: snapshot
                        .data.userCollectionList[index].coverPhoto.color,
                    isRounded: true,
                    radiusPhoto: 7,
                  ),
                );
              },
              itemCount: snapshot.data.userCollectionList.length);
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
