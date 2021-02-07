import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 34),
            _buildSearchBar(context),
            SearchPhotoGrid(),
          ],
        ),
      ),
    );
  }
}

Widget _buildSearchBar(BuildContext context) {
  final _cubit = BlocProvider.of<PhotoCubit>(context);
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
              onSubmitted: (inputText) {
                _cubit.fetchSearchPhotos(inputText);
              },
            ),
          ),
        ],
      ),
    ),
  );
}
