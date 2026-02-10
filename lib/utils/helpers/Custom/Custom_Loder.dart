import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:flutter/material.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoder extends StatefulWidget {
  final Color? color;
  final double? size;
  const CustomLoder({super.key, this.color = AppColors.white, this.size = 30});

  @override
  State<CustomLoder> createState() => _CustomLoderState();
}

class _CustomLoderState extends State<CustomLoder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 1.0,
        backgroundColor: widget.color!.withOpacity(0.2),
        valueColor: AlwaysStoppedAnimation<Color>(widget.color!),
      ),
    );
  }
}
