import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/search_cubit.dart';
import 'package:photostok/cubit/search_state.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/models/related_photo_list.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/widgets/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

///Сетка отображения найденных фотографий
class SearchPhotoGrid extends StatelessWidget {
  final Photo photo;

  const SearchPhotoGrid({this.photo});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (BuildContext context, state) {
        if (state is SearchPhotoLoading)
          return Center(child: TripleCircularIndicator());
        else if (state is SearchState) {
          if (state.searchPhotoList.results.length == 0)
            return Center(
              child: Text(
                'Nothing found',
                style: Theme.of(context).textTheme.headline1.copyWith(
                    color: AppColors.manatee, fontWeight: FontWeight.w500),
              ),
            );
          else
            return Expanded(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                itemCount: state.searchPhotoList.results.length,
                itemBuilder: (BuildContext context, int index) =>
                    SearchPhotoView(
                  index: index,
                  photoLink: state.searchPhotoList.results[index].urls.small,
                  placeholderColor: state.searchPhotoList.results[index].color,
                  results: state.searchPhotoList.results[index],
                ),
                staggeredTileBuilder: (int index) => StaggeredTile.count(
                  (index % 9 == 0) ? 2 : 1,
                  (index % 9 == 0) ? 2 : 1,
                ),
                mainAxisSpacing: 9.0,
                crossAxisSpacing: 11.0,
              ),
            );
        } else if (state is SearchPhotoLoadFailure)
          return const ErrorLoadingBanner();
        else
          return Container();
      },
    );
  }
}

class SearchPhotoView extends StatelessWidget {
  SearchPhotoView({
    this.photoLink,
    this.placeholderColor,
    this.index,
    this.results,
  });
  final int index;
  final String photoLink;
  final String placeholderColor;
  final Results results;

  @override
  Widget build(BuildContext context) {
    if (photoLink == null) return Container();
    final String color =
        '0xFF${placeholderColor.replaceAll(RegExp(r"[#]"), '')}';

    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: GestureDetector(
        onTap: () {
          Photo photo = Photo(
            id: results.id,
            createdAt: results.createdAt,
            width: results.width,
            height: results.height,
            color: results.color,
            description: results.description,
            altDescription: results.altDescription,
            urls: results.urls,
            likes: results.likes,
            likedByUser: results.likedByUser,
            user: results.user,
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
        child: Container(
          color: AppColors.grayChateau,
          child: CachedNetworkImage(
            imageUrl: photoLink,
            fit: BoxFit.fill,
            placeholder: (context, url) => Center(
              child: Container(
                color: Color(int.parse(color)),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
