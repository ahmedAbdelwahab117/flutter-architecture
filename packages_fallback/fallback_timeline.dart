import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Fallback Timeline widget that replicates the functionality of the timelines package
/// This provides a horizontal timeline with dots, connectors, and content items
class FallbackTimeline extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) oppositeContentsBuilder;
  final Widget Function(BuildContext, int) indicatorBuilder;
  final Widget Function(BuildContext, int, ConnectionType) connectorBuilder;
  final double Function(BuildContext, int) itemExtentBuilder;
  final Axis direction;
  final double connectorSpace;
  final double connectorThickness;
  final Color? connectorColor;
  final Gradient? connectorGradient;

  const FallbackTimeline({
    Key? key,
    required this.itemCount,
    required this.oppositeContentsBuilder,
    required this.indicatorBuilder,
    required this.connectorBuilder,
    required this.itemExtentBuilder,
    this.direction = Axis.horizontal,
    this.connectorSpace = 20.0,
    this.connectorThickness = 3.0,
    this.connectorColor,
    this.connectorGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return _buildHorizontalTimeline(context);
    } else {
      return _buildVerticalTimeline(context);
    }
  }

  Widget _buildHorizontalTimeline(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isLast = index == itemCount - 1;
        final itemExtent = itemExtentBuilder(context, index);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Content above/below
            SizedBox(
              width: itemExtent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top content (alternating)
                  if (index % 2 == 0)
                    oppositeContentsBuilder(context, index)
                  else
                    SizedBox(height: 50.h),
                  SizedBox(height: 10.h),
                  // Indicator (dot)
                  indicatorBuilder(context, index),
                  SizedBox(height: 10.h),
                  // Bottom content (alternating)
                  if (index % 2 == 1)
                    oppositeContentsBuilder(context, index)
                  else
                    SizedBox(height: 50.h),
                ],
              ),
            ),
            // Connector (except for last item) - use connectorBuilder if provided
            if (!isLast)
              connectorBuilder(context, index, ConnectionType.after),
          ],
        );
      }),
    );
  }

  Widget _buildVerticalTimeline(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(itemCount, (index) {
        final isLast = index == itemCount - 1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Indicator (dot)
                indicatorBuilder(context, index),
                SizedBox(width: 10.w),
                // Content
                Expanded(
                  child: oppositeContentsBuilder(context, index),
                ),
              ],
            ),
            // Connector (except for last item)
            if (!isLast)
              Container(
                width: connectorThickness.w,
                height: connectorSpace.h,
                margin: EdgeInsets.only(left: (10.h / 2) - (connectorThickness.w / 2)),
                decoration: BoxDecoration(
                  color: connectorGradient != null ? null : (connectorColor ?? Colors.grey),
                  gradient: connectorGradient,
                ),
              ),
          ],
        );
      }),
    );
  }
}

/// Connection type for timeline connectors
enum ConnectionType {
  before,
  after,
}

/// Helper class to build timeline tiles with connected style
class FallbackTimelineTileBuilder {
  final int itemCount;
  final Widget Function(BuildContext, int) oppositeContentsBuilder;
  final Widget Function(BuildContext, int) indicatorBuilder;
  final Widget Function(BuildContext, int, ConnectionType) connectorBuilder;
  final double Function(BuildContext, int) itemExtentBuilder;
  final ConnectionDirection connectionDirection;
  final ContentsAlign contentsAlign;

  const FallbackTimelineTileBuilder({
    required this.itemCount,
    required this.oppositeContentsBuilder,
    required this.indicatorBuilder,
    required this.connectorBuilder,
    required this.itemExtentBuilder,
    this.connectionDirection = ConnectionDirection.before,
    this.contentsAlign = ContentsAlign.alternating,
  });

  Widget build(BuildContext context, {
    Axis direction = Axis.horizontal,
    double connectorSpace = 20.0,
    double connectorThickness = 3.0,
    Color? connectorColor,
    Gradient? connectorGradient,
  }) {
    return FallbackTimeline(
      itemCount: itemCount,
      oppositeContentsBuilder: oppositeContentsBuilder,
      indicatorBuilder: indicatorBuilder,
      connectorBuilder: connectorBuilder,
      itemExtentBuilder: itemExtentBuilder,
      direction: direction,
      connectorSpace: connectorSpace,
      connectorThickness: connectorThickness,
      connectorColor: connectorColor,
      connectorGradient: connectorGradient,
    );
  }
}

/// Connection direction enum
enum ConnectionDirection {
  before,
  after,
}

/// Contents alignment enum
enum ContentsAlign {
  alternating,
  basic,
}

/// Simple dot indicator widget
class FallbackDotIndicator extends StatelessWidget {
  final double size;
  final Color color;

  const FallbackDotIndicator({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Decorated line connector widget
class FallbackDecoratedLineConnector extends StatelessWidget {
  final BoxDecoration decoration;
  final Axis direction;

  const FallbackDecoratedLineConnector({
    Key? key,
    required this.decoration,
    this.direction = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      // Extract gradient or color from decoration
      final gradient = decoration.gradient;
      final color = decoration.color;
      final borderWidth = decoration.border is Border ? (decoration.border as Border).top.width : 3.0;
      
      return Container(
        width: 20.w,
        height: borderWidth.h,
        decoration: BoxDecoration(
          gradient: gradient,
          color: gradient == null ? (color ?? Colors.grey) : null,
        ),
      );
    } else {
      final borderWidth = decoration.border is Border ? (decoration.border as Border).left.width : 3.0;
      return Container(
        width: borderWidth.w,
        height: 20.h,
        decoration: decoration,
      );
    }
  }
}

/// Timeline theme data (for compatibility)
class FallbackTimelineThemeData {
  final Axis direction;
  final FallbackConnectorThemeData? connectorTheme;

  const FallbackTimelineThemeData({
    this.direction = Axis.horizontal,
    this.connectorTheme,
  });
}

/// Connector theme data
class FallbackConnectorThemeData {
  final double space;
  final double thickness;

  const FallbackConnectorThemeData({
    this.space = 20.0,
    this.thickness = 3.0,
  });
}

