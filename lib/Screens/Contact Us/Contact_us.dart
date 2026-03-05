import 'package:flutter/material.dart';
import 'package:foodyore/controller/contact_controller.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/CustomInputField.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ContatctUsScreen extends StatelessWidget {
  const ContatctUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ContactController controller = Get.put(ContactController());

    return Scaffold(
      appBar: CustomAppbar(title: 'Contact Us'),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'visit our head office at'.toUpperCase(),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.regular,
                    ),
                  ),
                  SizedBox(height: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/map.png',
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Chandrika Devi, Mandir Rd, Bakshi Ka Talab, Kathwara, Uttar Pradesh 226202',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.regular,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                          borderRadius: BorderRadius.circular(44.0),
                        ),
                        child: Text(
                          'Direction'.toUpperCase(),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Call Us on'.toUpperCase(),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.regular,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Icon(Iconsax.call_copy, color: AppColors.black, size: 12),
                      Text(
                        '+91 730 7608 296'.toUpperCase(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.regular,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Icon(Iconsax.call_copy, color: AppColors.black, size: 12),
                      Text(
                        '+91 009 2155 595'.toUpperCase(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.regular,
                        ),
                      ),
                    ],
                  ),

                  // for email
                  SizedBox(height: 12),
                  Text(
                    'Email Us on'.toUpperCase(),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.regular,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Icon(Iconsax.sms_copy, color: AppColors.black, size: 12),
                      Text(
                        'sandeep@eatind.com'.toLowerCase(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.regular,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Icon(Iconsax.sms_copy, color: AppColors.black, size: 12),
                      Text(
                        'info@eatind.com'.toLowerCase(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.regular,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Have a feedback? Write to us.'.toUpperCase(),
                      style: AppTextStyles.headingSmall.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomInputFieldTheme(
                    horizontalPadding: 0.0,
                    controller: controller.nameController,
                    title: 'Name',
                    inputTextStyle: TextStyle(
                      fontSize: AppSizes.small,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.regular,
                      color: AppColors.black,
                    ),
                    hintText: 'Enter First Name',
                  ),
                  SizedBox(height: 10),
                  CustomInputFieldTheme(
                    horizontalPadding: 0.0,
                    controller: controller.mobileController,
                    title: 'Mobile Number',
                    inputTextStyle: TextStyle(
                      fontSize: AppSizes.small,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.regular,
                      color: AppColors.black,
                    ),
                    hintText: 'Enter Mobile number',
                    inputType: TextInputType.phone,
                    maxLength: 10,
                  ),
                  SizedBox(height: 10),
                  CustomInputFieldTheme(
                    horizontalPadding: 0.0,
                    controller: controller.emailController,
                    title: 'Email Id',
                    inputTextStyle: TextStyle(
                      fontSize: AppSizes.small,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.regular,
                      color: AppColors.black,
                    ),
                    hintText: 'Enter email id',
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),
                  CustomInputFieldTheme(
                    horizontalPadding: 0.0,
                    controller: controller.subjectController,
                    title: 'Subject',
                    inputTextStyle: TextStyle(
                      fontSize: AppSizes.small,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.regular,
                      color: AppColors.black,
                    ),
                    hintText: 'Enter the property’s address',
                  ),
                  SizedBox(height: 10),
                  CustomInputFieldTheme(
                    horizontalPadding: 0.0,
                    controller: controller.messageController,
                    maximumLines: 4,
                    title: 'your message',
                    inputTextStyle: TextStyle(
                      fontSize: AppSizes.small,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.regular,
                      color: AppColors.black,
                    ),
                    hintText: 'Please share your message here',
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: CustomButton(
                      width: 200,
                      color: AppColors.primaryColor,
                      title: 'Submit',
                      onPressed: () => controller.submitContactForm(),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Loading Overlay
          Obx(() {
            if (controller.isLoading.value) {
              return Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}