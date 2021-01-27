import 'package:flutter/material.dart';
import 'package:photostok/res/res.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 34),
          Container(
            width: 300,
            height: 36,
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Search',
                hintStyle: Theme.of(context).textTheme.headline2,
              ),
              cursorColor: AppColors.white,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 23,
              ),
              onChanged: (inputText) {},
            ),
          ),
        ],
      ),
    );
  }
}
