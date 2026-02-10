import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodyore/Auth/User_ragisteration_form.dart';
import 'package:foodyore/Screens/Home/Home_Screen.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class MobileVerificationWidget extends StatelessWidget {
  MobileVerificationWidget({Key? key}) : super(key: key);
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Center(
                      child: Lottie.asset(
                        height: 250,
                        width: 250,
                        'assets/animations/Login_verification.json',
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/icon/logo_icon.png',
                      width: 120,
                      fit: BoxFit.contain,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '!! Welcome Back !!',
                      style: AppTextStyles.headingMedium.copyWith(
                        color: AppColors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Nice to see you again.',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.black,
                        fontSize: 12,
                        height: 1.0,
                      ),
                    ),
                    SizedBox(height: 20),
                    IntlPhoneField(
                      controller: phoneController,
                      cursorColor: AppColors.secondaryColor,
                      decoration: InputDecoration(
                        labelText: '',
                        isDense: true,
                        hint: Text(
                          'Please enter a valid mobile number',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 1.5,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.red,
                            width: 1.5,
                          ),
                        ),

                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.red,
                            width: 2,
                          ),
                        ),
                      ),
                      initialCountryCode: 'IN',
                      invalidNumberMessage:
                          'Please enter a valid mobile number',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      width: 200,
                      color: AppColors.primaryColor,
                      title: 'Get OTP',
                      isShadow: false,
                      onPressed: () {
                        if (phoneController.text.isEmpty) {
                          showCustomSnackBar(
                            message: 'Please enter valid number',
                          );
                        } else {
                          openOtpBottomSheet(context);
                        }
                      },
                    ),

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By continuing, I agree to the ',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.grey,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                openTerms(
                                  url: AppContent().termsAndConditionsUrl,
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            child: TextButton(
              onPressed: () {
                Get.to(HomeScreen());
              },
              child: Text(
                'Skip',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                ),
              ),
            ),
            top: 50,
            right: 20,
          ),
        ],
      ),
    );
  }

  //for login OTP
  void openOtpBottomSheet(BuildContext context) {
    final otpController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Text('OTP Verification', style: AppTextStyles.headingMedium),
                const SizedBox(height: 8),
                Text(
                  'Enter the 6 digit OTP sent to your mobile number',
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Pinput(
                  controller: otpController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: PinTheme(
                    width: 48,
                    height: 48,
                    textStyle: AppTextStyles.headingMedium,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 48,
                    height: 48,
                    textStyle: AppTextStyles.headingMedium,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  errorPinTheme: PinTheme(
                    width: 48,
                    height: 48,
                    textStyle: AppTextStyles.headingMedium,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.red),
                    ),
                  ),
                  onCompleted: (pin) {},
                ),
                const SizedBox(height: 24),
                CustomButton(
                  width: double.infinity,
                  color: AppColors.primaryColor,
                  title: 'Verify OTP',
                  isShadow: false,
                  onPressed: () {
                    if (otpController.text.length < 6) {
                      showCustomSnackBar(message: 'Please enter valid OTP');
                    } else {
                      Get.to(UserRagisterationWidget());
                      // Get.to(CustomBottomNavBar());
                    }
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
