import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/cubit/photos_state.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cubit = BlocProvider.of<PhotoCubit>(context);
    _cubit.fetchSearchPhotos();
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (BuildContext context, state) {
        if (state is PhotosLoadSuccess)
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10), //TODO nothink found
            child: Column(
              children: [
                const SizedBox(height: 34),
                _buildSearchBar(context),
                const SizedBox(height: 10),
                Expanded(child: SearchPhotoGrid(state: state)),
              ],
            ),
          );
        else if (state is PhotosLoadFailure) return ErrorLoadingBanner();
        return Container();
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        alignment: Alignment.center,
        color: AppColors.gray,
        width: double.infinity,
        height: 36,
        child: Row(
          children: [
            const SizedBox(width: 12),
            const Icon(Icons.search, size: 20, color: AppColors.manatee),
            const SizedBox(width: 5),
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Search',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: AppColors.manatee),
                ),
                cursorColor: AppColors.manatee,
                style: TextStyle(
                  color: AppColors.manatee,
                  fontSize: 23,
                ),
                onChanged: (inputText) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
