import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';

class CustomDottedDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const CustomDottedDivider({
    super.key,
    this.height = 1,
    this.width = 3,
    this.color = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (2 * width)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: width,
              height: height,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}
