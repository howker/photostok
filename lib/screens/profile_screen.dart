import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/cubit/user_cubit.dart';
import 'package:photostok/cubit/user_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/widgets/widgets.dart';

class ProfileScreenArguments {
  ProfileScreenArguments({
    this.photo,
    this.routeSettings,
    this.isMyProfile,
  });
  final RouteSettings routeSettings;
  final Photo photo;
  final bool isMyProfile;
}

class ProfileScreen extends StatelessWidget {
  final bool isMyProfile;
  final Photo photo;
  const ProfileScreen({this.isMyProfile, this.photo});

  @override
  Widget build(BuildContext context) {
    if (isMyProfile) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: _buildMyProfileAppBar(context),
          body: TabBarView(
            children: [
              const Icon(Icons.directions_car),
              const Icon(Icons.directions_transit),
              const Icon(Icons.directions_bike),
            ],
          ),
        ),
      );
    } else {
      final _cubit = BlocProvider.of<UserCubit>(context);
      _cubit.fetchUserProfile(photo.user.username);
      return BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserProfileLoadSuccess)
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: _buildUserProfileAppBar(context),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              UserAvatar(
                                  width: 70,
                                  height: 70,
                                  avatarLink:
                                      state.userProfile.profileImage.large),
                            ],
                          ),
                          const SizedBox(width: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    state.userProfile.username ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    state.userProfile.followersCount
                                            .toString() ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.dodgerBlue,
                                        ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('followers'),
                                  const SizedBox(width: 26),
                                  Text(
                                    state.userProfile.followingCount
                                            .toString() ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.dodgerBlue,
                                        ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('following'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.flag_rounded,
                                      color: AppColors.dodgerBlue),
                                  const SizedBox(width: 9.79),
                                  Text(state.userProfile.location ?? ''),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.ac_unit,
                                      color: AppColors.dodgerBlue),
                                  const SizedBox(width: 8.49),
                                  Text(state.userProfile.id ??
                                      ''), //TODO DTO profilelink
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Text(state.userProfile.bio ?? ''),
                          //   ],
                          // ),
                          // const SizedBox(height: 37),
                        ],
                      ),
                      TabBar(
                        labelColor: AppColors.blue,
                        unselectedLabelColor: AppColors.black,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(icon: const Icon(Icons.home)),
                          Tab(icon: const Icon(Icons.favorite_border_outlined)),
                          Tab(icon: const Icon(Icons.bookmark_border_outlined)),
                        ],
                      ),
                      const Divider(
                        height: 0,
                        thickness: 1,
                        color: AppColors.greyLine,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            const Icon(Icons.directions_car),
                            const Icon(Icons.directions_transit),
                            const Icon(Icons.directions_bike),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          else
            return TripleCircularIndicator();
        },
      );
    }
  }
}

AppBar _buildUserProfileAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: AppColors.white,
    centerTitle: true,
    title: Text(
      'Profile',
      style: Theme.of(context).textTheme.headline2,
    ),
  );
}

AppBar _buildMyProfileAppBar(BuildContext context) {
  return AppBar(
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
        Tab(icon: const Icon(Icons.home)),
        Tab(icon: const Icon(Icons.favorite_border_outlined)),
        Tab(icon: const Icon(Icons.bookmark_border_outlined)),
      ],
    ),
  );
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
