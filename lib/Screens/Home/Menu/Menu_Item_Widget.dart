import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Cart/cart_widget.dart';
import 'package:foodyore/Screens/Home/Menu/Menu_Card.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_butoons.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(title: 'MENU'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBreadcrumbs(),
            const SizedBox(height: 20),

            /// MENU CARDS
            const MenuCard(
              image: 'assets/images/panner.jpg',
              title: '2 Kg Paneer Unlimited Roti And Rice ',
            ),
            const SizedBox(height: 10),
            const MenuCard(
              image: 'assets/images/mutton.jpg',
              title: '1 Kg Mutton With Unlimited Roti Chawal Salad',
            ),

            const SizedBox(height: 16),

            /// SPECIAL ATTRACTIONS
            _sectionTitle('Add Special Attractions to Your Package'),
            const SizedBox(height: 6),
            _attractionRow([
              _expectationCard(
                image: 'assets/images/fire.jpg',
                title: 'FireLand',
                amount: '200 per hour',
              ),
              _expectationCard(
                image: 'assets/images/boating.jpg',
                title: 'Boating',
                amount: '200 per hour',
              ),
            ]),

            const SizedBox(height: 16),

            _sectionTitle('Other Special Attractions'),
            const SizedBox(height: 6),
            _attractionRow([
              _expectationCard(
                image: 'assets/images/fire.jpg',
                title: 'Birthday Party for couple',
                amount: '25000',
              ),
              _expectationCard(
                image: 'assets/images/boating.jpg',
                title: 'Birthday Party (No Food)',
                amount: '150',
              ),
            ]),
            const SizedBox(height: 60),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: AppColors.backgroundColor,
        child: CustomButton(
          width: 200,
          color: AppColors.primaryColor,
          top: 10,
          bottom: 12,

          title: 'GO TO CART',
          onPressed: () {
            Get.to(CartWidget());
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  /// HELPERS

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _attractionRow(List<Widget> children) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(), 
      child: Row(
        children: children
            .map(
              (e) =>
                  Padding(padding: const EdgeInsets.only(right: 10), child: e),
            )
            .toList(),
      ),
    );
  }

  Widget _buildBreadcrumbs() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _breadcrumbText('FARMLANDS'),
        _dot(),
        _breadcrumbText('ORCHARDS BY ADITYA SINGH'),
        _dot(),
        _breadcrumbText('ADITYA AAM KA BAAG', bold: true),
        _dot(),
        _breadcrumbText('BOOKING'),
      ],
    );
  }

  Widget _breadcrumbText(String text, {bool bold = false}) {
    return Text(
      text,
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

  Widget _expectationCard({
    required String image,
    required String title,
    required String amount,
  }) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(image, width: 160, height: 100, fit: BoxFit.cover),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: QtySelector(onIncrease: () {}, onDecrease: () {}),
        ),
        Positioned(
          bottom: 6,
          left: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹$amount',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// for qty
class QtySelector extends StatelessWidget {
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  const QtySelector({required this.onIncrease, required this.onDecrease});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.primaryColor, width: 1.2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onDecrease,
            child: Icon(Icons.remove, color: AppColors.primaryColor, size: 18),
          ),
          Text(
            ' 1 ',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.regular,
            ),
          ),
          GestureDetector(
            onTap: onIncrease,
            child: Icon(Icons.add, color: AppColors.primaryColor, size: 18),
          ),
        ],
      ),
    );
  }
}
