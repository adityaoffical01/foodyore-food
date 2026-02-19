// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Home_Screen.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/CustomInputField.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserRagisterationWidget extends StatefulWidget {
  final String? phoneNumber;
  final bool? isFromProfile;
  const UserRagisterationWidget({
    Key? key,
    this.isFromProfile = false,
    this.phoneNumber,
  }) : super(key: key);

  @override
  State<UserRagisterationWidget> createState() =>
      _UserRagisterationWidgetState();
}

class _UserRagisterationWidgetState extends State<UserRagisterationWidget> {
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController dobCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController genderCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  String? selectedGender;

  final List<String> genderList = ['Male', 'Female', 'Other'];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobCtrl.text = DateFormat('dd MMM yyyy').format(pickedDate);
      });
    }
  }

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.phoneNumber != null) {
      phoneCtrl.text = widget.phoneNumber!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFromProfile == true
          ? AppBar(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
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
                              border: Border.all(
                                width: 2.0,
                                color: AppColors.white,
                              ),
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
                ),

                const SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomInputFieldTheme(
                          horizontalPadding: 0.0,
                          controller: firstNameCtrl,
                          title: 'First Name',
                          hintText: 'Enter First Name',
                          isRequired: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomInputFieldTheme(
                          horizontalPadding: 0.0,
                          controller: lastNameCtrl,
                          title: 'Last Name',
                          hintText: 'Enter Last Name',
                          isRequired: true,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                CustomInputFieldTheme(
                  controller: phoneCtrl,
                  readOnly: true,
                  title: 'Phone Number',
                  hintText: 'Enter phone number',
                ),

                const SizedBox(height: 10),

                CustomInputFieldTheme(
                  controller: emailCtrl,
                  title: 'Email Address',
                  hintText: 'Enter email address',
                  isRequired: true,
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Gender',
                                style: const TextStyle(
                                  fontSize: AppSizes.medium,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.primaryFont,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: selectedGender,
                              items: genderList
                                  .map(
                                    (gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                              icon: const Icon(
                                Iconsax.arrow_down_1_copy,
                                size: 18,
                                color: AppColors.primaryColor,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                fillColor: AppColors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 1.2,
                                  ),
                                ),
                              ),
                              hint: const Text('Select Gender'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: CustomInputFieldTheme(
                              horizontalPadding: 0.0,
                              controller: dobCtrl,
                              title: 'Date of Birth',
                              hintText: 'Select Date',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                CustomInputFieldTheme(
                  controller: addressCtrl,
                  title: 'Address',
                  hintText: 'Enter address',
                  maximumLines: 3,
                ),
                const SizedBox(height: 10),
                CustomInputFieldTheme(
                  controller: passCtrl,
                  title: 'Password',
                  hintText: 'Enter email password',
                  obscureText: true,
                  isRequired: true,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
        child: CustomButton(
          horizontal: 0,
          title: 'Submit ',
          onPressed: () {
            widget.isFromProfile == true ? Get.back() : Get.to(HomeScreen());
          },
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
