// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_dottedline.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String status;
  final Color statusColor;
  final String title;
  final String location;
  final String area;
  final String user;
  final String image;
  final double totalAmount;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.statusColor,
    required this.title,
    required this.location,
    required this.area,
    required this.user,
    required this.image,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _Header(orderId, status, statusColor),
          const SizedBox(height: 4),
          Divider(color: AppColors.primaryColor.withOpacity(0.5)),
          const SizedBox(height: 4),
          _ItemInfo(image, title, location, area, user),
          const SizedBox(height: 10),
          const CustomDottedDivider(),
          const SizedBox(height: 5),
          _TotalAmount(totalAmount),
        ],
      ),
    );
  }

  // for header
}

class _Header extends StatelessWidget {
  final String orderId;
  final String status;
  final Color color;

  const _Header(this.orderId, this.status, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            orderId,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.regular,
              color: AppColors.black,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.regular,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// for item info
class _ItemInfo extends StatelessWidget {
  final String image, title, location, area, user;

  const _ItemInfo(this.image, this.title, this.location, this.area, this.user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, height: 60, width: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _InfoWrap(location, area, user),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// for info wrap
class _InfoWrap extends StatelessWidget {
  final String a, b, c;

  const _InfoWrap(this.a, this.b, this.c);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [_text(a), _dot(), _text(b), _dot(), _text(c)],
    );
  }

  Widget _text(String value) => Text(
    value,
    style: AppTextStyles.bodySmall.copyWith(
      fontWeight: FontWeight.bold,
      fontFamily: AppFonts.regular,
      fontSize: 11.0,
    ),
  );

  Widget _dot() => const Icon(Icons.circle, size: 6);
}

// for total amount
class _TotalAmount extends StatelessWidget {
  final double amount;

  const _TotalAmount(this.amount);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Amount', style: AppTextStyles.bodyMedium),
          Text(
            '${AppContent().moneySymbol}${amount.toStringAsFixed(2)}',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.regular,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
