import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/widgets/widgets.dart';

class SearchPhotoGrid extends StatelessWidget {
  final Photo photo;

  const SearchPhotoGrid({Key key, this.photo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (BuildContext context, state) {
        if (state is SearchPhotoLoadSuccess) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return _buildImageElement(index);
            },
          );
        } else
          return Center(child: TripleCircularIndicator());
      },
    );
  }
}

Widget _buildImageElement(int index) {
  return Row(
    children: [],
  );
}

// GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisSpacing: 11, mainAxisSpacing: 9, crossAxisCount: 3),
//               itemBuilder: (ctx, index) {
//                 return GestureDetector(
//                   child: PhotoView(
//                     photoLink: state.searchPhotoList.results[index].urls.small,
//                     placeholderColor:
//                         state.searchPhotoList.results[index].color,
//                     isRounded: true,
//                     radiusPhoto: 7,
//                   ),
//                 );
//               },
//               itemCount: state.searchPhotoList.results.length);

//  onTap: () {
//                     Photo photo = Photo(
//                       id: state.searchPhotoList.results[index].id,
//                       createdAt: state.searchPhotoList.results[index].createdAt,
//                       width: state.searchPhotoList.results[index].width,
//                       height: state.searchPhotoList.results[index].height,
//                       color: state.searchPhotoList.results[index].color,
//                       description:
//                           state.searchPhotoList.results[index].description,
//                       altDescription:
//                           state.searchPhotoList.results[index].altDescription,
//                       urls: state.searchPhotoList.results[index].urls,
//                       likes: state.searchPhotoList.results[index].likes,
//                       likedByUser:
//                           state.searchPhotoList.results[index].likedByUser,
//                       user: state.searchPhotoList.results[index].user,
//                     );
//                     Navigator.pushNamed(
//                       context,
//                       transition,
//                       arguments: FullScreenImageArguments(
//                         routeSettings: RouteSettings(
//                           arguments: 'Some title',
//                         ),
//                         photo: photo,
//                         heroTag: photo.id,
//                         index: index,
//                       ),
//                     );
//                   },
