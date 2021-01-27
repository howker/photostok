import 'package:flutter/material.dart';

class TimeOfFotoCreation extends StatelessWidget {
  final String createdAt;

  const TimeOfFotoCreation({Key key, this.createdAt}) : super(key: key);

  String getTime(String createData) {
    String time = '';
    Map monthAsString = {
      1: 'january',
      2: 'february',
      3: 'march',
      4: 'april',
      5: 'may',
      6: 'jun',
      7: 'july',
      8: 'august',
      9: 'september',
      10: 'october',
      11: 'november',
      12: 'december',
    };
    var timeDifference =
        DateTime.now().difference(DateTime.parse(createData)).inHours;

    if (timeDifference == 0) {
      time = 'less then an hour ago';
    }
    if (timeDifference > 0 || timeDifference < 24) {
      time = 'today';
    }
    if (timeDifference > 24) {
      time =
          '${DateTime.parse(createData).day} ${monthAsString[DateTime.parse(createData).month]} ${DateTime.parse(createData).year}';
    }
    print(time);
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Text(getTime(createdAt),
        style: Theme.of(context).textTheme.headline3);
  }
}
