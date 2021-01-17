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

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

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
        _buildPhotoMeta(index),
        Divider(thickness: 2, color: AppColors.mercury)
      ],
    );
  }

  Widget _buildPhotoMeta(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Kirill Adeshchenko', style: AppStyles.h2Black),
                  Text(
                    "@kaparray",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: AppColors.manatee),
                  ),
                  Text(
                    'This is Flutter dash. I love him :',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: AppColors.manatee),
                  ),
                ],
              )
            ],
          ),
          LikeButton(likeCount: 10, isLiked: true),
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
      altDescription: 'Test altDescription',
      userName: 'kaparray',
      name: 'Kirill Adeshchenko',
      userPhoto: 'https://skill-branch.ru/img/speakers/Adechenko.jpg',
      heroTag: 'someword $index',
    ),
  );
}
