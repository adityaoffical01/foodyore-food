import 'package:foodyore/model/order_model.dart';

class OrderDetailsResponseModel {
  final bool? success;
  final OrderDetailsDataModel? data;

  const OrderDetailsResponseModel({
    this.success,
    this.data,
  });

  factory OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponseModel(
      success: json['success'] as bool?,
      data: json['data'] is Map<String, dynamic>
          ? OrderDetailsDataModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class OrderDetailsDataModel {
  final String? orderId;
  final String? orderNumber;
  final String? orderStatus;
  final String? paymentStatus;
  final String? orderDate;
  final String? createdDate;
  final String? orderStartDate;
  final String? orderEndDate;
  final String? visitTime;
  final OrderCustomerInfoModel? customerInfo;
  final OrderHostInfoModel? hostInfo;
  final OrderPaymentInfoModel? paymentInfo;
  final OrderPriceBreakupModel? priceBreakup;
  final OrderDetailsItemSummaryModel? itemSummary;
  final List<OrderDetailsItemModel>? items;
  final String? locationId;
  final OrderLocationModel? location;
  final String? locationSummary;

  const OrderDetailsDataModel({
    this.orderId,
    this.orderNumber,
    this.orderStatus,
    this.paymentStatus,
    this.orderDate,
    this.createdDate,
    this.orderStartDate,
    this.orderEndDate,
    this.visitTime,
    this.customerInfo,
    this.hostInfo,
    this.paymentInfo,
    this.priceBreakup,
    this.itemSummary,
    this.items,
    this.locationId,
    this.location,
    this.locationSummary,
  });

  factory OrderDetailsDataModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsDataModel(
      orderId: json['OrderID']?.toString(),
      orderNumber: json['OrderNumber']?.toString(),
      orderStatus: json['OrderStatus']?.toString(),
      paymentStatus: json['PaymentStatus']?.toString(),
      orderDate: json['OrderDate']?.toString(),
      createdDate: json['CreatedDate']?.toString(),
      orderStartDate: json['OrderStartDate']?.toString(),
      orderEndDate: json['OrderEndDate']?.toString(),
      visitTime: json['VisitTime']?.toString(),
      customerInfo: json['customerInfo'] is Map<String, dynamic>
          ? OrderCustomerInfoModel.fromJson(
              json['customerInfo'] as Map<String, dynamic>,
            )
          : null,
      hostInfo: json['hostInfo'] is Map<String, dynamic>
          ? OrderHostInfoModel.fromJson(
              json['hostInfo'] as Map<String, dynamic>,
            )
          : null,
      paymentInfo: json['paymentInfo'] is Map<String, dynamic>
          ? OrderPaymentInfoModel.fromJson(
              json['paymentInfo'] as Map<String, dynamic>,
            )
          : null,
      priceBreakup: json['priceBreakup'] is Map<String, dynamic>
          ? OrderPriceBreakupModel.fromJson(
              json['priceBreakup'] as Map<String, dynamic>,
            )
          : null,
      itemSummary: json['itemSummary'] is Map<String, dynamic>
          ? OrderDetailsItemSummaryModel.fromJson(
              json['itemSummary'] as Map<String, dynamic>,
            )
          : null,
      items: json['items'] is List
          ? List<OrderDetailsItemModel>.from(
              (json['items'] as List).map(
                (item) =>
                    OrderDetailsItemModel.fromJson(item as Map<String, dynamic>),
              ),
            )
          : null,
      locationId: json['LocationID']?.toString(),
      location: json['Location'] is Map<String, dynamic>
          ? OrderLocationModel.fromJson(
              json['Location'] as Map<String, dynamic>,
            )
          : null,
      locationSummary: json['LocationSummary']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'OrderID': orderId,
      'OrderNumber': orderNumber,
      'OrderStatus': orderStatus,
      'PaymentStatus': paymentStatus,
      'OrderDate': orderDate,
      'CreatedDate': createdDate,
      'OrderStartDate': orderStartDate,
      'OrderEndDate': orderEndDate,
      'VisitTime': visitTime,
      'customerInfo': customerInfo?.toJson(),
      'hostInfo': hostInfo?.toJson(),
      'paymentInfo': paymentInfo?.toJson(),
      'priceBreakup': priceBreakup?.toJson(),
      'itemSummary': itemSummary?.toJson(),
      'items': items?.map((e) => e.toJson()).toList(),
      'LocationID': locationId,
      'Location': location?.toJson(),
      'LocationSummary': locationSummary,
    };
  }
}








class OrderDetailsItemSummaryModel {
  final int? totalItems;
  final int? totalQuantity;

  const OrderDetailsItemSummaryModel({
    this.totalItems,
    this.totalQuantity,
  });

  factory OrderDetailsItemSummaryModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsItemSummaryModel(
      totalItems: _toInt(json['TotalItems']),
      totalQuantity: _toInt(json['TotalQuantity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TotalItems': totalItems,
      'TotalQuantity': totalQuantity,
    };
  }
}

class OrderDetailsItemModel {
  final int? itemId;
  final String? itemName;
  final String? itemImage;
  final String? itemType;
  final String? numberOfGuest;
  final int? quantity;
  final double? unitPrice;
  final OrderDetailsItemPriceBreakupModel? priceBreakup;
  final String? status;

  const OrderDetailsItemModel({
    this.itemId,
    this.itemName,
    this.itemImage,
    this.itemType,
    this.numberOfGuest,
    this.quantity,
    this.unitPrice,
    this.priceBreakup,
    this.status,
  });

  factory OrderDetailsItemModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsItemModel(
      itemId: _toInt(json['ItemID']),
      itemName: json['ItemName']?.toString(),
      itemImage: json['ItemImage']?.toString(),
      itemType: json['ItemType']?.toString(),
      numberOfGuest: json['NumberOfGuest']?.toString(),
      quantity: _toInt(json['Quantity']),
      unitPrice: _toDouble(json['UnitPrice']),
      priceBreakup: json['PriceBreakup'] is Map<String, dynamic>
          ? OrderDetailsItemPriceBreakupModel.fromJson(
              json['PriceBreakup'] as Map<String, dynamic>,
            )
          : null,
      status: json['Status']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ItemID': itemId,
      'ItemName': itemName,
      'ItemImage': itemImage,
      'ItemType': itemType,
      'NumberOfGuest': numberOfGuest,
      'Quantity': quantity,
      'UnitPrice': unitPrice,
      'PriceBreakup': priceBreakup?.toJson(),
      'Status': status,
    };
  }
}

class OrderDetailsItemPriceBreakupModel {
  final double? taxableAmount;
  final double? cgstAmount;
  final double? sgstAmount;
  final double? serviceTaxAmount;
  final double? netAmount;
  final double? discountAmount;
  final double? payableAmount;

  const OrderDetailsItemPriceBreakupModel({
    this.taxableAmount,
    this.cgstAmount,
    this.sgstAmount,
    this.serviceTaxAmount,
    this.netAmount,
    this.discountAmount,
    this.payableAmount,
  });

  factory OrderDetailsItemPriceBreakupModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return OrderDetailsItemPriceBreakupModel(
      taxableAmount: _toDouble(json['TaxableAmount']),
      cgstAmount: _toDouble(json['CGSTAmount']),
      sgstAmount: _toDouble(json['SGSTAmount']),
      serviceTaxAmount: _toDouble(json['ServiceTaxAmount']),
      netAmount: _toDouble(json['NetAmount']),
      discountAmount: _toDouble(json['DiscountAmount']),
      payableAmount: _toDouble(json['PayableAmount']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TaxableAmount': taxableAmount,
      'CGSTAmount': cgstAmount,
      'SGSTAmount': sgstAmount,
      'ServiceTaxAmount': serviceTaxAmount,
      'NetAmount': netAmount,
      'DiscountAmount': discountAmount,
      'PayableAmount': payableAmount,
    };
  }
}

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}
