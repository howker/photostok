import 'package:flutter/material.dart';
import 'package:photostok/res/res.dart';

class ErrorLoadingBanner extends StatelessWidget {
  const ErrorLoadingBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: const Color(0xFFE73664),
              height: 47,
              child: Row(
                children: [
                  const SizedBox(width: 23),
                  const Icon(
                    Icons.warning_amber_outlined,
                    color: AppColors.white,
                  ),
                  const SizedBox(width: 21),
                  Text(
                    'There was an error loading the feed',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
