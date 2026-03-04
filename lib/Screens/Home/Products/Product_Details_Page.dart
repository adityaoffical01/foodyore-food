// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Menu/Menu_Item_Widget.dart';
import 'package:foodyore/controller/category_controller.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/model/PDP_model.dart';
import 'package:foodyore/model/amenities_list_model.dart';
import 'package:foodyore/res/app_urls.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Custom_circular_button.dart';

class ProductDetailsPageWidget extends StatefulWidget {
  final String hostId;
  final String cattId;
  final String subCatId;
  final String descriptionId;

  const ProductDetailsPageWidget({
    Key? key,
    required this.hostId,
    required this.cattId,
    required this.subCatId,
    required this.descriptionId,
  }) : super(key: key);

  @override
  State<ProductDetailsPageWidget> createState() =>
      _ProductDetailsPageWidgetState();
}

class _ProductDetailsPageWidgetState extends State<ProductDetailsPageWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  DateTime? _selectedBookingDate;
  TimeOfDay? _selectedBookingTime;

  final CategoryController controller = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();

    controller.fetchDescriptionData(context, widget.descriptionId);

    controller.fetchAmenitiesData(
      context: context,
      catId: widget.cattId,
      subCatId: widget.subCatId,
      hostId: widget.hostId,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _resolveImagePath(String rawPath) {
    final path = rawPath.trim().replaceAll('\\', '/');
    if (path.startsWith('http')) return path;
    if (path.startsWith('assets/')) return path;
    if (path.startsWith('/')) return '${AppUrl.imageUrl}$path';
    return '${AppUrl.imageUrl}/$path';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomBackground(
        child: Obx(() {
          if (controller.pdpStatus.value == Status.LOADING) {
            return const Center(
              child: CustomLoder(color: AppColors.primaryColor),
            );
          }

          if (controller.pdpStatus.value == Status.ERROR) {
            return const Center(child: Text("Something went wrong"));
          }

          final PdpCommonModel data = controller.pdpData.value;

          return SingleChildScrollView(
            child: Column(
              children: [_buildImageSlider(data), _buildContentSection(data)],
            ),
          );
        }),
      ),
      bottomSheet: _buildBottomButton(),
    );
  }

  /* ---------------- IMAGE SLIDER ---------------- */

  Widget _buildImageSlider(PdpCommonModel data) {
    final sliderImages = data.images.isNotEmpty
        ? data.images
        : ['assets/images/formland.jpg'];

    return Stack(
      children: [
        SizedBox(
          height: 260,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: sliderImages.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (_, index) {
              final imagePath = _resolveImagePath(sliderImages[index]);

              if (imagePath.startsWith('assets/')) {
                return Image.asset(imagePath, fit: BoxFit.cover);
              }

              return Image.network(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.textHintColor.withAlpha(40),
                  child: const Icon(Iconsax.image),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              sliderImages.length,
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
        Positioned(
          top: 60,
          left: 10,
          child: _circleButton(
            icon: CupertinoIcons.chevron_back,
            onTap: () => Get.back(),
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
        icon: Icon(icon, color: AppColors.black),
      ),
    );
  }

  /* ---------------- CONTENT ---------------- */

  Widget _buildContentSection(PdpCommonModel data) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreadcrumbs(data),
          const SizedBox(height: 8),

          Text(data.title ?? '', style: AppTextStyles.headingSmall),
          const SizedBox(height: 8),

          _sectionTitle('About the Experience'),
          _paragraph(data.description ?? ''),
          const SizedBox(height: 12),

          _sectionTitle('Where we are'),
          _buildMapSection(data),
          const SizedBox(height: 12),

          _expectationSection(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs(PdpCommonModel data) {
    return Row(
      children: [
        _breadcrumbText(data.categoryName ?? ''),
        _dot(),
        _breadcrumbText(data.subCategoryName ?? ''),
        _dot(),
        Expanded(child: _breadcrumbText(data.title ?? '', bold: true)),
      ],
    );
  }

  Widget _buildMapSection(PdpCommonModel data) {
    return Column(
      children: [
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
                "${data.address ?? ''}, ${data.city ?? ''}, ${data.state ?? ''}",
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
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

  Widget _expectationSection() {
    return Obx(() {
      if (controller.amenitiesData.value.status == Status.LOADING) {
        return const SizedBox(
          height: 100,
          child: Center(child: CustomLoder(color: AppColors.primaryColor)),
        );
      }

      final amenities =
          controller.amenitiesData.value.data?.amenitiesData ?? [];

      if (amenities.isEmpty) {
        return const SizedBox();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('What to Expect'),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: amenities.length,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return _expectationCard(amenities[index]);
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _expectationCard(AmenitiesData item) {
    return Container(
      width: 170,
      height: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            /// IMAGE
            Image.network(
              item.amenitieImage ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.textHintColor.withAlpha(20),
                  child: const Icon(Iconsax.image),
                );
              },
            ),

            /// DARK GRADIENT OVERLAY
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                ),
              ),
            ),

            /// TEXT CONTENT
            Positioned(
              left: 12,
              bottom: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.amenitieType ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        height: 1.4,
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: '₹${item.price ?? 0} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const TextSpan(
                          text: 'per hour',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.caption.copyWith(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _paragraph(String text) {
    return Text(
      text,
      style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
    );
  }

  Widget _breadcrumbText(String text, {bool bold = false}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.caption.copyWith(
        color: AppColors.textPrimary,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _dot() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Icon(Icons.circle, size: 6),
  );

  /* ---------------- BOTTOM BUTTON ---------------- */

  Widget _buildBottomButton() {
    return CustomButton(
      isShadow: false,
      bottom: 20,
      horizontal: 30,
      title: 'Book Now',
      color: AppColors.primaryColor,
      onPressed: _showBookingModal,
    );
  }

  Future<void> _showBookingModal() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final canContinue =
                _selectedBookingDate != null && _selectedBookingTime != null;

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Choose booking slot',
                      style: AppTextStyles.headingSmall,
                    ),
                    const SizedBox(height: 14),
                    _bookingSelectionTile(
                      title: 'Select Date',
                      value: _selectedBookingDate == null
                          ? 'Tap to choose date'
                          : MaterialLocalizations.of(
                              context,
                            ).formatMediumDate(_selectedBookingDate!),
                      icon: Iconsax.calendar_1_copy,
                      onTap: () async {
                        await _pickBookingDate(
                          context,
                          onChanged: () => setModalState(() {}),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _bookingSelectionTile(
                      title: 'Select Time',
                      value: _selectedBookingTime == null
                          ? 'Tap to choose time'
                          : _selectedBookingTime!.format(context),
                      icon: Iconsax.watch_copy,
                      onTap: () async {
                        await _pickBookingTime(
                          context,
                          onChanged: () => setModalState(() {}),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: canContinue
                              ? AppColors.primaryColor
                              : AppColors.textHintColor.withAlpha(120),
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: canContinue
                            ? () {
                                Navigator.pop(bottomSheetContext);
                                _goToMenuPage();
                              }
                            : null,
                        child: const Text('Continue'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _pickBookingDate(
    BuildContext context, {
    required VoidCallback onChanged,
  }) async {
    final now = DateTime.now();
    final initialDate = _selectedBookingDate ?? now;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(now) ? now : initialDate,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 2),
    );

    if (pickedDate != null) {
      setState(() => _selectedBookingDate = pickedDate);
      onChanged();
    }
  }

  Future<void> _pickBookingTime(
    BuildContext context, {
    required VoidCallback onChanged,
  }) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedBookingTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() => _selectedBookingTime = pickedTime);
      onChanged();
    }
  }

  Widget _bookingSelectionTile({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.textHintColor.withAlpha(90)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textHintColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(icon, color: AppColors.primaryColor, size: 18),
          ],
        ),
      ),
    );
  }

  void _goToMenuPage() {
    Get.to(
      MenuItemWidget(
        categoryId: widget.cattId,
        subCategoryId: widget.subCatId,
        hostId: widget.hostId,
        locationId: controller.pdpData.value.locationId ?? '',
        titleName: controller.pdpData.value.title ?? '',
      ),
    );
  }
}
