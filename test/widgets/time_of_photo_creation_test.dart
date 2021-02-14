import 'package:flutter_test/flutter_test.dart';
import 'package:photostok/widgets/widgets.dart';

@TestOn('vm')
void main() {
  TimeOfFotoCreation timeOfFotoCreation;
  String createdAt = '2021-02-13T15:05:44-05:00';

  setUp(() {
    timeOfFotoCreation = TimeOfFotoCreation();
  });

  test('get time', () {
    expect(timeOfFotoCreation.getTime(createdAt), 'today');
  });
}
