import 'dart:io';

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

class ImageSpanBuilder extends SpecialTextSpanBuilder {
  /// whether show background for @somebody
  final bool showAtBackground;
  ImageSpanBuilder({this.showAtBackground = false});

  @override
  TextSpan build(String data, {TextStyle? textStyle, onTap}) {
    var textSpan = super.build(data, textStyle: textStyle, onTap: onTap);
    return textSpan;
  }

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap, required int index}) {
    if (flag == null || flag == "") return null;

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, UploadImageSpan.flag)) {
      return UploadImageSpan(textStyle!,
          start: index - (UploadImageSpan.flag.length - 1));
    }
    return null;
  }
}

class UploadImageSpan extends SpecialText {
  static const String flag = '<img';
  final int start;
  String _imageUrl = '';

  UploadImageSpan(TextStyle textStyle, {required this.start})
      : super(
      flag,
      "/>",
      textStyle
  );

  @override
  InlineSpan finishText() {
    final String text = flag + getContent() + '>';
    final dom.Document html = parse(text);
    final dom.Element img = html
        .getElementsByTagName('img')
        .first;
    final String? url = img.attributes['src'];
    _imageUrl = url ?? '';


    return ImageSpan(
        FileImage(File(_imageUrl)),
        imageWidth: 400,
        imageHeight: 300,
        actualText: "imagefield",
        start: start,
        margin: const EdgeInsets.only(left: 2.0, bottom: 0.0, right: 2.0)
    );
  }
}