// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';

class CustomInputFieldTheme extends StatefulWidget {
  final TextEditingController controller;
  final Color? cursorColor;
  final String title;
  final TextStyle? inputTextStyle;
  final Color? fillColo;
  final String hintText;
  final TextInputType? inputType;
  final bool? readOnly;
  final int? maximumLines;
  final String? validationMessage;
  final bool isRequired;
  final double? horizontalPadding;

  const CustomInputFieldTheme({
    Key? key,
    required this.controller,
    this.cursorColor = AppColors.secondaryColor,
    required this.title,
    this.inputTextStyle = const TextStyle(
      fontSize: AppSizes.medium,
      fontWeight: FontWeight.bold,
      fontFamily: AppFonts.primaryFont,
      color: AppColors.black,
    ),
    this.fillColo = AppColors.white,
    required this.hintText,
    this.inputType = TextInputType.text,
    this.readOnly = false,
    this.maximumLines = 1,
    this.validationMessage = 'This field is required',
    this.isRequired = true,
    this.horizontalPadding = 20.0,
  }) : super(key: key);

  @override
  State<CustomInputFieldTheme> createState() => _CustomInputFieldThemeState();
}

class _CustomInputFieldThemeState extends State<CustomInputFieldTheme> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4),
            child: Text(widget.title, style: widget.inputTextStyle),
          ),
          TextFormField(
            cursorColor: widget.cursorColor,
            controller: widget.controller,
            keyboardType: widget.inputType,
            readOnly: widget.readOnly!,
            maxLines: widget.maximumLines,
            validator: (value) {
              if (widget.isRequired) {
                if (value == null || value.trim().isEmpty) {
                  return widget.validationMessage!;
                }
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: AppSizes.semiSmall,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.regular,
              ),
              filled: true,
              fillColor: widget.fillColo,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.2,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.2,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 1.2),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
