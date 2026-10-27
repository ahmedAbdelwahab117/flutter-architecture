import 'package:flutter/material.dart';

class ResponsiveRowColumn extends StatelessWidget {
  final List<Widget> children;
  final bool isTablet;
  final MainAxisAlignment mainAxisAlignment;
final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  const ResponsiveRowColumn({
    this.mainAxisSize = MainAxisSize.max, 
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    if (isTablet) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children.map((child) => child).toList(),
      );
    }

    return Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children.map((child) => child).toList(),
    );
  }
}
