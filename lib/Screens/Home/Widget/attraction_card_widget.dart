// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Custom_circular_button.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AttractionCardWidget extends StatelessWidget {
  const AttractionCardWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: 320,
      margin: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 12),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                child: Image.asset(
                  height: 150,
                  width: 320,
                  'assets/images/pre-wedding-shoot-in-lucknow.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 12,
                left: 12,
                child: Row(
                  spacing: 10,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(66),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(66),
                          ),
                          child: Text(
                            'Events',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Spacer(),
                    CustomCircularButton(
                      color: AppColors.white,
                      icon: Icon(
                        Iconsax.whatsapp_copy,
                        color: AppColors.black,
                        size: 20,
                      ),
                    ),
                    CustomCircularButton(
                      color: AppColors.white,
                      icon: Icon(
                        Iconsax.call_calling,
                        color: AppColors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.45),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pre wedding shoot, in Lucknow',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          // height: 0.5,
                        ),
                      ),
                      Text(
                        'Lucknow, Uttar Pradesh',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          // height: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            spacing: 10,
            children: [
              Icon(Iconsax.cake_copy, size: 20),
              Text(
                'Pre wedding shoot',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    'Starting Price',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${AppContent().moneySymbol} 5000/-',
                    style: AppTextStyles.headingSmall.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: AppFonts.regular,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
