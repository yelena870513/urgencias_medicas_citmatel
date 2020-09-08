import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

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

  testWidgets('Discover HTML Images', (WidgetTester tester) async {
    String html =
        "<div><img alt=\"image1\"/ src=\"image1.png\"/></div><div><img alt=\"image2\"/ src=\"image2.png\"/></div><div><img alt=\"image3\"/ src=\"image3.png\"/></div>";
    var document = parse(html);
    List<Element> images = document.getElementsByTagName('img');

    int imageCount = images.length;
    expect(imageCount, 3);
    expect(images[0].attributes['alt'], "image1");
    expect(images[0].attributes['src'], "image1.png");
  });

  testWidgets('Retrieve caption for image', (WidgetTester tester) async {
    String src = "asset:assets/images/img/9f919ff3cf34fb9d37e6c7c77604b011.png";
    String caption = '';
    List<Map> gallery = [
      {
        "id": 39,
        "file": "4430e42b73d1c3f0c5c461d658bc33dc.png",
        "caption":
            "Fig. 21 Imagen transorbitaria para medición del di&aacute;metro de la vaina del nervio óptico, go: globo ocular y no: nervio óptico."
      },
      {
        "id": 40,
        "file": "4d150cfc135c3bd7402214910fb46a22.png",
        "caption":
            "Fig. 22 Imagen cervical donde se visualiza VYI: vena yugular interna y ACI: arteria carótida interna."
      },
      {
        "id": 41,
        "file": "9f919ff3cf34fb9d37e6c7c77604b011.png",
        "caption":
            "Fig. 23 Imágenes en corte transversal (A y B) y longitudinal (C y D) de a: arteria subclavia y v: vena subclavia."
      }
    ];

    Map captionItem =
        gallery.firstWhere((Map g) => src.indexOf(g['file']) != -1);
    if (captionItem != null) {
      caption = captionItem['caption'];
    }
    expect(caption,
        "Fig. 23 Imágenes en corte transversal (A y B) y longitudinal (C y D) de a: arteria subclavia y v: vena subclavia.");
    expect(captionItem, isNotNull);
  });
}
