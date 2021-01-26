//TODO time creation photo
import 'package:flutter/material.dart';

class TimeOfFotoCreation extends StatelessWidget {
  final String createdAt;

  const TimeOfFotoCreation({Key key, this.createdAt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(createdAt, style: Theme.of(context).textTheme.headline3);
  }
}
