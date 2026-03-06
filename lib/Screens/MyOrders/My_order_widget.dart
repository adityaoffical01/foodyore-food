// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/Screens/MyOrders/Widget/Order_Card.dart';
import 'package:foodyore/Screens/MyOrders/order_details.dart';
import 'package:foodyore/controller/order_controller.dart';
import 'package:foodyore/data/response/api_status.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/app_utils.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_Loder.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MyOrderWidget extends StatefulWidget {
  const MyOrderWidget({super.key});

  @override
  State<MyOrderWidget> createState() => _MyOrderWidgetState();
}

class _MyOrderWidgetState extends State<MyOrderWidget> {
  final OrderController _orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    _orderController.fetchOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
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
          'My Orders',
          style: AppTextStyles.headingSmall.copyWith(color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: CustomBackground(
          child: Obx(() {
            if (_orderController.isOrderHistoryLoading.value) {
              return const Center(
                child: CustomLoder(color: AppColors.primaryColor),
              );
            } else if (_orderController.orderHistoryData.value.status ==
                Status.ERROR) {
              return Center(
                child: Text(
                  'Failed to load orders. Please try again.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.red,
                  ),
                ),
              );
            } else {
              final orders =
                  _orderController.orderHistoryData.value.data?.data ?? [];
              return SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  itemBuilder: (context, index) {
                    final item = orders[index];
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => OrderDetailsWidget(orderId: item.orderId ?? ''),
                        );
                      },
                      child: OrderCard(
                        orderId: 'ORD - ${item.orderId}',
                        status: '${item.orderStatus}',
                        statusColor:
                            item.orderStatus!.toLowerCase().contains('pending')
                            ? AppColors.orange
                            : const Color(0xFF146514),
                        location:
                            ((item.location?.address1)! +
                                    (item.location?.address2 ?? '') +
                                    (' ${item.location?.cityName}') +
                                    (' ${item.location?.pinCode}'))
                                .toString(),

                        totalAmount: '${item.priceBreakup!.totalAmount}',
                        hostName: '${item.hostInfo!.hostName}',
                        orderDate: AppUtils.instance
                            .convertDateToDDMMMYYYYFormat(
                              dateString: item.orderDate,
                            ),
                        orderTime: '${item.visitTime}',
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
