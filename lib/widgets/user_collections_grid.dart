import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/collections_cubit.dart';
import 'package:photostok/cubit/collections_state.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/widgets/widgets.dart';

///Сетка отображения коллекций пользователя
class PhotoGridUserCollections extends StatelessWidget {
  final String userName;

  const PhotoGridUserCollections({this.userName});
  @override
  Widget build(BuildContext context) {
    final _cubit = BlocProvider.of<CollectionsCubit>(context);
    _cubit.fetchUserCollections(1, 15, userName);
    return BlocBuilder<CollectionsCubit, CollectionsState>(
      builder: (context, state) {
        if (state is UserCollectionsLoadSuccess) {
          if (state.userCollectionList.userCollectionList.length == 0)
            return Center(
              child: Text('No content yet'),
            );
          else
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 11, mainAxisSpacing: 9, crossAxisCount: 3),
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    _cubit.fetchUserCollectionsPhoto(1, 15,
                        state.userCollectionList.userCollectionList[index].id);
                  },
                  child: PhotoView(
                    photoLink: state.userCollectionList
                        .userCollectionList[index].coverPhoto.urls.small,
                    placeholderColor: state.userCollectionList
                        .userCollectionList[index].coverPhoto.color,
                    isRounded: true,
                    radiusPhoto: 7,
                  ),
                );
              },
              itemCount: state.userCollectionList.userCollectionList.length,
            );
        } else if (state is UserCollectionsLoadFailure ||
            state is UserCollectionsPhotoLoadFailure)
          return Center(child: ErrorLoadingBanner());
        else if (state is UserCollectionsPhotoLoadSuccess) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 11, mainAxisSpacing: 9, crossAxisCount: 3),
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    transitionToDetailScreen,
                    arguments: FullScreenImageArguments(
                      routeSettings: RouteSettings(),
                      photo: state.photoList.photos[index],
                      heroTag: state.photoList.photos[index].id,
                      index: index,
                    ),
                  );
                },
                child: PhotoView(
                  photoLink: state.photoList.photos[index].urls.small,
                  placeholderColor: state.photoList.photos[index].color,
                  isRounded: true,
                  radiusPhoto: 7,
                ),
              );
            },
            itemCount: state.photoList.photos.length,
          );
        }
        return Container();
      },
    );
  }
}
