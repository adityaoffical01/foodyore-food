// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_dottedline.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OrderDetailsWidget extends StatefulWidget {
  const OrderDetailsWidget({super.key});

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  static const int _itemCount = 2;
  final Set<int> _expandedItemIndexes = <int>{};

  void _toggleItemDetails(int index) {
    setState(() {
      if (_expandedItemIndexes.contains(index)) {
        _expandedItemIndexes.remove(index);
      } else {
        _expandedItemIndexes.add(index);
      }
    });
  }

  bool _isItemExpanded(int index) => _expandedItemIndexes.contains(index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Order Details'),
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              children: [
                _orderSummary(),
                _invoiceTo(),
                _orderDetails(),
                _paymentSummary(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  TextStyle _valueStyle({Color? color, bool bold = true}) {
    return AppTextStyles.bodySmall.copyWith(
      color: color ?? AppColors.black,
      fontFamily: AppFonts.regular,
      fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
    );
  }

  Widget _keyValueRow(
    String label,
    String value, {
    Color? valueColor,
    bool boldLabel = false,
    bool boldValue = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: boldLabel ? AppColors.black : AppColors.grey,
                fontWeight: boldLabel ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: _valueStyle(color: valueColor, bold: boldValue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderSummary() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Number', style: AppTextStyles.caption),
                  Text(
                    'ORD - 123456',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.black,
                      fontFamily: AppFonts.regular,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF146514).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Paid',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.regular,
                    color: const Color(0xFF146514),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomDottedDivider(color: AppColors.primaryColor.withOpacity(0.5)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _SummaryMeta(
                icon: Iconsax.document_1_copy,
                title: 'Invoice ID',
                value: 'FYD - 654321',
              ),
              _SummaryMeta(
                icon: Iconsax.calendar_1_copy,
                title: 'Order Date',
                value: '05 Mar 2026',
              ),
              _SummaryMeta(
                icon: Iconsax.timer_1_copy,
                title: 'Booking Date',
                value: '05 Mar 2026',
              ),
              _SummaryMeta(
                icon: Iconsax.timer_1_copy,
                title: 'Booking Time',
                value: '12:00 PM',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _invoiceTo() {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Invoice To',
                style: AppTextStyles.bodyLarge.copyWith(fontSize: 16),
              ),
              Text(
                'Pay To',
                style: AppTextStyles.bodyLarge.copyWith(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 5),
          CustomDottedDivider(color: AppColors.primaryColor.withOpacity(0.5)),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _partyDetails(
                  name: 'John Doe',
                  address: '123 Main Street, City, Country',
                  phone: '+1 234 567 890',
                  alignRight: false,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _partyDetails(
                  name: 'Restaurant Name',
                  address: '456 Restaurant Ave, City, Country',
                  phone: '+1 987 654 321',
                  alignRight: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _partyDetails({
    required String name,
    required String address,
    required String phone,
    required bool alignRight,
  }) {
    final CrossAxisAlignment alignment = alignRight
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final TextAlign textAlign = alignRight ? TextAlign.right : TextAlign.left;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(name, textAlign: textAlign, style: _valueStyle()),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          mainAxisAlignment: alignRight
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Icon(Iconsax.location_copy, color: AppColors.grey, size: 12),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                address,
                textAlign: textAlign,
                softWrap: true,
                style: AppTextStyles.caption.copyWith(color: AppColors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: alignRight
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Icon(Iconsax.call_copy, color: AppColors.grey, size: 12),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                phone,
                textAlign: textAlign,
                style: AppTextStyles.caption.copyWith(color: AppColors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _orderDetails() {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                'Ordered Items',
                style: AppTextStyles.bodyLarge.copyWith(fontSize: 16),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$_itemCount Items',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.regular,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CustomDottedDivider(color: AppColors.primaryColor.withOpacity(0.5)),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _itemCount,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: _orderItemCard(index),
              );
            },
          ),
          CustomDottedDivider(color: AppColors.primaryColor.withOpacity(0.5)),
          const SizedBox(height: 8),
          _keyValueRow(
            'Grand Total',
            '500/-',
            boldLabel: true,
            boldValue: true,
          ),
        ],
      ),
    );
  }

  Widget _orderItemCard(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/picture/bottom_background.jpg',
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Crab, Roti, Chawal Salad aalu ki sookhi sabji unlimitedCrab',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              _keyValueRow('No of Guest', '2'),
              InkWell(
                onTap: () => _toggleItemDetails(index),
                child: Text(
                  _isItemExpanded(index) ? 'Hide Details' : 'View Details',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              if (_isItemExpanded(index)) ...[
                _keyValueRow('Taxable Amount', '400/-'),
                _keyValueRow('CGST', '400/-'),
                _keyValueRow('SGST', '400/-'),
                _keyValueRow('Net Amount', '400/-'),
                _keyValueRow('Coopan Discount', '400/-'),
                _keyValueRow(
                  'Payable amount',
                  '400/-',
                  boldLabel: true,
                  boldValue: true,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _paymentSummary() {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: AppTextStyles.bodyLarge.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 8),
          CustomDottedDivider(color: AppColors.primaryColor.withOpacity(0.5)),
          const SizedBox(height: 8),
          _keyValueRow('Payment Method', 'COD'),
          _keyValueRow('Transaction ID', 'CASH'),
          _keyValueRow(
            'Payment Status',
            'Successful',
            valueColor: const Color(0xFF146514),
          ),
          _keyValueRow('PAN Number', 'ABCDE1234F'),
          _keyValueRow('GST IN', '22ABCDE1234F1Z5'),
          const SizedBox(height: 8),
          CustomDottedDivider(color: AppColors.primaryColor.withOpacity(0.5)),
          const SizedBox(height: 8),
          _keyValueRow('Total No. of Guest', '2'),
          _keyValueRow('Total Taxable Amount', '400/-'),
          _keyValueRow('Total CGST', '400/-'),
          _keyValueRow('Total SGST', '400/-'),
          _keyValueRow('Total Net Amount', '400/-'),
          _keyValueRow('Total Discount', '400/-'),
          const SizedBox(height: 8),
          CustomDottedDivider(color: AppColors.primaryColor.withOpacity(0.5)),
          const SizedBox(height: 8),
          _keyValueRow(
            'Grand Total',
            '500/-',
            boldLabel: true,
            boldValue: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryMeta extends StatelessWidget {
  const _SummaryMeta({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.textHintColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.grey),
        ),
        const SizedBox(height: 6),
        Text(title, style: AppTextStyles.caption),
        Text(
          value,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.black,
            fontFamily: AppFonts.regular,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
