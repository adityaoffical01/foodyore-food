// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodyore/controller/host_descriptions_controlller.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/model/amenities_list_model.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:foodyore/model/host_descripetions_model.dart';

import 'package:foodyore/Screens/Home/Menu/Menu_Item_Widget.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Custom_circular_button.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class ProductDetailsPageWidget extends StatefulWidget {
  final String hostId;
  final String cattId;
  final String subCatId;
  final String locationId;
  const ProductDetailsPageWidget({
    Key? key,
    required this.hostId,
    required this.cattId,
    required this.subCatId,
    required this.locationId,
  }) : super(key: key);

  @override
  State<ProductDetailsPageWidget> createState() =>
      _ProductDetailsPageWidgetState();
}

class _ProductDetailsPageWidgetState extends State<ProductDetailsPageWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final HostDescriptionsControlller controller = Get.put(
    HostDescriptionsControlller(),
  );

  @override
  void initState() {
    super.initState();
    controller.fetchHostData(context, widget.hostId); // 🔴 pass real hostId
    controller.fetcAnimatesData(
      context,
      widget.cattId,
      widget.subCatId,
      widget.hostId,
      widget.locationId,
    ); // 🔴 pass real hostId
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomBackground(
        child: Obx(() {
          if (controller.rxRequestStatus.value == Status.LOADING) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.rxRequestStatus.value == Status.ERROR) {
            return Center(
              child: Text(
                controller.error.value,
                style: AppTextStyles.bodySmall,
              ),
            );
          }

          final Data? data = controller.hostDescripetionsModel.value.data?.data;

          if (data == null) {
            return const Center(child: Text("No data found"));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_buildImageSlider(data), _buildContentSection(data)],
            ),
          );
        }),
      ),
      bottomSheet: Container(
        color: AppColors.backgroundColor,
        child: _buildBottomButton(),
      ),
    );
  }

  /* ---------------------------- IMAGE SLIDER ---------------------------- */

  Widget _buildImageSlider(Data data) {
    // final images = [
    //   data.hostDescription?.fileUpload1,
    //   data.hostDescription?.fileUpload2,
    //   data.hostDescription?.fileUpload3,
    //   data.hostDescription?.fileUpload4,
    // ].where((e) => e != null && e.isNotEmpty).toList();

    final List<String> images = [
      'assets/images/formland.jpg',
      'assets/images/formland.jpg',
      'assets/images/formland.jpg',
    ].where((e) => e != null && e.isNotEmpty).toList();

    return Stack(
      children: [
        SizedBox(
          height: 260,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (_, index) => Image.asset(
              images[index]!,
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

  Widget _buildContentSection(Data data) {
    final host = data.hostDescription;
    final location = data.location;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreadcrumbs(data),
          const SizedBox(height: 8),

          Text(host?.descriptionTitle ?? '', style: AppTextStyles.headingSmall),
          const SizedBox(height: 5),

          _sectionTitle('About the Experience'),
          _paragraph(host?.description ?? ''),

          const SizedBox(height: 10),
          _sectionTitle('Location'),
          _buildMapSection(location),

          // const SizedBox(height: 60),
          const SizedBox(height: 12),
          _sectionTitle('What to Expect'),
          _expectationSection(),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _expectationSection() {
    return Obx(() {
      if (controller.animatesListModel.value.status == Status.LOADING) {
        return const SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final amenities =
          controller.animatesListModel.value.data?.amenitiesData ?? [];

      if (amenities.isEmpty) {
        return const SizedBox(); // UI clean
      }

      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: amenities.map((item) {
          return _expectationCard(item);
        }).toList(),
      );
    });
  }

  Widget _expectationCard(AmenitiesData item) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            item.amenitieImage ?? '',
            width: 160,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Image.asset(
              'assets/images/fire.jpg',
              width: 160,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 6,
          left: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.amenitieType ?? '',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹${item.price ?? 0} ${item.unit ?? ''}',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBreadcrumbs(Data data) {
    return Row(
      children: [
        _breadcrumbText(data.location?.categoryName ?? ''),
        _dot(),
        _breadcrumbText(data.location?.subCategoryName ?? ''),
        _dot(),
        Expanded(
          child: _breadcrumbText(
            data.hostDescription?.descriptionTitle ?? '',
            bold: true,
          ),
        ),
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

  Widget _buildMapSection(Location? location) {
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
          children: [
            Expanded(
              child: Text(
                "${location?.address1 ?? ''}, "
                "${location?.cityName ?? ''}, "
                "${location?.stateName ?? ''}",
                maxLines: 2,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.black,
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

/* ---------------------------- BOOKING SHEET (UNCHANGED) ---------------------------- */

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
    if (date != null) setState(() => selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => selectedTime = time);
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
            style: AppTextStyles.caption,
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
              print(selectedDate);
              print(selectedTime);
              if (selectedDate == null || selectedTime == null) {
                showCustomSnackBar(
                  message: 'Please select date and time',
                  showAtTop: true,
                );
                return;
              }
              Get.to(MenuItemWidget());
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
            Text(title, style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }
}
