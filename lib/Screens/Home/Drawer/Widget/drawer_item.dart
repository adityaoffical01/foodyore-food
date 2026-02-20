import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';

Widget drawerItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: AppColors.primaryColor),
    title: Text(title),
    trailing: Icon(
      Icons.arrow_forward_ios,
      size: 16,
      color: AppColors.primaryColor,
    ),
    onTap: onTap,
  );
}
