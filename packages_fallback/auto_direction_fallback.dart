import 'package:flutter/material.dart';

/// Fallback implementation for the `auto_direction` package.
///
/// Determines text direction (LTR / RTL) from the provided [text]
/// and wraps [child] with a [Directionality] widget.
class AutoDirectionFallback extends StatelessWidget {
  /// The text used to detect direction.
  final String text;

  /// Called when the calculated direction is RTL (`true`) or LTR (`false`).
  final ValueChanged<bool>? onDirectionChange;

  /// The child widget to display with the resolved [TextDirection].
  final Widget child;

  /// Optional alignment to match the real package's API (when used).
  final AlignmentGeometry? alignment;

  const AutoDirectionFallback({
    Key? key,
    required this.text,
    required this.child,
    this.onDirectionChange,
    this.alignment,
  }) : super(key: key);

  /// Simple Arabic letters detection:
  /// if any character is in the Arabic Unicode block, we treat the text as RTL.
  bool _containsArabic(String value) {
    for (final codeUnit in value.runes) {
      // Arabic (0600–06FF), Arabic Supplement (0750–077F),
      // Arabic Extended-A (08A0–08FF)
      if ((codeUnit >= 0x0600 && codeUnit <= 0x06FF) ||
          (codeUnit >= 0x0750 && codeUnit <= 0x077F) ||
          (codeUnit >= 0x08A0 && codeUnit <= 0x08FF)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isRtl = _containsArabic(text);

    // Notify listener if provided (true for RTL, false for LTR).
    onDirectionChange?.call(isRtl);

    final direction =
        isRtl ? TextDirection.rtl : TextDirection.ltr;

    Widget content = Directionality(
      textDirection: direction,
      child: child,
    );

    if (alignment != null) {
      content = Align(
        alignment: alignment!,
        child: content,
      );
    }

    return content;
  }
}




