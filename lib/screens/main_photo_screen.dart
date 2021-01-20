import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/res/colors.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/res/styles.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPhotoList extends StatefulWidget {
  MainPhotoList({Key key}) : super(key: key);

  @override
  _MainPhotoListState createState() => _MainPhotoListState();
}

class _MainPhotoListState extends State<MainPhotoList> {
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
                    _buildItem(index, context, transition, photo),
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

  Widget _buildItem(int index, context, transition, photo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _transitionPhotoScreen(context, index, transition, photo);
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
        _buildPhotoMeta(index, photo),
        Divider(thickness: 2, color: AppColors.mercury)
      ],
    );
  }

  Widget _buildPhotoMeta(int index, photo) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar(photo.user.profileImage.large),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(photo.user.name ?? '', style: AppStyles.h2Black),
                  Text(
                    '@${photo.user.username}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: AppColors.manatee),
                  ),
                  Text(
                    photo.description ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: AppColors.manatee),
                    maxLines: 2,
                  ),
                ],
              )
            ],
          ),
          LikeButton(
            likeCount: photo.likes,
            isLiked: photo.likedByUser,
            photoId: photo.id,
          ),
        ],
      ),
    );
  }
}

void _transitionPhotoScreen(context, index, transition, photo) {
  Navigator.pushNamed(
    context,
    transition,
    arguments: FullScreenImageArguments(
      routeSettings: RouteSettings(
        arguments: 'Some title',
      ),
      photo: photo.urls.small,
      description: photo.description ?? '',
      userName: photo.user.username,
      name: photo.user.name,
      userPhoto: photo.user.profileImage.large,
      heroTag: 'someword $index',
      likeCount: photo.likes,
    ),
  );
}
