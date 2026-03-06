import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:intl/intl.dart';

class AppUtils {
  AppUtils._privateConstructor();

  static final AppUtils instance = AppUtils._privateConstructor();

  String convertStringToDateFormat(String stringDate) {
    String subscriptionExpireDate = "";
    subscriptionExpireDate = stringDate;

    DateTime startDateTime =
        DateTime.tryParse(subscriptionExpireDate) ?? DateTime.now();

    subscriptionExpireDate =
        '${startDateTime.day}/${startDateTime.month}/${startDateTime.year} ';

    return subscriptionExpireDate;
  }

  //Date Format : yyyy-MM-dd

  String convertDateToDDMMYYYYFormat({String? dateString}) {
    try {
      if (dateString == null || dateString.isEmpty) {
        return "--/--/--";
      }

      DateTime dt = DateTime.parse(dateString).toLocal();
      String date = DateFormat("yyyy-MM-dd hh:mm a").format(dt);
      return date;
    } catch (e) {
      // If parsing fails due to invalid format
      return "--/--/--";
    }
  }

  //Date Format : March 25,2020 - 10:30 PM
  String convertDateToMMMDDYYYYFormat({String? dateString}) {
    DateTime dt = DateTime.parse(dateString!).toLocal();
    String date = DateFormat("MMM dd,yyyy hh:mm a").format(dt).toString();
    return date;
  }

  String convertDateToTimeFormat({String? dateString}) {
    DateTime dt = DateTime.parse(dateString!).toLocal();
    String date = DateFormat("hh:mm a").format(dt).toString();
    return date;
  }

  // Date Format : 16 Mar 2026
  String convertDateToDDMMMYYYYFormat({String? dateString}) {
    try {
      if (dateString == null || dateString.trim().isEmpty) {
        return '-- --- ----';
      }
      final DateTime dt = DateTime.parse(dateString).toLocal();
      return DateFormat('dd MMM yyyy').format(dt);
    } catch (e) {
      return '-- --- ----';
    }
  }

  //Date Format : March 25,2020 - 10:30 PM
  String convertDateToMMMDDYYYYTimeFormat({String? dateString}) {
    DateTime dt = DateTime.parse(dateString!).toLocal();
    String date = DateFormat("MMM dd,yyyy hh:mm a").format(dt).toString();
    return date;
  }

  // Normalize mixed date inputs to yyyy-MM-dd for form fields / APIs.
  String normalizeToYMD(String rawDate) {
    final String cleanedDate = rawDate.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (cleanedDate.isEmpty) return '';

    DateTime? parsedDate = DateTime.tryParse(cleanedDate);
    if (parsedDate == null) {
      final List<String> patterns = [
        'MMM d yyyy hh:mma',
        'MMM d yyyy h:mma',
        'MMM d yyyy',
        'dd-MM-yyyy',
        'MM-dd-yyyy',
      ];

      for (final pattern in patterns) {
        try {
          parsedDate = DateFormat(pattern).parseLoose(cleanedDate);
          break;
        } catch (_) {}
      }
    }

    if (parsedDate == null) return cleanedDate;
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  // String convertDateToMMMDDYYYYFormat({String? dateString}) {
  //   if (dateString == null || dateString.isEmpty) {
  //     return '';
  //   }

  //   DateTime dt;
  //   try {
  //     dt = DateFormat("MM/dd/yyyy HH:mm:ss a").parse(dateString);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error parsing date: $e');
  //     }
  //     return '';
  //   }

  //   String date = DateFormat("dd MMM, yyyy").format(dt).toString();
  //   return date;
  // }

  void snackBar(String title, String message, bool isError) {
    Get.snackbar(
      title,
      message,
      backgroundColor: isError
          ? AppColors.red
          : const Color.fromARGB(255, 0, 141, 0),

      duration: const Duration(seconds: 3),
      titleText: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: AppColors.white),
      ),
    );
  }

  showToastMsg({
    BuildContext? context,
    required String msg,
    required bool isError,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? AppColors.red : AppColors.green,
      textColor: Colors.white,

      fontSize: 16.0,
    );
  }

  TimeOfDay? convertStringToTimeOfDay(String timeString) {
    try {
      // Parse the string to DateTime using a specific format
      DateTime parsedDateTime = DateFormat.jm().parse(
        timeString,
      ); // "7:30 PM" format
      return TimeOfDay(
        hour: parsedDateTime.hour,
        minute: parsedDateTime.minute,
      );
    } catch (e) {
      print("Error parsing time: $e");
      return null; // Return null if parsing fails
    }
  }

  showCustomSnackBar(
    String message, {
    bool isError = true,
    bool getXSnackBar = false,
  }) {
    if (message.isNotEmpty) {
      if (getXSnackBar) {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: isError ? AppColors.red : AppColors.green,
            message: message,
            maxWidth: 300,
            duration: const Duration(seconds: 1),
            snackStyle: SnackStyle.FLOATING,
            margin: const EdgeInsets.all(8),
            borderRadius: 10,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
          ),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            dismissDirection: DismissDirection.horizontal,
            margin: const EdgeInsets.only(
              right: 20,
              top: 10,
              bottom: 20,
              left: 10,
            ),
            duration: const Duration(seconds: 1),
            backgroundColor: isError ? AppColors.red : AppColors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Text(message),
          ),
        );
      }
    }
  }

  Future<void> openDirections({
    required double lat,
    required double long,
  }) async {
    final Uri androidGoogleMapUri = Uri.parse(
      'google.navigation:q=$lat,$long&mode=d',
    );
    final Uri iosAppleMapUri = Uri.parse('maps://?daddr=$lat,$long&dirflg=d');
    final Uri webGoogleMapUri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$long&travelmode=driving',
    );

    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(iosAppleMapUri)) {
          await launchUrl(iosAppleMapUri, mode: LaunchMode.externalApplication);
          return;
        }
      } else {
        if (await canLaunchUrl(androidGoogleMapUri)) {
          await launchUrl(
            androidGoogleMapUri,
            mode: LaunchMode.externalApplication,
          );
          return;
        }
      }

      if (await canLaunchUrl(webGoogleMapUri)) {
        await launchUrl(webGoogleMapUri, mode: LaunchMode.externalApplication);
        return;
      }

      showCustomSnackBar('Unable to open map application');
    } catch (_) {
      showCustomSnackBar('Unable to open map application');
    }
  }
}
