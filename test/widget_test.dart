import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ratu_app_kecantikan/main.dart';

void main() {
  testWidgets('App loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FemmeWellApp());

    expect(find.text('FemmeWell'), findsOneWidget);
  });
}
