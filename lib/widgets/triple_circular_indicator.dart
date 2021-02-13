import 'package:flutter/material.dart';

///Анимированный красивый круговой индикатор загрузки хотелось сделать
class TripleCircularIndicator extends StatelessWidget {
  const TripleCircularIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 48,
          width: 48,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: const Color(0xFF91DEFE),
          ),
        ),
        Container(
          height: 34.8,
          width: 34.8,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: const Color(0xFF50CAFD),
          ),
        ),
        Container(
          height: 21.6,
          width: 21.6,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: const Color(0xFF16B9FD),
          ),
        ),
      ],
    );
  }
}
