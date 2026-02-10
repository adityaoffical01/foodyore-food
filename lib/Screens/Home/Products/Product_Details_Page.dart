// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Menu/Menu_Item_Widget.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Custom_circular_button.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class ProductDetailsPageWidget extends StatefulWidget {
  const ProductDetailsPageWidget({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPageWidget> createState() =>
      _ProductDetailsPageWidgetState();
}

class _ProductDetailsPageWidgetState extends State<ProductDetailsPageWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> images = [
    'assets/images/formland.jpg',
    'assets/images/formland.jpg',
    'assets/images/formland.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildImageSlider(), _buildContentSection()],
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.backgroundColor,
        child: _buildBottomButton(),
      ),
    );
  }

  /* ---------------------------- IMAGE SLIDER ---------------------------- */

  Widget _buildImageSlider() {
    return Stack(
      children: [
        SizedBox(
          height: 260,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) => setState(() {
              _currentIndex = index;
            }),
            itemBuilder: (_, index) => Image.asset(
              images[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),

        /// Indicator
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                width: _currentIndex == index ? 18 : 6,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? AppColors.primaryColor
                      : AppColors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),

        /// Top Buttons
        Positioned(
          top: 60,
          left: 10,
          right: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _circleButton(
                icon: CupertinoIcons.chevron_back,
                onTap: () => Get.back(),
              ),
              _circleButton(icon: Iconsax.whatsapp_copy),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circleButton({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCircularButton(
        color: AppColors.white,
        icon: Icon(icon, color: AppColors.black, size: 20),
      ),
    );
  }

  /* ---------------------------- CONTENT ---------------------------- */

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreadcrumbs(),
          const SizedBox(height: 8),
          Text('ADITYA AAM KA BAAG', style: AppTextStyles.headingSmall),
          const SizedBox(height: 5),

          _sectionTitle('About the Experience'),
          _paragraph(
            "Hosted in a working mango orchard, Neeraj Aam Baagan offers a relaxed farm-based dining experience where meals are prepared using traditional methods and seasonal ingredients. Guests are welcomed into an open, green setting designed for slow conversations and shared tables.",
          ),
          const SizedBox(height: 8),
          _paragraph(
            "नीरज आम बागान तेहतना भगवंतपुर माल मलिहाबाद आपका स्वागत है हमारे यहां शुद्ध देसी खाना चूल्हे पर बनाया जाता है जिसमें चूल्हे पर बना देसी मुर्गा, चूल्हे पर बना मटर पनीर, चूल्हे पर ही बनी हुई सब्जियां, हाथ से बनी रोटियां और भी खाने में अनेक व्यंजन उपलब्ध है धन्यवाद...",
          ),

          const SizedBox(height: 10),
          _sectionTitle('Location'),
          _buildMapSection(),

          const SizedBox(height: 12),
          _sectionTitle('What to Expect'),
          const SizedBox(height: 8),
          _expectationCard(),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs() {
    return Row(
      children: [
        _breadcrumbText('FARMLANDS'),
        _dot(),
        _breadcrumbText('ORCHARDS BY ADITYA SINGH'),
        _dot(),
        Expanded(child: _breadcrumbText('ADITYA AAM KA BAAG', bold: true)),
      ],
    );
  }

  Widget _breadcrumbText(String text, {bool bold = false}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: AppTextStyles.caption.copyWith(
        color: AppColors.black,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _dot() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Icon(Icons.circle, size: 6),
  );

  Widget _sectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.caption.copyWith(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.primaryFont,
      ),
    );
  }

  Widget _paragraph(String text) {
    return Text(
      text,
      style: AppTextStyles.caption.copyWith(color: AppColors.black),
    );
  }

  Widget _buildMapSection() {
    return Column(
      children: [
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/map.png',
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: Text(
                'Tethna Bhagwant Pur Chandrika Devi Road, Uttar Pradesh, Lucknow',
                maxLines: 2,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.black,
                  fontFamily: AppFonts.regular,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _directionButton(),
          ],
        ),
      ],
    );
  }

  Widget _directionButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(44),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Text(
        'Direction',
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _expectationCard() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/fire.jpg',
            width: 160,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 6,
          left: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fireplace',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹200 per hour',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /* ---------------------------- BOTTOM BUTTON ---------------------------- */

  Widget _buildBottomButton() {
    return CustomButton(
      isShadow: false,
      bottom: 20,
      horizontal: 30,
      title: 'Book Now',
      color: AppColors.primaryColor,
      onPressed: _openBookingBottomSheet,
    );
  }

  void _openBookingBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return _BookingBottomSheet();
      },
    );
  }
}

class _BookingBottomSheet extends StatefulWidget {
  @override
  State<_BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<_BookingBottomSheet> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Date & Time', style: AppTextStyles.headingSmall),
          Text(
            'Choose a date and time to check availability and book',
            style: AppTextStyles.caption.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 20),

          _pickerTile(
            title: selectedDate == null
                ? 'Select Date'
                : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
            icon: Iconsax.calendar_1_copy,
            onTap: _pickDate,
          ),

          const SizedBox(height: 12),

          /// Time Picker
          _pickerTile(
            title: selectedTime == null
                ? 'Select Time'
                : selectedTime!.format(context),
            icon: Icons.access_time,
            onTap: _pickTime,
          ),

          const SizedBox(height: 24),

          CustomButton(
            title: 'Confirm Booking',
            color: AppColors.primaryColor,
            horizontal: 0,
            onPressed: () {
              if (selectedDate == null || selectedTime == null) {
                showCustomSnackBar(
                  message: 'Please select date and time',
                  showAtTop: true,
                );
                return;
              }

              Get.to(MenuItemWidget());

              print('Date: $selectedDate');
              print('Time: $selectedTime');
            },
          ),
        ],
      ),
    );
  }

  Widget _pickerTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryColor),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
