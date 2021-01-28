import 'package:flutter/material.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/widgets/widgets.dart';

class SearchPhotoGrid extends StatelessWidget {
  final Photo photo;
  final PhotosLoadSuccess state;

  const SearchPhotoGrid({Key key, this.photo, this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 11, mainAxisSpacing: 9, crossAxisCount: 3),
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                transition,
                arguments: FullScreenImageArguments(
                  routeSettings: RouteSettings(
                    arguments: 'Some title',
                  ),
                  photo: photo,
                  heroTag: photo.id,
                  index: index,
                ),
              );
            },
            child: PhotoView(
              photoLink: state.photoList.photos[index].urls.small,
              placeholderColor: state.photoList.photos[index].color,
              isRounded: true,
              radiusPhoto: 7,
            ),
          );
        },
        itemCount: state.photoList.photos.length);
  }
}
