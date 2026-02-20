// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodyore/Auth/Controller/Auth_Controller.dart';
import 'package:foodyore/Screens/Home/Home_Screen.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/app_utils.dart';
import 'package:foodyore/utils/helpers/Custom/CustomInputField.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_dropdown.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserRagisterationWidget extends StatefulWidget {
  final String? phoneNumber;
  final String? verificationId;
  final bool? isFromProfile;

  const UserRagisterationWidget({
    Key? key,
    this.isFromProfile = false,
    this.phoneNumber,
    this.verificationId,
  }) : super(key: key);

  @override
  State<UserRagisterationWidget> createState() =>
      _UserRagisterationWidgetState();
}

class _UserRagisterationWidgetState extends State<UserRagisterationWidget> {
  final AuthController _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  String? selectedGender;
  String? selectedOccupation;
  String? selectedMaritalStatus;

  final genderList = ['Male', 'Female', 'Other'];
  final occupationList = ['Student', 'Services', 'Business', 'Other'];
  final maritalStatusList = ['Married', 'Unmarried'];

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.phoneNumber != null) {
      phoneCtrl.text = widget.phoneNumber!;
    }
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    dobCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      dobCtrl.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  Future<void> pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() => selectedImage = File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFromProfile == true
          ? AppBar(
              backgroundColor: AppColors.primaryColor,
              leading: IconButton(
                onPressed: Get.back,
                icon: const Icon(
                  Iconsax.arrow_left_2_copy,
                  color: AppColors.white,
                ),
              ),
              title: Text(
                'Edit Profile',
                style: AppTextStyles.headingSmall.copyWith(
                  color: AppColors.white,
                ),
              ),
            )
          : null,
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: CustomBackground(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _profileImageSection(),
                  const SizedBox(height: 20),
                  _nameRow(),
                  const SizedBox(height: 10),
                  _phoneField(),
                  const SizedBox(height: 10),
                  _emailField(),
                  const SizedBox(height: 10),
                  _genderDobRow(),
                  const SizedBox(height: 10),
                  _occupationDropdown(),
                  const SizedBox(height: 10),
                  _maritalDropdown(),
                  const SizedBox(height: 10),
                  _passwordField(),
                  const SizedBox(height: 20),
                  _submitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomSheet: _submitButton(),
    );
  }

  // ================= UI SECTIONS =================

  Widget _profileImageSection() {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: ClipOval(
              child: selectedImage != null
                  ? Image.file(
                      selectedImage!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/dp.jpg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: GestureDetector(
              onTap: pickImage,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2.0, color: AppColors.white),
                  color: AppColors.primaryColor,
                ),
                child: const Icon(
                  Iconsax.edit_copy,
                  size: 12,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: CustomInputFieldTheme(
              horizontalPadding: 0,
              controller: firstNameCtrl,
              title: 'First Name',
              hintText: 'Enter First Name',
              isRequired: true,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomInputFieldTheme(
              horizontalPadding: 0,
              controller: lastNameCtrl,
              title: 'Last Name',
              hintText: 'Enter Last Name',
              isRequired: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _phoneField() {
    return CustomInputFieldTheme(
      controller: phoneCtrl,
      readOnly: true,
      title: 'Phone Number',
      hintText: 'Enter phone number',
    );
  }

  Widget _emailField() {
    return CustomInputFieldTheme(
      controller: emailCtrl,
      title: 'Email Address',
      hintText: 'Enter email',
      isRequired: true,
    );
  }

  Widget _genderDobRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: customDropdown(
              title: "Gender",
              items: genderList,
              selectedValue: selectedGender,
              hint: "Select Gender",
              onChanged: (val) => setState(() => selectedGender = val),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: _selectDate,
              child: AbsorbPointer(
                child: CustomInputFieldTheme(
                  horizontalPadding: 0,
                  controller: dobCtrl,
                  title: 'Date of Birth',
                  hintText: 'Select Date',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _occupationDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: customDropdown(
        title: "Occupation",
        items: occupationList,
        selectedValue: selectedOccupation,
        hint: "Select Occupation",
        onChanged: (val) => setState(() => selectedOccupation = val),
      ),
    );
  }

  Widget _maritalDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: customDropdown(
        title: "Marital Status",
        items: maritalStatusList,
        selectedValue: selectedMaritalStatus,
        hint: "Select Marital Status",
        onChanged: (val) => setState(() => selectedMaritalStatus = val),
      ),
    );
  }

  Widget _passwordField() {
    return CustomInputFieldTheme(
      controller: passCtrl,
      title: 'Password',
      hintText: 'Create password',
      obscureText: true,
      isRequired: true,
    );
  }

  Widget _submitButton() {
    return Container(
      color: AppColors.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
      child: Obx(
        () => _authController.isOtpSending.value
            ? CustomButton(
                horizontal: 0,
                width: 200.0,
                isLoading: true,
                title: '',
                onPressed: () {},
                color: AppColors.primaryColor,
              )
            : CustomButton(
                horizontal: 0,
                width: 200.0,
                title: 'Submit',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.isFromProfile == true) {
                      Get.back();
                    } else {
                      if (firstNameCtrl.text.isEmpty ||
                          lastNameCtrl.text.isEmpty ||
                          emailCtrl.text.isEmpty ||
                          passCtrl.text.isEmpty) {
                        AppUtils.instance.snackBar(
                          "Error",
                          'Fill required fields!',
                          true,
                        );
                      }
                      final name =
                          "${firstNameCtrl.text.trim()} ${lastNameCtrl.text.trim()}";
                      _authController
                          .registerUser(
                            name: name,
                            email: emailCtrl.text.trim(),
                            password: passCtrl.text.trim(),
                            verificationId: widget.verificationId.toString(),
                            gender: selectedGender.toString().toLowerCase(),
                            dateOfBirth: dobCtrl.text.trim(),
                            occupation: selectedOccupation
                                .toString()
                                .toLowerCase(),
                            maritalStatus: selectedMaritalStatus
                                .toString()
                                .toLowerCase(),
                            phone: phoneCtrl.text.trim(),
                          )
                          .then((isRagister) {
                            if (isRagister == true) {
                              Get.offAll(HomeScreen());
                            }
                          });
                    }
                  }
                },
                color: AppColors.primaryColor,
              ),
      ),
    );
  }
}
