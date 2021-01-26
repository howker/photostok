import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/widgets/claim_bottom_sheet.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/widgets/widgets.dart';

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
          var photoSize = (MediaQuery.of(context).size.width - 130) /
              state.photoList.photos[index].width *
              state.photoList.photos[index].height;
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
                actions: [
                  _buildVerticalButton(context),
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: heroTag,
                    child: Container(
                      height: photoSize,
                      width: photoSize,
                      child: PhotoView(
                        photoLink: photo.urls.small,
                        placeholderColor: photo.color,
                        isRounded: true,
                      ),
                    ),
                  ),
                  //TODO time creation photo
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      //TODO maxmin text ellipsis
                      photo.altDescription,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  _animatedBuilder(_controller, buildAnimationUserMeta,
                      buildAnimationUserAvatar, photo),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LikeButton(photo: state.photoList.photos[index]),
                        Row(
                          children: [
                            _buildSaveButton(context, photo),
                            const SizedBox(width: 10),
                            _buildVisitButton(context, photo),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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
        _onVisitButtonTap(context);
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

Widget _buildVerticalButton(context) {
  return IconButton(
    icon: const Icon(Icons.more_vert),
    onPressed: () {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          child: ClaimBottomSheet(),
        ),
      );
    },
  );
}

Widget _animatedBuilder(_controller, buildAnimationUserMeta,
    buildAnimationUserAvatar, Photo photo) {
  return AnimatedBuilder(
    animation: _controller,
    builder: (BuildContext context, Widget child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: GestureDetector(
          child: Row(
            children: [
              Opacity(
                opacity: 1.0,
                child: UserAvatar(photo.user.profileImage.large),
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
            //TODO transition to profile
          },
        ),
      );
    },
  );
}

Widget _buildSaveButton(context, Photo photo) {
  return GestureDetector(
    onTap: () {
      _showDialog(context, photo);
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

void _showDialog(context, Photo photo) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Downloading photos'),
      content: const Text('Are you sure you want to download a photo?'),
      actions: [
        FlatButton(
          onPressed: () {
            GallerySaver.saveImage(photo.urls.regular);
            Navigator.of(context).pop();
          },
          child: const Text('Download'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

Future<void> _onVisitButtonTap(context) async {
  OverlayState overlayState = Overlay.of(context);

  OverlayEntry overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      return Positioned(
        top: MediaQuery.of(context).viewInsets.top + 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              decoration: BoxDecoration(
                color: AppColors.mercury,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Visit link'),
            ),
          ),
        ),
      );
    },
  );

  overlayState.insert(overlayEntry);
  await Future.delayed(
    Duration(seconds: 1),
  );
  overlayEntry.remove();
}
