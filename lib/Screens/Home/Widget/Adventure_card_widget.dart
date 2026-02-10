// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_dottedline.dart';
import 'package:foodyore/utils/styles/Custom_circular_button.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AdventureCardWidget extends StatelessWidget {
  const AdventureCardWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  height: 180,
                  width: double.infinity,
                  'assets/images/formland.jpg',
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
                            'Farm land',
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
                        'Gomti nagar farm land in lucknow',
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
              Icon(Iconsax.cloud_sunny_copy, size: 20),
              Text(
                '2 Dyas - 3 Nights',
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
                    '${AppContent().moneySymbol} 12000/-',
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
          SizedBox(height: 5),
          CustomDottedDivider(color: AppColors.primaryColor.withAlpha(100)),
          SizedBox(height: 5),
          Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // for hotels
              Icon(Iconsax.buliding_copy, size: 20, color: AppColors.grey),
              Text(
                'Hotels',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // for picture
              Icon(Iconsax.camera_copy, size: 20, color: AppColors.grey),
              Text(
                'Sightseeing',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //for cab
              Icon(Iconsax.car_copy, size: 20, color: AppColors.grey),
              Text(
                'Cab',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //for meal
              Icon(Iconsax.cake_copy, size: 20, color: AppColors.grey),
              Text(
                'Meal',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
