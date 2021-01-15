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
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              _buildItem(index, context, transition),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItem(int index, context, transition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _transitionPhotoScreen(context, index, transition);
          },
          child: Hero(
            tag: 'someword $index',
            child: Photo(photoLink: kFlutterDash),
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

void _transitionPhotoScreen(context, index, transition) {
  Navigator.pushNamed(
    context,
    transition,
    arguments: FullScreenImageArguments(
      routeSettings: RouteSettings(
        arguments: 'Some title',
      ),
      photo: kFlutterDash,
      altDescription: 'Test altDescription',
      userName: 'kaparray',
      name: 'Kirill Adeshchenko',
      userPhoto: 'https://skill-branch.ru/img/speakers/Adechenko.jpg',
      heroTag: 'someword $index',
    ),
  );
}
