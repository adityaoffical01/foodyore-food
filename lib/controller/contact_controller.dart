import 'package:flutter/material.dart';
import 'package:foodyore/repository/contact_repo.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/utils/app_utils.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final ContactRepo _contactRepo = ContactRepo();

  // Form field controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> submitContactForm() async {
    // Basic validation
    if (nameController.text.trim().isEmpty) {
      AppUtils.instance.snackBar("Error", "Please enter your name", true);
      return;
    }
    if (mobileController.text.trim().isEmpty) {
      AppUtils.instance.snackBar("Error", "Please enter mobile number", true);
      return;
    }
    if (mobileController.text.trim().length < 10) {
      AppUtils.instance.snackBar("Error", "Please enter valid 10-digit mobile number", true);
      return;
    }
    if (emailController.text.trim().isEmpty) {
      AppUtils.instance.snackBar("Error", "Please enter email", true);
      return;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      AppUtils.instance.snackBar("Error", "Please enter valid email", true);
      return;
    }
    if (subjectController.text.trim().isEmpty) {
      AppUtils.instance.snackBar("Error", "Please enter subject", true);
      return;
    }
    if (messageController.text.trim().isEmpty) {
      AppUtils.instance.snackBar("Error", "Please enter your message", true);
      return;
    }

    try {
      isLoading.value = true;

      // Prepare request body
      Map body = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "mobileNo": mobileController.text.trim(),
        "subjectName": subjectController.text.trim(),
        "messageText": messageController.text.trim(),
      };

      print("Contact Form Data: $body");

      final response = await _contactRepo.postData(
        AppUrl.contact_us_URL,
        body,
      );

      isLoading.value = false;

      // Show success message
      AppUtils.instance.snackBar(
        "Success",
        response['message'] ?? "Your message has been sent successfully",
        false,
      );

      // Clear form after successful submission
      clearForm();
      
    } catch (e) {
      isLoading.value = false;
      print("Error submitting contact form: $e");
      AppUtils.instance.snackBar(
        "Error",
        e.toString(),
        true,
      );
    }
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    mobileController.clear();
    subjectController.clear();
    messageController.clear();
  }

  @override
  void onClose() {
    // Dispose controllers
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}