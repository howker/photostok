import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/cubit/related_photo_cubit.dart';
import 'package:photostok/cubit/related_photo_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/widgets/widgets.dart';

class RelatedPhotoGrid extends StatefulWidget {
  final Photo photo;

  ///Сетка отображения связанных фотографий
  const RelatedPhotoGrid({Key key, this.photo}) : super(key: key);

  @override
  _RelatedPhotoGridState createState() => _RelatedPhotoGridState();
}

class _RelatedPhotoGridState extends State<RelatedPhotoGrid> {
  @override
  void initState() {
    BlocProvider.of<RelatedPhotoCubit>(context)
        .fetchRelatedPhotos(widget.photo.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelatedPhotoCubit, RelatedPhotoState>(
      builder: (ctx, state) {
        if (state is RelatedPhotoLoadFailure)
          return ErrorLoadingBanner();
        else if (state is RelatedPhotoState) {
          if (state.relatedPhotoList.results.length == 0)
            return Center(child: Text('No related foto'));
          else
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 11,
                    mainAxisSpacing: 9,
                    crossAxisCount: 3),
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                      onTap: () {
                        Photo photo = Photo(
                          id: state.relatedPhotoList.results[index].id,
                          createdAt:
                              state.relatedPhotoList.results[index].createdAt,
                          width: state.relatedPhotoList.results[index].width,
                          height: state.relatedPhotoList.results[index].height,
                          color: state.relatedPhotoList.results[index].color,
                          description:
                              state.relatedPhotoList.results[index].description,
                          altDescription: state
                              .relatedPhotoList.results[index].altDescription,
                          urls: state.relatedPhotoList.results[index].urls,
                          likes: state.relatedPhotoList.results[index].likes,
                          likedByUser:
                              state.relatedPhotoList.results[index].likedByUser,
                          user: state.relatedPhotoList.results[index].user,
                        );
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
                      },
                      child: PhotoView(
                        photoLink:
                            state.relatedPhotoList.results[index].urls.small,
                        placeholderColor:
                            state.relatedPhotoList.results[index].color,
                        isRounded: true,
                        radiusPhoto: 7,
                      ));
                },
                itemCount: 15);
        }
        return Center(child: TripleCircularIndicator());
      },
    );
  }
}
