// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/Auth/User_ragisteration_form.dart';
import 'package:foodyore/Screens/About/about_us.dart';
import 'package:foodyore/Screens/Cart/cart_widget.dart';
import 'package:foodyore/Screens/Contact%20Us/Contact_us.dart';
import 'package:foodyore/Screens/MyOrders/My_order_widget.dart';
import 'package:foodyore/Screens/MyOrders/Terms%20&%20Condition/Terms_condition.dart';
import 'package:foodyore/Screens/Privacy%20Policy/Privacy_policy.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

Drawer buildDrawer() {
  return Drawer(
    backgroundColor: AppColors.white,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 1.0),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/dp.jpg',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Nittya Singh',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.regular,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),

              Text(
                'nittyasingh@gmail.com',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: AppFonts.regular,
                  // height: 1.2,
                ),
              ),

              Text(
                '+91 9876543210',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: AppFonts.regular,
                  // height: 1.2,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Iconsax.edit_copy, color: AppColors.primaryColor),
          title: Text('Edit Profile'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.primaryColor,
          ),
          onTap: () {
            Get.to(const UserRagisterationWidget(isFromProfile: true));
          },
        ),
        ListTile(
          leading: Icon(
            Iconsax.shopping_cart_copy,
            color: AppColors.primaryColor,
          ),
          title: Text('Cart'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.primaryColor,
          ),
          onTap: () {
            Get.to(const CartWidget());
          },
        ),
        ListTile(
          leading: Icon(Iconsax.shop_copy, color: AppColors.primaryColor),
          title: Text('My Order'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.primaryColor,
          ),
          onTap: () {
            Get.to(const MyOrderWidget());
          },
        ),
        ListTile(
          leading: Icon(Iconsax.user_copy, color: AppColors.primaryColor),
          title: Text('About us'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.primaryColor,
          ),
          onTap: () {
            Get.to(AboutusWidget());
          },
        ),
        ListTile(
          leading: Icon(Iconsax.call_copy, color: AppColors.primaryColor),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.primaryColor,
          ),
          title: Text('Contact us'),
          onTap: () {
            Get.to(const ContatctUsScreen());
          },
        ),
        ListTile(
          leading: Icon(Iconsax.shield, color: AppColors.primaryColor),
          title: Text('Terms & Conditions'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.primaryColor,
          ),
          onTap: () {
            Get.to(TermsConditionWidget());
          },
        ),
        ListTile(
          leading: Icon(Iconsax.shield_security, color: AppColors.primaryColor),
          title: Text('Privacy Policy'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.primaryColor,
          ),
          onTap: () {
            Get.to(PrivacyPolicyWidget());
          },
        ),
        ListTile(
          leading: Icon(Iconsax.lock_1_copy, color: AppColors.primaryColor),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.primaryColor,
          ),
          title: Text('Change Password'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Iconsax.logout_copy, color: AppColors.primaryColor),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.primaryColor,
          ),
          title: Text('Logout'),
          onTap: () {},
        ),

        // Spacer(),
        // Container(
        //   color: AppColors.white,
        //   child: Text(
        //     '  Version 1.0.0',
        //     style: TextStyle(color: AppColors.grey),
        //   ),
        // ),
      ],
    ),
  );
}
