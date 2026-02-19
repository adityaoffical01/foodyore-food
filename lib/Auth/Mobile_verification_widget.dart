import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodyore/Auth/Controller/Auth_Controller.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:foodyore/Screens/Home/Home_Screen.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

final AuthController _authController = Get.find<AuthController>();

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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  _buildAnimation(),
                  const SizedBox(height: 20),
                  _buildLogo(),
                  const SizedBox(height: 10),
                  _buildWelcomeText(),
                  const SizedBox(height: 20),
                  _buildPhoneField(),
                  const SizedBox(height: 10),
                  _buildGetOtpButton(context),
                  const SizedBox(height: 20),
                  _buildTermsText(),
                ],
              ),
            ),
          ),
          _buildSkipButton(),
        ],
      ),
    );
  }

  // ================= UI Sections =================

  Widget _buildAnimation() {
    return Center(
      child: Lottie.asset(
        'assets/animations/Login_verification.json',
        height: 250,
        width: 250,
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/icon/logo_icon.png',
      width: 120,
      fit: BoxFit.contain,
      color: AppColors.primaryColor,
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
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
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return IntlPhoneField(
      controller: phoneController,
      cursorColor: AppColors.secondaryColor,
      initialCountryCode: 'IN',
      invalidNumberMessage: 'Please enter a valid mobile number',
      decoration: _phoneInputDecoration(),
    );
  }

  InputDecoration _phoneInputDecoration() {
    return InputDecoration(
      isDense: true,
      hintText: 'Please enter a valid mobile number',
      hintStyle: AppTextStyles.caption.copyWith(
        color: AppColors.grey,
        fontSize: 12,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.red, width: 2),
      ),
    );
  }

  Widget _buildGetOtpButton(BuildContext context) {
    return Obx(
      () => _authController.isOtpSending.value
          ? CustomButton(
              width: 200,
              color: AppColors.primaryColor,
              title: '',
              isShadow: false,
              isLoading: true,
              onPressed: () {},
            )
          : CustomButton(
              width: 200,
              color: AppColors.primaryColor,
              title: 'Get OTP',
              isShadow: false,
              onPressed: () => _validateAndProceed(context),
            ),
    );
  }

  Widget _buildTermsText() {
    return RichText(
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
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                openTerms(url: AppContent().termsAndConditionsUrl);
              },
          ),
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return Positioned(
      top: 50,
      right: 20,
      child: TextButton(
        onPressed: () => Get.to(HomeScreen()),
        child: Text(
          'Skip',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.primaryColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // ================= Logic =================

  void _validateAndProceed(BuildContext context) {
    if (phoneController.text.trim().isEmpty) {
      showCustomSnackBar(message: 'Please enter valid number', isError: true);
    } else {
      _authController.initOTP(phoneController.text.trim()).then((i) {
        if (i == true) {
          openOtpBottomSheet(context);
        }
      });
    }
  }

  // ================= OTP Bottom Sheet =================

  void openOtpBottomSheet(BuildContext context) {
    final otpController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _OtpBottomSheet(
        otpController: otpController,
        phone: phoneController.text.trim(),
      ),
    );
  }
}

class _OtpBottomSheet extends StatelessWidget {
  final String phone;
  final TextEditingController otpController;

  const _OtpBottomSheet({required this.otpController, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHandle(),
            Text('OTP Verification', style: AppTextStyles.headingMedium),
            const SizedBox(height: 8),
            Text(
              'Enter the 6 digit OTP sent to your mobile number',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildOtpField(),
            const SizedBox(height: 24),
            _buildVerifyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      height: 4,
      width: 40,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildOtpField() {
    return Pinput(
      controller: otpController,
      length: 4,
      keyboardType: TextInputType.number,
      defaultPinTheme: _pinTheme(),
      focusedPinTheme: _pinTheme(isFocused: true),
      errorPinTheme: _pinTheme(isError: true),
    );
  }

  PinTheme _pinTheme({bool isFocused = false, bool isError = false}) {
    return PinTheme(
      width: 48,
      height: 48,
      textStyle: AppTextStyles.headingMedium.copyWith(color: AppColors.black),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isError ? AppColors.red : AppColors.primaryColor,
          width: isFocused ? 2 : 1,
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return Obx(
      () => _authController.isOtpVerifying.value
          ? CustomButton(
              width: 200,
              color: AppColors.primaryColor,
              title: '',
              isShadow: false,
              isLoading: true,
              onPressed: () {},
            )
          : CustomButton(
              width: 200,
              color: AppColors.primaryColor,
              title: 'Verify OTP',
              isShadow: false,
              onPressed: () {
                if (otpController.text.length < 4) {
                  showCustomSnackBar(message: 'Please enter valid OTP');
                } else {
                  _authController.verifyOTP(
                    otp: otpController.text.trim(),
                    mobileNumber: phone,
                  );
                }
              },
            ),
    );
  }
}
