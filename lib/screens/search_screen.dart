import 'package:flutter/material.dart';
import 'package:photostok/res/res.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          const SizedBox(height: 34),
          _buildSearchBar(context),
          const SizedBox(height: 10),
        ],
      ),
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
