// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_dottedline.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String status;
  final Color statusColor;
  final String hostName;
  final String location;
  final String totalAmount;
  final String orderDate;
  final String orderTime;
  const OrderCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.statusColor,
    required this.location,
    required this.totalAmount,
    required this.hostName,
    required this.orderDate,
    required this.orderTime,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(orderId, status, statusColor),
          const SizedBox(height: 4),
          Divider(color: AppColors.primaryColor.withOpacity(0.5)),
          const SizedBox(height: 4),
          _info(hostName, location, orderTime, orderDate),
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

Widget _info(
  String hostName,
  String location,
  String orderTime,
  String orderDate,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          hostName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        Row(
          spacing: 5,
          children: [
            Text(
              'Reporting',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.black),
            ),
            Icon(Icons.circle, size: 6, color: AppColors.black),
            Text(
              orderDate,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.black),
            ),
            Icon(Icons.circle, size: 6, color: AppColors.black),
            Text(
              orderTime,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.black),
            ),
          ],
        ),

        Row(
          spacing: 8,
          children: [
            Icon(
              Iconsax.location_copy,
              size: 12,
              color: AppColors.primaryColor,
            ),
            Expanded(child: Text(location, style: AppTextStyles.bodyMedium)),
          ],
        ),
      ],
    ),
  );
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

// for total amount
class _TotalAmount extends StatelessWidget {
  final String amount;

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
            '${AppContent().moneySymbol}${amount}',
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
