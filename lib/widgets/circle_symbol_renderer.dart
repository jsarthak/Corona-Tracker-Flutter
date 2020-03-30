import 'package:charts_flutter/flutter.dart';
import 'dart:math';
import 'package:charts_flutter/src/text_element.dart' as element;
import 'package:charts_flutter/src/text_style.dart' as style;

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  final String text;
  CustomCircleSymbolRenderer({this.text});
  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      Color fillColor,
      FillPatternType fillPattern,
      Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        fillPattern: fillPattern,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
      Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
          bounds.height + 10),
      fill: Color.black,
    );
    var textStyle = style.TextStyle();
    textStyle.color = Color.white;
    textStyle.fontSize = 14;
    canvas.drawText(element.TextElement(text, style: textStyle),
        (bounds.left).round(), (bounds.top - 28).round());
  }
}
