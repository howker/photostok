import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/screens/profile_screen.dart';
import 'package:photostok/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class FullScreenImageArguments {
  FullScreenImageArguments({
    this.photo,
    this.routeSettings,
    this.heroTag,
    this.index,
  });

  final RouteSettings routeSettings;
  final Photo photo;
  final String heroTag;
  final int index;
}

///Экран деталей фотографии
class FullScreenImage extends StatefulWidget {
  final Photo photo;
  final String heroTag;
  final int index;

  const FullScreenImage({
    this.photo,
    this.heroTag,
    this.index,
  });

  @override
  _FullScreenImageState createState() =>
      _FullScreenImageState(photo, heroTag, index);
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  final Photo photo;
  final String heroTag;
  final int index;

  _FullScreenImageState(this.photo, this.heroTag, this.index);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _playAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (context, state) {
        if (state is PhotosLoadSuccess) {
          double photoSize = (MediaQuery.of(context).size.width - 200) /
              photo.width *
              photo.height;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.white,
                centerTitle: true,
                title: Text(
                  'Photo',
                  style: Theme.of(context).textTheme.headline2,
                ),
                leading: IconButton(
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: AppColors.manatee,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: Hero(
                        tag: heroTag,
                        child: Container(
                          height: photoSize,
                          width: photoSize,
                          child: PhotoView(
                            photoLink: photo.urls.regular,
                            placeholderColor: photo.color,
                            isRounded: true,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TimeOfFotoCreation(createdAt: photo.createdAt),
                    const SizedBox(height: 11),
                    Text(
                      photo.altDescription,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 15),
                    _animatedBuilder(_controller, buildAnimationUserMeta,
                        buildAnimationUserAvatar, photo),
                    const SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LikeButton(photo: photo, index: index),
                        Row(
                          children: [
                            _buildSaveButton(context, photo),
                            const SizedBox(width: 10),
                            _buildVisitButton(context, photo),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Expanded(child: RelatedPhotoGrid(photo: photo)),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is SearchPhotoLoadSuccess) {
          double photoSize = (MediaQuery.of(context).size.width - 200) /
              photo.width *
              photo.height;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.white,
                centerTitle: true,
                title: Text(
                  'Photo',
                  style: Theme.of(context).textTheme.headline2,
                ),
                leading: IconButton(
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: AppColors.manatee,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: Hero(
                        tag: heroTag,
                        child: Container(
                          height: photoSize,
                          width: photoSize,
                          child: PhotoView(
                            photoLink: photo.urls.regular,
                            placeholderColor: photo.color,
                            isRounded: true,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TimeOfFotoCreation(createdAt: photo.createdAt),
                    const SizedBox(height: 11),
                    Text(
                      photo.altDescription,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 15),
                    _animatedBuilder(_controller, buildAnimationUserMeta,
                        buildAnimationUserAvatar, photo),
                    const SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LikeButton(photo: photo, index: index),
                        Row(
                          children: [
                            _buildSaveButton(context, photo),
                            const SizedBox(width: 10),
                            _buildVisitButton(context, photo),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Expanded(child: RelatedPhotoGrid(photo: photo)),
                  ],
                ),
              ),
            ),
          );
        } else
          return Container();
      },
    );
  }

  double buildAnimationUserMeta() {
    return Tween<double>(begin: 0.0, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 1.0, curve: Curves.ease),
          ),
        )
        .value;
  }

  double buildAnimationUserAvatar() {
    return Tween<double>(begin: 0.0, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 1.0, curve: Curves.ease),
          ),
        )
        .value;
  }

  Widget _buildVisitButton(context, Photo photo) {
    return GestureDetector(
      onTap: () {
        _onVisitButtonTap(photo);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dodgerBlue,
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: const Text(
            'Visit',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

Widget _animatedBuilder(_controller, buildAnimationUserMeta,
    buildAnimationUserAvatar, Photo photo) {
  return AnimatedBuilder(
    animation: _controller,
    builder: (BuildContext context, Widget child) {
      return GestureDetector(
        child: Row(
          children: [
            Opacity(
              opacity: 1.0,
              child: UserAvatar(avatarLink: photo.user.profileImage.large),
            ),
            const SizedBox(width: 6.0),
            Opacity(
              opacity: buildAnimationUserMeta(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(photo.user.name,
                      style: Theme.of(context).textTheme.headline1),
                  Text(
                    '@' + photo.user.username,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: AppColors.manatee),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      );
    },
  );
}

Widget _buildSaveButton(context, Photo photo) {
  return GestureDetector(
    onTap: () {
      _showSaveDialog(context, photo);
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.dodgerBlue,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Text(
          'Save',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    ),
  );
}

void _showSaveDialog(context, Photo photo) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Downloading photos'),
      content: const Text('Are you sure you want to download a photo?'),
      actions: [
        SaveButton(photo: photo),
        CloseDialogButton(),
      ],
    ),
  );
}

void _onVisitButtonTap(Photo photo) async {
  String url = photo.urls.full;

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
