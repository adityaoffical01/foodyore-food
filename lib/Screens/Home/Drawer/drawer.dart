// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/Auth/Mobile_verification_widget.dart';
import 'package:foodyore/Screens/Home/Drawer/Widget/drawer_heder.dart';
import 'package:foodyore/Screens/Home/Drawer/Widget/drawer_item.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:foodyore/Auth/User_ragisteration_form.dart';
import 'package:foodyore/Screens/About/about_us.dart';
import 'package:foodyore/Screens/Cart/cart_widget.dart';
import 'package:foodyore/Screens/Contact%20Us/Contact_us.dart';
import 'package:foodyore/Screens/MyOrders/My_order_widget.dart';
import 'package:foodyore/Screens/MyOrders/Terms%20&%20Condition/Terms_condition.dart';
import 'package:foodyore/Screens/Privacy%20Policy/Privacy_policy.dart';
import 'package:foodyore/services/app_config.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';

Drawer buildDrawer() {
  return Drawer(
    backgroundColor: AppColors.white,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeaderSection(),

        drawerItem(
          icon: Iconsax.edit_copy,
          title: 'Edit Profile',
          onTap: () =>
              Get.to(const UserRagisterationWidget(isFromProfile: true)),
        ),

        drawerItem(
          icon: Iconsax.shopping_cart_copy,
          title: 'Cart',
          onTap: () => Get.to(const CartWidget()),
        ),

        drawerItem(
          icon: Iconsax.shop_copy,
          title: 'My Order',
          onTap: () => Get.to(const MyOrderWidget()),
        ),

        drawerItem(
          icon: Iconsax.user_copy,
          title: 'About us',
          onTap: () => Get.to(AboutusWidget()),
        ),

        drawerItem(
          icon: Iconsax.call_copy,
          title: 'Contact us',
          onTap: () => Get.to(const ContatctUsScreen()),
        ),

        drawerItem(
          icon: Iconsax.shield,
          title: 'Terms & Conditions',
          onTap: () => Get.to(TermsConditionWidget()),
        ),

        drawerItem(
          icon: Iconsax.shield_security,
          title: 'Privacy Policy',
          onTap: () => Get.to(PrivacyPolicyWidget()),
        ),

        drawerItem(
          icon: Iconsax.lock_1_copy,
          title: 'Change Password',
          onTap: () {},
        ),

        drawerItem(
          icon: Iconsax.logout_copy,
          title: 'Logout',
          onTap: () {
            logout();
            Get.offAll(MobileVerificationWidget());
          },
        ),
      ],
    ),
  );
}
