import 'package:cc_avenue/cc_avenue.dart';
import 'package:foodyore/utils/app_utils.dart';
import 'package:get/get.dart';

class CartPaymentController extends GetxController {
  RxBool isPaying = false.obs;

  Future<void> payNow({required double totalAmount}) async {
    if (isPaying.value) return;

    if (totalAmount <= 0) {
      AppUtils.instance.snackBar(
        'Payment',
        'Total amount must be greater than zero.',
        true,
      );
      return;
    }

    try {
      isPaying.value = true;
      update();
      _validateDirectConfig();

      final orderId = DateTime.now().millisecondsSinceEpoch.toString();
      final amount = totalAmount.toStringAsFixed(2);

      await CcAvenue.cCAvenueInit(
        transUrl: _CcAvenueConfig.transUrl,
        rsaKeyUrl: _CcAvenueConfig.rsaKeyUrl,
        accessCode: _CcAvenueConfig.accessCode,
        merchantId: _CcAvenueConfig.merchantId,
        orderId: orderId,
        currencyType: _CcAvenueConfig.currencyType,
        amount: amount,
        cancelUrl: _CcAvenueConfig.cancelUrl,
        redirectUrl: _CcAvenueConfig.redirectUrl,
      );
      AppUtils.instance.snackBar(
        'Payment',
        'Payment page opened successfully.',
        false,
      );
    } catch (e) {
      print("error $e");
      AppUtils.instance.snackBar('Payment Failed', e.toString(), true);
    } finally {
      isPaying.value = false;
      update();
    }
  }

  void _validateDirectConfig() {
    if (_CcAvenueConfig.accessCode == 'AVWP73KF86AL59PWLA' ||
        _CcAvenueConfig.merchantId == 'AVAZ83MH39CC06ZACC' ||
        _CcAvenueConfig.cancelUrl.contains('https://foodyore.com/') ||
        _CcAvenueConfig.redirectUrl.contains('https://foodyore.com/')) {
      throw Exception(
        'Set CCAvenue credentials and redirect/cancel URLs in cart_payment_controller.dart first.',
      );
    }
  }
}

class _CcAvenueConfig {
  static const String transUrl =
      'https://secure.ccavenue.com/transaction/initTrans';
  static const String rsaKeyUrl =
      'https://secure.ccavenue.com/transaction/jsp/GetRSA.jsp';

  // Replace these with your real CCAvenue credentials.
  static const String accessCode = 'AVWP73KF86AL59PWLA';
  static const String merchantId = 'AVAZ83MH39CC06ZACC';

  // Replace with your response handler URL hosted on your backend/server.
  static const String cancelUrl = 'https://secure.ccavenue.com/transaction.do?command=initiateTransaction';
  static const String redirectUrl = 'hhttps://secure.ccavenue.com/transaction.do?command=initiateTransaction';

  static const String currencyType = 'INR';
}
