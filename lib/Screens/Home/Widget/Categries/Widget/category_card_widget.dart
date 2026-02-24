import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

Widget categoryCard({
  required String title,
  required String host,
  required String location,
  required String buttonText,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              'assets/images/formland.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                host.isNotEmpty
                    ? RichText(
                        text: TextSpan(
                          text: 'Hosted by ',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.black,
                          ),
                          children: [
                            TextSpan(
                              text: host,
                              style: AppTextStyles.caption.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.location,
                      size: 10,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        maxLines: host.isEmpty ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: AppColors.primaryColor,
            child: Center(
              child: Text(
                buttonText,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
