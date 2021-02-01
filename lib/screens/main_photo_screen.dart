import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MainPhotoList extends StatelessWidget {
  MainPhotoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cubit = BlocProvider.of<PhotoCubit>(context);
    _cubit.fetchAllPhotos();
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (context, state) {
        if (state is PhotosInitial) {
          return TripleCircularIndicator();
        }
        if (state is PhotosLoadSuccess) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () {
                return _cubit.fetchAllPhotos();
              },
              child: ListView.builder(
                itemCount: state.photoList.photos.length,
                itemBuilder: (BuildContext context, int index) {
                  var photo = state.photoList.photos[index];
                  return Column(
                    children: [
                      _buildItem(index, context, photo),
                    ],
                  );
                },
              ),
            ),
          );
        } else if (state is PhotosLoadFailure) {
          return const ErrorLoadingBanner();
        }
        return Container();
      },
    );
  }

  Widget _buildItem(int index, context, Photo photo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _transitionPhotoScreen(index, context, photo);
            },
            child: Hero(
              tag: 'someword $index',
              child: PhotoView(
                photoLink: photo.urls.regular,
                placeholderColor: photo.color,
                isRounded: false,
              ),
            ),
          ),
          _buildPhotoMeta(index, photo, context),
          const Divider(thickness: 2, color: AppColors.mercury)
        ],
      ),
    );
  }

  Widget _buildPhotoMeta(int index, Photo photo, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                UserAvatar(photo.user.profileImage.large),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(photo.user.name ?? '', style: AppStyles.h2Black),
                      Text(
                        '@${photo.user.username ?? ''}',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: AppColors.manatee),
                      ),
                      Text(
                        photo.altDescription ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: AppColors.manatee),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          LikeButton(
            photo: photo,
          ),
        ],
      ),
    );
  }
}

void _transitionPhotoScreen(int index, context, Photo photo) {
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
}
