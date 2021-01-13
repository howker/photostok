import 'package:photostok/res/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  final List<String> claims = [
    "ADULT",
    "HARM",
    "BULLY",
    "SPAM",
    "COPYRIGHT",
    "HATE"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: claims.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          splashColor: AppColors.dodgerBlue,
          onTap: () {
            Navigator.pop(context);
          },
          child: SafeArea(
            minimum: EdgeInsets.all(10),
            child: Center(
              child: Text(claims[index],
                  style: Theme.of(context).textTheme.headline2),
            ),
          ),
        );
      },
    );
  }
}
