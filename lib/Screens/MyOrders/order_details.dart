// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/controller/order_controller.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/model/Order_details_Model.dart';
import 'package:foodyore/model/order_model.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/app_utils.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_dottedline.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OrderDetailsWidget extends StatefulWidget {
  final String orderId;
  const OrderDetailsWidget({super.key, required this.orderId});

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  final OrderController _orderController = Get.put(OrderController());
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

  @override
  void initState() {
    super.initState();
    _orderController.fetchOrderDetails(orderId: widget.orderId);
  }

  bool _isItemExpanded(int index) => _expandedItemIndexes.contains(index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Order Details'),
      body: CustomBackground(
        child: Obx(() {
          if (_orderController.isOrderDetailsLoading.value) {
            return Center(child: CustomLoder(color: AppColors.primaryColor));
          } else if (_orderController.orderDetailsData.value.status ==
                  Status.ERROR ||
              (_orderController
                      .orderDetailsData
                      .value
                      .data
                      ?.data
                      ?.items
                      ?.isEmpty ??
                  true)) {
            return Center(child: Text('no found data'));
          } else {
            final details = _orderController.orderDetailsData.value.data?.data;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    _orderSummary(
                      orderId: details!.orderId.toString(),
                      payStatus: details.paymentStatus.toString(),
                      orderDate: details.createdDate.toString(),
                      invoiceId: details.orderId.toString(),
                      bookDate: details.orderDate.toString(),
                      repotingTime: details.visitTime.toString(),
                    ),
                    _invoiceTo(
                      custInfo: details.customerInfo,
                      hostInfo: details.hostInfo,
                      location: details.location,
                    ),
                    _orderDetails(
                      details.items,
                      '${details.priceBreakup?.totalAmount ?? '0'}',
                    ),
                    _paymentSummary(
                      details.priceBreakup,
                      details.paymentStatus ?? '',
                      _getTotalGuests(details.items),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }
        }),
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

  Widget _orderSummary({
    required String orderId,
    required String payStatus,

    required String orderDate,
    required String invoiceId,
    required String bookDate,
    required String repotingTime,
  }) {
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
                    'ORD - $orderId',
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
                  color: payStatus.toLowerCase() == 'paid'
                      ? const Color(0xFF146514).withOpacity(0.1)
                      : AppColors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  payStatus,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.regular,
                    color: payStatus.toLowerCase() == 'paid'
                        ? const Color(0xFF146514)
                        : AppColors.orange,
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
            children: [
              _SummaryMeta(
                icon: Iconsax.document_1_copy,
                title: 'Invoice ID',
                value: 'FYD - $invoiceId',
              ),
              _SummaryMeta(
                icon: Iconsax.calendar_1_copy,
                title: 'Order Date',
                value: AppUtils.instance.convertDateToDDMMMYYYYFormat(
                  dateString: bookDate,
                ),
              ),
              _SummaryMeta(
                icon: Iconsax.timer_1_copy,
                title: 'Booking Date',
                value: AppUtils.instance.convertDateToDDMMMYYYYFormat(
                  dateString: orderDate,
                ),
              ),
              _SummaryMeta(
                icon: Iconsax.timer_1_copy,
                title: 'Booking Time',
                value: repotingTime,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _invoiceTo({
    OrderCustomerInfoModel? custInfo,
    OrderHostInfoModel? hostInfo,
    OrderLocationModel? location,
  }) {
    final hostAddress = [
      location?.address1,
      location?.address2,
      location?.cityName,
      location?.pinCode,
    ].where((value) => (value ?? '').trim().isNotEmpty).join(', ');

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
                  name: custInfo?.customerName ?? 'Guest',
                  address: custInfo?.emailId ?? 'address',
                  phone: custInfo?.mobile ?? '+91 123456',
                  alignRight: false,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _partyDetails(
                  name: hostInfo?.hostName ?? '-',
                  address: hostAddress.isEmpty ? '-' : hostAddress,
                  phone: hostInfo?.hostMobile ?? '-',
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

  Widget _orderDetails(List<OrderDetailsItemModel>? orderItem, String total) {
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
                  '${orderItem?.length ?? 0} Items',
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
            itemCount: orderItem?.length ?? 0,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final item = orderItem![index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: _orderItemCard(index, item),
              );
            },
          ),
          CustomDottedDivider(color: AppColors.primaryColor.withOpacity(0.5)),
          const SizedBox(height: 8),
          _keyValueRow(
            'Grand Total',
            '${AppContent().moneySymbol}$total/-',
            boldLabel: true,
            boldValue: true,
          ),
        ],
      ),
    );
  }

  Widget _orderItemCard(int index, OrderDetailsItemModel item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.itemImage ?? '',
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.textHintColor.withOpacity(0.2),
                ),
                width: 60,
                height: 60,
                child: Icon(Iconsax.image_copy, color: AppColors.grey),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.itemName ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              _keyValueRow('No of Guest', item.numberOfGuest ?? '0'),
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
                _keyValueRow(
                  'Taxable Amount',
                  '${item.priceBreakup?.taxableAmount ?? '0'}/-',
                ),
                _keyValueRow(
                  'CGST',
                  '${item.priceBreakup?.cgstAmount ?? '0'}/-',
                ),
                _keyValueRow(
                  'SGST',
                  '${item.priceBreakup?.sgstAmount ?? '0'}/-',
                ),
                _keyValueRow(
                  'Net Amount',
                  '${item.priceBreakup?.netAmount ?? '0'}/-',
                ),
                _keyValueRow(
                  'Coopan Discount',
                  '${item.priceBreakup?.discountAmount ?? '0'}/-',
                ),
                _keyValueRow(
                  'Payable amount',
                  '${item.priceBreakup?.payableAmount ?? '0'}/-',
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

  int _getTotalGuests(List<OrderDetailsItemModel>? items) {
    if (items == null || items.isEmpty) return 0;

    int totalGuests = 0;
    for (final item in items) {
      final guests = int.tryParse((item.numberOfGuest ?? '').trim()) ?? 0;
      totalGuests += guests;
    }
    return totalGuests;
  }

  Widget _paymentSummary(
    OrderPriceBreakupModel? priceBreakup,
    String status,
    int totalGuests,
  ) {
    final String normalizedStatus = status.trim().toLowerCase();
    final Color paymentStatusColor =
        (normalizedStatus == 'unpaid' || normalizedStatus == 'pending')
        ? AppColors.orange
        : const Color(0xFF146514);

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
            status,
            valueColor: paymentStatusColor,
          ),
          _keyValueRow('PAN Number', 'ABCDE1234F'),
          _keyValueRow('GST IN', '22ABCDE1234F1Z5'),
          const SizedBox(height: 8),
          CustomDottedDivider(color: AppColors.primaryColor.withOpacity(0.5)),
          const SizedBox(height: 8),
          _keyValueRow('Total number of guest', '$totalGuests'),
          _keyValueRow('Total Taxable Amount', '${priceBreakup?.serviceTax}/-'),
          _keyValueRow('Total CGST & SGSR', '${priceBreakup?.cgstSgstTax}/-'),
          _keyValueRow('Total Net Amount', '${priceBreakup?.netAmount}'),
          _keyValueRow('Total Discount', '${priceBreakup?.discountAmount}/-'),
          const SizedBox(height: 8),
          CustomDottedDivider(color: AppColors.primaryColor.withOpacity(0.5)),
          const SizedBox(height: 8),
          _keyValueRow(
            'Grand Total',
            '${priceBreakup?.totalAmount}/-',
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