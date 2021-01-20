import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:photostok/widgets/claim_bottom_sheet.dart';

import '../res/res.dart';
import '../widgets/widgets.dart';

class FullScreenImageArguments {
  FullScreenImageArguments({
    this.description,
    this.userName,
    this.name,
    this.userPhoto,
    this.photo,
    this.heroTag,
    this.key,
    this.routeSettings,
    this.likeCount,
  });

  final String description;
  final String userName;
  final String name;
  final String userPhoto;
  final String photo;
  final String heroTag;
  final Key key;
  final RouteSettings routeSettings;
  final int likeCount;
}

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    Key key,
    this.altDescription,
    this.userName,
    this.name,
    this.userPhoto,
    this.photo,
    this.heroTag,
    this.likeCount,
  }) : super(key: key);

  final String altDescription;
  final String userName;
  final String name;
  final String userPhoto;
  final String photo;
  final String heroTag;
  final int likeCount;

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  AnimationController _controller;

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Photo',
            style: Theme.of(context).textTheme.headline2,
          ),
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            _buildVerticalButton(context),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: widget.heroTag,
              child: Container(
                  //TODO size
                  width: 340,
                  height: 340,
                  child: PhotoView(
                    photoLink: widget.photo,
                    placeholderColor: widget.photo,
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                widget.altDescription,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            _animatedBuilder(_controller, buildAnimationUserMeta,
                buildAnimationUserAvatar, widget),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  LikeButton(likeCount: widget.likeCount, isLiked: true),
                  Row(
                    children: <Widget>[
                      _buildSaveButton(context, widget),
                      SizedBox(width: 10),
                      _buildVisitButton(context, widget),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double buildAnimationUserMeta() {
    return Tween<double>(begin: 0.0, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(0.5, 1.0, curve: Curves.ease),
          ),
        )
        .value;
  }

  double buildAnimationUserAvatar() {
    return Tween<double>(begin: 0.0, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(0.5, 1.0, curve: Curves.ease),
          ),
        )
        .value;
  }

  Widget _buildVisitButton(context, widget) {
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
          child: Text(
            'Visit',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

Widget _buildVerticalButton(context) {
  return IconButton(
    icon: Icon(Icons.more_vert),
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

Widget _animatedBuilder(
    _controller, buildAnimationUserMeta, buildAnimationUserAvatar, widget) {
  return AnimatedBuilder(
    animation: _controller,
    builder: (BuildContext context, Widget child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: <Widget>[
            Opacity(
              opacity: 1.0, //buildAnimationUserMeta(),
              child: UserAvatar(widget.userPhoto),
            ),
            SizedBox(width: 6.0),
            Opacity(
              opacity: buildAnimationUserMeta(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.name,
                      style: Theme.of(context).textTheme.headline1),
                  Text(
                    '@' + widget.userName,
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
      );
    },
  );
}

Widget _buildSaveButton(context, widget) {
  return GestureDetector(
    onTap: () {
      _showDialog(context, widget);
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
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    ),
  );
}

void _showDialog(context, widget) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Downloading photos'),
      content: Text('Are you sure you want to upload a photo?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            GallerySaver.saveImage(widget.photo);
            Navigator.of(context).pop();
          },
          child: Text('Download'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
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
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              decoration: BoxDecoration(
                color: AppColors.mercury,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('SkillBranch'),
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
