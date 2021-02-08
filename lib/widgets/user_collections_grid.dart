import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/user_cubit.dart';
import 'package:photostok/cubit/user_state.dart';
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
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserCollectionsLoadFailure)
          return ErrorLoadingBanner();
        else if (state is UserCollectionsLoadSuccess) {
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
                  photoLink: state.userCollectionList.userCollectionList[index]
                      .coverPhoto.urls.small,
                  placeholderColor: state.userCollectionList
                      .userCollectionList[index].coverPhoto.color,
                  isRounded: true,
                  radiusPhoto: 7,
                ),
              );
            },
            itemCount: state.userCollectionList.userCollectionList.length,
          );
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
