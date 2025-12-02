import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

/// Fallback implementation for flutter_decorated_text package
/// Supports styled text with rules for URLs, mentions, hashtags, and custom patterns
class DecoratedTextFallback extends StatelessWidget {
  final String text;
  final TextDirection? textDirection;
  final List<dynamic> rules; // Can be DecoratorRuleFallback or DecoratorRule
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const DecoratedTextFallback({
    Key? key,
    required this.text,
    this.textDirection,
    required this.rules,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = style ?? DefaultTextStyle.of(context).style;
    final spans = _buildTextSpans(context, defaultStyle);
    
    Widget richText = RichText(
      textDirection: textDirection,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      text: TextSpan(
        style: defaultStyle,
        children: spans,
      ),
    );

    if (maxLines != null) {
      return richText;
    }
    return richText;
  }

  List<TextSpan> _buildTextSpans(BuildContext context, TextStyle defaultStyle) {
    if (text.isEmpty) {
      return [TextSpan(text: '')];
    }

    // Convert all rules to DecoratorRuleFallback
    final processedRules = rules.map((r) {
      if (r is DecoratorRule) {
        return r.toRule();
      }
      return r as DecoratorRuleFallback;
    }).toList();

    // First, process between rules to remove tags if needed
    String workingText = text;
    final List<_MatchInfo> allMatches = [];

    // Process between rules first
    for (final rule in processedRules) {
      if (rule is BetweenDecoratorRuleFallback) {
        int pos = 0;
        while (pos < workingText.length) {
          final startIdx = workingText.indexOf(rule.start, pos);
          if (startIdx == -1) break;
          
          final contentStart = startIdx + rule.start.length;
          final endIdx = workingText.indexOf(rule.end, contentStart);
          if (endIdx == -1) break;
          
          final content = workingText.substring(contentStart, endIdx);
          
          allMatches.add(_MatchInfo(
            start: startIdx,
            end: endIdx + rule.end.length,
            content: content,
            rule: rule,
          ));
          
          if (rule.removeMatchingCharacters) {
            workingText = workingText.substring(0, startIdx) + 
                         content + 
                         workingText.substring(endIdx + rule.end.length);
            pos = startIdx + content.length;
          } else {
            pos = endIdx + rule.end.length;
          }
        }
      }
    }

    // Now process other rules on the modified text
    for (final rule in processedRules) {
      if (rule is! BetweenDecoratorRuleFallback) {
        int pos = 0;
        while (pos < workingText.length) {
          final match = rule.findMatch(workingText, pos);
          if (match == null) break;
          
          final matchedText = match.group(0) ?? '';
          allMatches.add(_MatchInfo(
            start: match.start,
            end: match.end,
            content: matchedText,
            rule: rule,
          ));
          
          pos = match.end;
        }
      }
    }

    // Sort and remove overlaps
    allMatches.sort((a, b) => a.start.compareTo(b.start));
    final nonOverlapping = <_MatchInfo>[];
    for (final match in allMatches) {
      bool overlaps = false;
      for (final existing in nonOverlapping) {
        if (match.start < existing.end && match.end > existing.start) {
          overlaps = true;
          break;
        }
      }
      if (!overlaps) {
        nonOverlapping.add(match);
      }
    }
    nonOverlapping.sort((a, b) => a.start.compareTo(b.start));

    // Build spans
    final spans = <TextSpan>[];
    int currentPos = 0;

    for (final match in nonOverlapping) {
      if (match.start > currentPos) {
        spans.add(TextSpan(
          text: workingText.substring(currentPos, match.start),
          style: defaultStyle,
        ));
      }

      String displayText = match.content;
      if (match.rule.transformMatch != null) {
        displayText = match.rule.transformMatch!(displayText);
      }

      final spanStyle = match.rule.style ?? defaultStyle;
      spans.add(TextSpan(
        text: displayText,
        style: spanStyle,
        recognizer: match.rule.onTap != null
            ? (TapGestureRecognizer()..onTap = () => match.rule.onTap!(match.content))
            : null,
      ));

      currentPos = match.end;
    }

    if (currentPos < workingText.length) {
      spans.add(TextSpan(
        text: workingText.substring(currentPos),
        style: defaultStyle,
      ));
    }

    return spans.isEmpty ? [TextSpan(text: workingText, style: defaultStyle)] : spans;
  }
}

class _MatchInfo {
  final int start;
  final int end;
  final String content;
  final DecoratorRuleFallback rule;

  _MatchInfo({
    required this.start,
    required this.end,
    required this.content,
    required this.rule,
  });
}

/// Base class for decorator rules
abstract class DecoratorRuleFallback {
  final TextStyle? style;
  final void Function(String)? onTap;
  final String Function(String)? transformMatch;

  DecoratorRuleFallback({
    this.style,
    this.onTap,
    this.transformMatch,
  });

  Match? findMatch(String text, int startIndex);
}

/// Rule for text between start and end markers
class BetweenDecoratorRuleFallback extends DecoratorRuleFallback {
  final String start;
  final String end;
  final bool removeMatchingCharacters;

  BetweenDecoratorRuleFallback({
    required this.start,
    required this.end,
    this.removeMatchingCharacters = false,
    TextStyle? style,
    void Function(String)? onTap,
    String Function(String)? transformMatch,
  }) : super(style: style, onTap: onTap, transformMatch: transformMatch);

  @override
  Match? findMatch(String text, int startIndex) {
    final searchText = text.substring(startIndex);
    final startIdx = searchText.indexOf(start);
    if (startIdx == -1) return null;

    final contentStart = startIdx + start.length;
    final endIdx = searchText.indexOf(end, contentStart);
    if (endIdx == -1) return null;

    return _SimpleMatch(
      startIndex + startIdx,
      startIndex + endIdx + end.length,
      text.substring(startIndex + startIdx, startIndex + endIdx + end.length),
    );
  }
}

class _SimpleMatch implements Match {
  final int start;
  final int end;
  final String matchedText;

  _SimpleMatch(this.start, this.end, this.matchedText);

  @override
  String? group(int n) => n == 0 ? matchedText : null;

  @override
  String? groupNamed(String name) => null;

  @override
  int get groupCount => 0;

  @override
  Iterable<String> get groupNames => [];

  @override
  String get input => '';

  @override
  Pattern get pattern => RegExp('');

  @override
  String? operator [](int n) => group(n);

  @override
  List<String?> get groupsList => [matchedText];

  @override
  List<String?> groups(List<int> groupIndices) {
    // TODO: implement groups
    throw UnimplementedError();
  }
}

/// Rule for URLs
class UrlDecoratorRuleFallback extends DecoratorRuleFallback {
  UrlDecoratorRuleFallback({
    TextStyle? style,
    void Function(String)? onTap,
  }) : super(style: style, onTap: onTap);

  @override
  Match? findMatch(String text, int startIndex) {
    final urlPattern = RegExp(
      r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?',
    );
    final searchText = text.substring(startIndex);
    return urlPattern.firstMatch(searchText);
  }
}

/// Rule for text starting with specific prefix
class StartsWithDecoratorRuleFallback extends DecoratorRuleFallback {
  final String text;

  StartsWithDecoratorRuleFallback({
    required this.text,
    TextStyle? style,
    void Function(String)? onTap,
    String Function(String)? transformMatch,
  }) : super(style: style, onTap: onTap, transformMatch: transformMatch);

  @override
  Match? findMatch(String input, int startIndex) {
    final searchText = input.substring(startIndex);
    final pattern = RegExp('${RegExp.escape(text)}\\S+');
    return pattern.firstMatch(searchText);
  }
}

/// Rule for custom regex patterns
class RegexDecoratorRuleFallback extends DecoratorRuleFallback {
  final RegExp regExp;

  RegexDecoratorRuleFallback({
    required this.regExp,
    TextStyle? style,
    void Function(String)? onTap,
    String Function(String)? transformMatch,
  }) : super(style: style, onTap: onTap, transformMatch: transformMatch);

  @override
  Match? findMatch(String input, int startIndex) {
    final searchText = input.substring(startIndex);
    return regExp.firstMatch(searchText);
  }
}

/// Factory class to create rules similar to the original API
class DecoratorRule {
  static DecoratorRuleFallback between({
    required String start,
    required String end,
    bool removeMatchingCharacters = false,
    TextStyle? style,
    void Function(String)? onTap,
    String Function(String)? transformMatch,
  }) {
    return BetweenDecoratorRuleFallback(
      start: start,
      end: end,
      removeMatchingCharacters: removeMatchingCharacters,
      style: style,
      onTap: onTap,
      transformMatch: transformMatch,
    );
  }

  static DecoratorRuleFallback url({
    TextStyle? style,
    void Function(String)? onTap,
  }) {
    return UrlDecoratorRuleFallback(
      style: style,
      onTap: onTap,
    );
  }

  static DecoratorRuleFallback startsWith({
    required String text,
    TextStyle? style,
    void Function(String)? onTap,
    String Function(String)? transformMatch,
  })
  {
    return StartsWithDecoratorRuleFallback(
      text: text,
      style: style,
      onTap: onTap,
      transformMatch: transformMatch,
    );
  }

  // Constructor for direct rule creation with regex
  const DecoratorRule({
    required this.regExp,
    this.style,
    this.onTap,
    this.transformMatch,
  });

  final RegExp regExp;
  final TextStyle? style;
  final void Function(String)? onTap;
  final String Function(String)? transformMatch;

  // Convert to DecoratorRuleFallback
  DecoratorRuleFallback toRule() {
    return RegexDecoratorRuleFallback(
      regExp: regExp,
      style: style,
      onTap: onTap,
      transformMatch: transformMatch,
    );
  }
}

/// Alias for compatibility
typedef DecoratedText = DecoratedTextFallback;

/// Bidi (Bidirectional) text direction detection fallback
class Bidi {
  /// Detect RTL directionality from text
  /// Returns true if the text contains RTL characters (Arabic, Hebrew, etc.)
  static bool detectRtlDirectionality(String text) {
    if (text.isEmpty) return false;
    
    // Check for RTL characters (Arabic, Hebrew, etc.)
    final rtlPattern = RegExp(r'[\u0590-\u05FF\u0600-\u06FF\u0700-\u074F\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]');
    return rtlPattern.hasMatch(text);
  }
}
