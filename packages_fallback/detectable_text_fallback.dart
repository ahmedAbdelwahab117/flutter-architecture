import 'package:flutter/material.dart';

/// Simple fallback implementation to replace the `detectable_text_field` package.
///
/// It keeps the same API surface used in this app (basicStyle, decoratedStyle,
/// detectionRegExp, onDetectionTyped, onDetectionFinished) but relies only on
/// Flutter's built‑in widgets.

/// Regular expression for detecting hashtags or @mentions.
final RegExp hashTagAtSignRegExp =
    RegExp(r'(#\w+|@\w+)', unicode: true, multiLine: true);

/// Regular expression for detecting @mentions only.
final RegExp atSignRegExp =
    RegExp(r'@\w+', unicode: true, multiLine: true);

/// Fallback text field that mimics the old `DetectableTextField` API.
///
/// Note: This implementation does NOT highlight detected text inside the
/// field; it only triggers callbacks when detection matches.
class DetectableTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final double? cursorHeight;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final InputDecoration? decoration;
  final TextStyle? basicStyle;

  /// Style of detected segments – currently unused in this lightweight fallback,
  /// but kept for API compatibility.
  final TextStyle? decoratedStyle;

  final RegExp? detectionRegExp;
  final ValueChanged<String>? onDetectionTyped;
  final VoidCallback? onDetectionFinished;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final InputCounterWidgetBuilder? buildCounter;

  const DetectableTextField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textAlignVertical,
    this.cursorHeight,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.decoration,
    this.basicStyle,
    this.decoratedStyle,
    this.detectionRegExp,
    this.onDetectionTyped,
    this.onDetectionFinished,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.buildCounter,
  }) : super(key: key);

  void _handleDetection(String value) {
    final regExp = detectionRegExp;
    if (regExp == null) {
      return;
    }

    final matches = regExp.allMatches(value);
    if (matches.isNotEmpty) {
      final last = matches.last;
      final detected = value.substring(last.start, last.end);
      onDetectionTyped?.call(detected);
    } else {
      onDetectionFinished?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textAlignVertical: textAlignVertical,
      cursorHeight: cursorHeight,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: decoration,
      style: basicStyle ?? Theme.of(context).textTheme.bodyMedium,
      buildCounter: buildCounter,
      onSubmitted: onSubmitted,
      onTap: onTap,
      onChanged: (value) {
        onChanged?.call(value);
        _handleDetection(value);
      },
    );
  }
}


