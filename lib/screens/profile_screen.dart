import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  final bool isMyProfile;
  final Photo photo;
  const ProfileScreen({this.isMyProfile = true, this.photo});

  @override
  Widget build(BuildContext context) {
    if (isMyProfile)
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
            centerTitle: true,
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.headline2,
            ),
            actions: [
              _buildVerticalButton(context),
            ],
            bottom: TabBar(
              labelColor: AppColors.blue,
              unselectedLabelColor: AppColors.black,
              indicatorWeight: 3,
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.favorite_border_outlined)),
                Tab(icon: Icon(Icons.bookmark_border_outlined)),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TabBarView(
              children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          centerTitle: true,
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  UserAvatar(photo.user.profileImage.large),
                ],
              ),
            ],
          ),
        ),
      );
  }
}

Widget _buildVerticalButton(context) {
  return IconButton(
    icon: const Icon(Icons.more_vert, color: AppColors.grayChateau),
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 200),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      print('tap');
                      Navigator.pop(context);
                    },
                    child: SimpleDialog(
                      titlePadding: const EdgeInsets.all(10),
                      title: Text(
                        'Logout',
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
