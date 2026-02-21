import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';

Widget customDropdown({
  required String title,
  required List<String> items,
  required String? selectedValue,
  required Function(String?) onChanged,
  required String hint,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionTitle(title),
      DropdownButtonFormField<String>(
        value: selectedValue,
        isExpanded: true,
        isDense: true,
        // itemHeight: 40,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          border: _inputBorder(),
          enabledBorder: _inputBorder(),
          focusedBorder: _inputBorder(width: 1.2),
        ),
        hint: Text(hint),
      ),
    ],
  );
}
// ================= REUSABLE DROPDOWN =================

OutlineInputBorder _inputBorder({double width = 1}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.primaryColor, width: width),
  );
}

Widget _sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, bottom: 4),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: AppSizes.medium,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.primaryFont,
      ),
    ),
  );
}
