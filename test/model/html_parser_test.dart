import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Parse HTML widget', (WidgetTester tester) async {
    String html =
        "<p>Split this line</p><em>With no tags or t&iacute;</em><p>Special char Tel&eacute;</p>";
    final RegExp exp =
        RegExp(r"<\/?[^>]+(>|$)", multiLine: true, caseSensitive: false);
    String texto = html.replaceAll(exp, '');
    texto = texto.replaceAll(RegExp(r'&aacute;'), 'á');
    texto = texto.replaceAll(RegExp(r'&eacute;'), 'é');
    texto = texto.replaceAll(RegExp(r'&iacute;'), 'í');
    texto = texto.replaceAll(RegExp(r'&oacute;'), 'ó');
    texto = texto.replaceAll(RegExp(r'&uacute;'), 'ú');
    texto = texto.replaceAll(RegExp(r'&ntilde;'), 'ñ');
    int index = texto.indexOf('<p>');
    int indexSpecial = texto.indexOf('é');
    expect(index, -1);
    expect(indexSpecial, isNot(equals(-1)));
  });
}
