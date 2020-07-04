import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:urgencias_flutter/urgencias/slider_view.dart';

void main() {
  testWidgets('Home Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      title: 'Urgencias Médicas',
      home: SliderView()
    ));

    expect(find.text('Less than'), findsNothing);
  });
}