import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photostok/widgets/widgets.dart';

@TestOn('vm')
void main() {
  testWidgets('contain warning icon', (WidgetTester tester) async {
    await tester.pumpWidget(_wrap(ErrorLoadingBanner()));

    final finderBySemantic = find.bySemanticsLabel('Warning');

    expect(finderBySemantic, findsOneWidget);
  });
}

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(body: child),
    );
