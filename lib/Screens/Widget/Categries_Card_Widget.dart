import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
          border: Border.all(color: AppColors.primaryColor, width: 0.4),
        ),
        child: Column(
          spacing: 2,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
              child: Image.asset(
                'assets/images/welcome.png',
                height: 95,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Farm Land',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
