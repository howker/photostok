import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/screens/profile_screen.dart';
import 'package:photostok/widgets/widgets.dart';

///Основной экран ленты фотографий
class MainPhotoList extends StatefulWidget {
  int page;
  bool isLoading;
  MainPhotoList({
    Key key,
    this.page = 1,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _MainPhotoListState createState() => _MainPhotoListState();
}

class _MainPhotoListState extends State<MainPhotoList> {
  @override
  void initState() {
    BlocProvider.of<PhotoCubit>(context).fetchAllPhotos(1, 15);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _cubit = BlocProvider.of<PhotoCubit>(context);
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (context, state) {
        if (state is PhotosInitial) {
          return TripleCircularIndicator();
        }
        // if (state is! PhotosLoadSuccess) {
        //   _cubit.fetchAllPhotos(widget.page, 15);
        // }
        widget.isLoading = false;

        if (state is PhotosLoadSuccess) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () {
                return _cubit.fetchAllPhotos(1, 15);
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      !widget.isLoading) {
                    widget.page += 1;
                    _cubit.fetchAllPhotos(widget.page, 15);
                    widget.isLoading = true;
                  }
                  return false;
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.photoList.photos.length,
                  itemBuilder: (BuildContext context, int index) {
                    Photo photo = state.photoList.photos[index];
                    return Column(
                      children: [
                        _buildItem(index, context, photo, state),
                      ],
                    );
                  },
                ),
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

  Widget _buildItem(int index, context, Photo photo, state) {
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
          _buildPhotoMeta(index, photo, context, state),
          const Divider(thickness: 2, color: AppColors.mercury)
        ],
      ),
    );
  }

  Widget _buildPhotoMeta(int index, Photo photo, context, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            transitionToProfileScreen,
            arguments: ProfileScreenArguments(
              routeSettings: RouteSettings(),
              photo: photo,
              isMyProfile: false,
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  UserAvatar(avatarLink: photo.user.profileImage.large),
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
              photo: state.photoList.photos[index],
              index: index,
            ),
          ],
        ),
      ),
    );
  }
}

void _transitionPhotoScreen(int index, context, Photo photo) {
  Navigator.pushNamed(
    context,
    transitionToDetailScreen,
    arguments: FullScreenImageArguments(
      routeSettings: RouteSettings(),
      photo: photo,
      heroTag: photo.id,
      index: index,
    ),
  );
}
