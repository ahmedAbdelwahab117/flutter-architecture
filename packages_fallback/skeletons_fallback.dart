import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Fallback implementation for the `skeletons` package using shimmer.
/// Provides skeleton loading placeholders that match the skeletons package API.

/// Style configuration for SkeletonAvatar
class SkeletonAvatarStyle {
  final BoxShape? shape;
  final double? width;
  final double? height;
  final double? minHeight;
  final double? maxHeight;
  final BorderRadius? borderRadius;

  const SkeletonAvatarStyle({
    this.shape,
    this.width,
    this.height,
    this.minHeight,
    this.maxHeight,
    this.borderRadius,
  });
}

/// Style configuration for SkeletonLine
class SkeletonLineStyle {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final bool? randomLength;
  final double? minLength;
  final double? maxLength;
  final AlignmentGeometry? alignment;

  const SkeletonLineStyle({
    this.height,
    this.width,
    this.borderRadius,
    this.randomLength,
    this.minLength,
    this.maxLength,
    this.alignment,
  });
}

/// Style configuration for SkeletonParagraph
class SkeletonParagraphStyle {
  final int? lines;
  final double? spacing;
  final SkeletonLineStyle? lineStyle;

  const SkeletonParagraphStyle({
    this.lines,
    this.spacing,
    this.lineStyle,
  });
}

/// Skeleton Avatar widget - displays a shimmer effect in avatar shape
class SkeletonAvatar extends StatelessWidget {
  final SkeletonAvatarStyle? style;

  const SkeletonAvatar({
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final shape = style?.shape ?? BoxShape.rectangle;
    final width = style?.width ?? 50.0;
    final height = style?.height ?? 50.0;
    final minHeight = style?.minHeight;
    final maxHeight = style?.maxHeight;
    final borderRadius = style?.borderRadius;

    double finalHeight = height;
    if (minHeight != null && maxHeight != null) {
      final random = Random();
      finalHeight = minHeight + (random.nextDouble() * (maxHeight - minHeight));
    } else if (minHeight != null) {
      finalHeight = minHeight;
    }

    Widget skeletonWidget = Container(
      width: width.isInfinite ? double.infinity : width,
      height: finalHeight,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? (borderRadius ?? BorderRadius.circular(8))
            : null,
      ),
    );

    return Shimmer.fromColors(
      baseColor: Colors.grey[300] ?? Colors.grey,
      highlightColor: Colors.grey[100] ?? Colors.white,
      child: skeletonWidget,
    );
  }
}

/// Skeleton Line widget - displays a shimmer effect in line shape
class SkeletonLine extends StatelessWidget {
  final SkeletonLineStyle? style;

  const SkeletonLine({
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    double? lineWidth = style?.width;
    final randomLength = style?.randomLength ?? false;
    final minLength = style?.minLength;
    final maxLength = style?.maxLength;
    final height = style?.height ?? 10.0;
    final borderRadius = style?.borderRadius ?? BorderRadius.circular(8);
    final alignment = style?.alignment;

    if (randomLength && minLength != null && maxLength != null) {
      final random = Random();
      lineWidth = minLength + (random.nextDouble() * (maxLength - minLength));
    } else if (randomLength && minLength != null) {
      final random = Random();
      lineWidth = minLength + (random.nextDouble() * (MediaQuery.of(context).size.width - minLength));
    }

    Widget skeletonWidget = Container(
      height: height,
      width: lineWidth ?? (style?.width ?? double.infinity),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
    );

    if (alignment != null) {
      skeletonWidget = Align(
        alignment: alignment,
        child: skeletonWidget,
      );
    }

    return Shimmer.fromColors(
      baseColor: Colors.grey[300] ?? Colors.grey,
      highlightColor: Colors.grey[100] ?? Colors.white,
      child: skeletonWidget,
    );
  }
}

/// Skeleton Paragraph widget - displays multiple shimmer lines
class SkeletonParagraph extends StatelessWidget {
  final SkeletonParagraphStyle? style;

  const SkeletonParagraph({
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final lines = style?.lines ?? 3;
    final spacing = style?.spacing ?? 5.0;
    final lineStyle = style?.lineStyle ?? const SkeletonLineStyle();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        lines,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: index < lines - 1 ? spacing : 0,
          ),
          child: SkeletonLine(style: lineStyle),
        ),
      ),
    );
  }
}
