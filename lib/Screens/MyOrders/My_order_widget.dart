// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/Screens/MyOrders/Widget/Order_Card.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MyOrderWidget extends StatelessWidget {
  const MyOrderWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Iconsax.arrow_left_2_copy, color: AppColors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          'My Orders',
          style: AppTextStyles.headingSmall.copyWith(color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: CustomBackground(
          child: SingleChildScrollView(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 15,
              itemBuilder: (context, index) {
                return OrderCard(
                  orderId: 'ORD - 123456',
                  status: 'Delivered',
                  statusColor: const Color(0xFF146514),
                  title: 'American Burger',
                  location: 'Village',
                  area: 'Raja Itaunja Bahadurpur',
                  user: 'Raghvendra Singh',
                  image: 'assets/images/pre-wedding-shoot-in-lucknow.jpg',
                  totalAmount: 250,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            ),
          ),
        ),
      ),
    );
  }
}
