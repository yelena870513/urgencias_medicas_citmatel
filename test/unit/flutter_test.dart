import 'package:flutter_test/flutter_test.dart';
import 'package:urgencias_flutter/store/store.dart';
import 'package:urgencias_flutter/urgencias/hotel_home_screen.dart';
 void main() {
  testWidgets('Test description', (WidgetTester tester) async {
    final StoreModel model = StoreModel();
    await tester.pumpWidget(HotelHomeScreen(model));
    expect(find.text('Favoritos'), findsOneWidget);
  });
} 