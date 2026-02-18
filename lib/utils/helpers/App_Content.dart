import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AppContent {
  String appName = "Foodyore";
  String appVersion = "1.0.0";
  String moneySymbol = "₹";
  String termsAndConditionsUrl =
      "https://foodyore.com/CUSTOMER_TERM_CONDITIONS.aspx";
}

class AppFonts {
  static const String primaryFont = 'Athelas';
  // static const String secondaryFont = '';
  static const String regular = 'Manrope';
}

class AppSizes {
  static const double extraSmall = 10.0;
  static const double small = 12.0;
  static const double semiSmall = 14.0;
  static const double medium = 16.0;
  static const double semiLarge = 18.0;
  static const double large = 20.0;
  static const double extraLarge = 22.0;
  static const double extraExtraLarge = 24.0;
}

void showCustomSnackBar({
  BuildContext? context,
  required String message,
  bool isError = false,
  bool showAtTop = false,
  Duration duration = const Duration(seconds: 3),
}) {
  final ctx = context ?? Get.context!;
  final messenger = ScaffoldMessenger.of(ctx);

  messenger.hideCurrentSnackBar();

  messenger.showSnackBar(
    SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      duration: duration,
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
      backgroundColor: isError ? AppColors.red : AppColors.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),

      margin: showAtTop
          ? EdgeInsets.only(
              top: MediaQuery.of(ctx).padding.top + 16,
              left: 16,
              right: 16,
            )
          : const EdgeInsets.only(bottom: 20, left: 16, right: 16),

      content: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: AppSizes.small,
                fontFamily: AppFonts.regular,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> openTerms({required String url}) async {
  final Uri uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}


String isSeenBoarding = 'isSeenBoarding';
String isLoginKey = 'isLoginKey';
String loginDataKey = 'loginDataKey';
String languageKey = 'applangauge';
String tokenKey = 'token';