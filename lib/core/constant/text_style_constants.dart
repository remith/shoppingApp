import 'dart:ui';

import 'package:shopping_app/core/constant/colors.dart';
import 'package:flutter/material.dart';

class UITextStyle {
  UITextStyle._();

  static const regular = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.normal,
    color: Color(UIColorConstants.primary),
  );

  static const TextStyle header = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Base TextStyle for titles
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(UIColorConstants.primary),
  );

  // Base TextStyle for body text
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: Color(UIColorConstants.primary),
  );

  // Base TextStyle for captions
  static final TextStyle caption = TextStyle(
    fontSize: 12,
    color: const Color(UIColorConstants.primary),
  );
}
