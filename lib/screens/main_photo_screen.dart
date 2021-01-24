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
          return Center(child: Text('LOADING'));
        }
        if (state is PhotosLoadSuccess) {
          return Scaffold(
            body: ListView.builder(
              itemCount: state.photoList.photos.length,
              itemBuilder: (BuildContext context, int index) {
                var photo = state.photoList.photos[index];

                return Column(
                  children: <Widget>[
                    _buildItem(index, context, photo),
                  ],
                );
              },
            ),
          );
        }
        if (state is PhotosLoadFailure) {
          return Center(child: Text(state.errorMessage));
        }
        return Center(child: Text('DEFOULT RETURN'));
      },
    );
  }

  Widget _buildItem(index, context, photo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _transitionPhotoScreen(index, context, photo);
          },
          child: Hero(
            tag: 'someword $index',
            child: PhotoView(
              photoLink: photo.urls.small,
              placeholderColor: photo.color,
              photoHeigh: (photo.height).toDouble(),
              photoWidth: (photo.width).toDouble(),
            ),
          ),
        ),
        _buildPhotoMeta(index, photo, context),
        Divider(thickness: 2, color: AppColors.mercury)
      ],
    );
  }

  Widget _buildPhotoMeta(int index, photo, context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                UserAvatar(photo.user.profileImage.large),
                SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
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

void _transitionPhotoScreen(index, context, Photo photo) {
  Navigator.pushNamed(
    context,
    transition,
    arguments: FullScreenImageArguments(
      routeSettings: RouteSettings(
        arguments: 'Some title',
      ),
      photo: photo,
      heroTag: photo.id,
    ),
  );
}
