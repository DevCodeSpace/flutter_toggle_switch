import 'package:flutter/material.dart';

/// Displays [children] in a [Row] or [Column] depending on [isVertical].
///
/// When [isColumnToRow] is true, the orientation is flipped (used internally
/// for cases where the toggle's "vertical" layout should render children as
/// rows rather than columns).
class RowToColumn extends StatelessWidget {
  final List<Widget> children;
  final bool isVertical;
  final bool? isColumnToRow;

  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final CrossAxisAlignment? crossAxisAlignment;

  const RowToColumn({
    super.key,
    required this.children,
    required this.isVertical,
    this.isColumnToRow,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final bool renderAsRow = (isColumnToRow ?? false)
        ? isVertical
        : !isVertical;

    if (renderAsRow) {
      return Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: children,
      );
    }
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: children,
    );
  }
}
