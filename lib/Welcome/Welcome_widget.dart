// ignore_for_file: deprecated_member_use

import 'package:foodyore/Auth/Mobile_verification_widget.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:flutter/material.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:get/get.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/welcome.png',
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 250.0,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.black.withOpacity(0.4),
                          AppColors.black.withOpacity(0.9),
                          AppColors.black,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Discover India’s rich culture, traditions, and stories through authentic local food experiences hosted by real people across the country.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontFamily: AppFonts.regular,
                            fontWeight: FontWeight.w600,
                            fontSize: AppSizes.small,
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          title: 'Get Started',
                          tittleColor: AppColors.primaryColor,
                          raduis: 66.0,
                          isShadow: false,
                          horizontal: 0,
                          color: AppColors.white,
                          onPressed: () {
                            Get.off(
                              MobileVerificationWidget(),
                              // CustomBottomNavBar(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                        ),
                      ],
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
