class OrderListResponseModel {
  final bool? success;
  final int? count;
  final List<OrderItemModel>? data;

  const OrderListResponseModel({
    this.success,
    this.count,
    this.data,
  });

  factory OrderListResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderListResponseModel(
      success: json['success'] as bool?,
      count: _toInt(json['count']),
      data: json['data'] is List
          ? List<OrderItemModel>.from(
              (json['data'] as List).map(
                (item) => OrderItemModel.fromJson(item as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'count': count,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderItemModel {
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
  final OrderItemPreviewModel? itemPreview;
  final String? locationId;
  final OrderLocationModel? location;
  final String? locationSummary;

  const OrderItemModel({
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
    this.itemPreview,
    this.locationId,
    this.location,
    this.locationSummary,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
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
          ? OrderHostInfoModel.fromJson(json['hostInfo'] as Map<String, dynamic>)
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
      itemPreview: json['itemPreview'] is Map<String, dynamic>
          ? OrderItemPreviewModel.fromJson(
              json['itemPreview'] as Map<String, dynamic>,
            )
          : null,
      locationId: json['LocationID']?.toString(),
      location: json['Location'] is Map<String, dynamic>
          ? OrderLocationModel.fromJson(json['Location'] as Map<String, dynamic>)
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
      'itemPreview': itemPreview?.toJson(),
      'LocationID': locationId,
      'Location': location?.toJson(),
      'LocationSummary': locationSummary,
    };
  }
}

class OrderCustomerInfoModel {
  final int? customerId;
  final String? customerName;
  final String? mobile;
  final String? emailId;
  final String? customerType;

  const OrderCustomerInfoModel({
    this.customerId,
    this.customerName,
    this.mobile,
    this.emailId,
    this.customerType,
  });

  factory OrderCustomerInfoModel.fromJson(Map<String, dynamic> json) {
    return OrderCustomerInfoModel(
      customerId: _toInt(json['CustomerID']),
      customerName: json['CustomerName']?.toString(),
      mobile: json['Mobile']?.toString(),
      emailId: json['EmailID']?.toString(),
      customerType: json['CustomerType']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CustomerID': customerId,
      'CustomerName': customerName,
      'Mobile': mobile,
      'EmailID': emailId,
      'CustomerType': customerType,
    };
  }
}

class OrderHostInfoModel {
  final String? hostId;
  final String? hostName;
  final String? hostEmail;
  final String? hostMobile;

  const OrderHostInfoModel({
    this.hostId,
    this.hostName,
    this.hostEmail,
    this.hostMobile,
  });

  factory OrderHostInfoModel.fromJson(Map<String, dynamic> json) {
    return OrderHostInfoModel(
      hostId: json['HostID']?.toString(),
      hostName: json['HostName']?.toString(),
      hostEmail: json['HostEmail']?.toString(),
      hostMobile: json['HostMobile']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'HostID': hostId,
      'HostName': hostName,
      'HostEmail': hostEmail,
      'HostMobile': hostMobile,
    };
  }
}

class OrderPaymentInfoModel {
  final String? paymentType;
  final String? paymentStatus;
  final String? promoCode;

  const OrderPaymentInfoModel({
    this.paymentType,
    this.paymentStatus,
    this.promoCode,
  });

  factory OrderPaymentInfoModel.fromJson(Map<String, dynamic> json) {
    return OrderPaymentInfoModel(
      paymentType: json['PaymentType']?.toString(),
      paymentStatus: json['PaymentStatus']?.toString(),
      promoCode: json['PromoCode']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PaymentType': paymentType,
      'PaymentStatus': paymentStatus,
      'PromoCode': promoCode,
    };
  }
}

class OrderPriceBreakupModel {
  final double? subTotal;
  final double? cgstSgstTax;
  final double? serviceTax;
  final double? discountAmount;
  final double? netAmount;
  final double? totalAmount;

  const OrderPriceBreakupModel({
    this.subTotal,
    this.cgstSgstTax,
    this.serviceTax,
    this.discountAmount,
    this.netAmount,
    this.totalAmount,
  });

  factory OrderPriceBreakupModel.fromJson(Map<String, dynamic> json) {
    return OrderPriceBreakupModel(
      subTotal: _toDouble(json['SubTotal']),
      cgstSgstTax: _toDouble(json['CGST_SGST_Tax']),
      serviceTax: _toDouble(json['ServiceTax']),
      discountAmount: _toDouble(json['DiscountAmount']),
      netAmount: _toDouble(json['NetAmount']),
      totalAmount: _toDouble(json['TotalAmount']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SubTotal': subTotal,
      'CGST_SGST_Tax': cgstSgstTax,
      'ServiceTax': serviceTax,
      'DiscountAmount': discountAmount,
      'NetAmount': netAmount,
      'TotalAmount': totalAmount,
    };
  }
}

class OrderItemPreviewModel {
  final String? itemName;
  final String? itemImage;
  final String? itemType;

  const OrderItemPreviewModel({
    this.itemName,
    this.itemImage,
    this.itemType,
  });

  factory OrderItemPreviewModel.fromJson(Map<String, dynamic> json) {
    return OrderItemPreviewModel(
      itemName: json['ItemName']?.toString(),
      itemImage: json['ItemImage']?.toString(),
      itemType: json['ItemType']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ItemName': itemName,
      'ItemImage': itemImage,
      'ItemType': itemType,
    };
  }
}

class OrderLocationModel {
  final String? address1;
  final String? address2;
  final String? cityName;
  final String? stateName;
  final String? countryName;
  final String? pinCode;

  const OrderLocationModel({
    this.address1,
    this.address2,
    this.cityName,
    this.stateName,
    this.countryName,
    this.pinCode,
  });

  factory OrderLocationModel.fromJson(Map<String, dynamic> json) {
    return OrderLocationModel(
      address1: json['Address1']?.toString(),
      address2: json['Address2']?.toString(),
      cityName: json['CityName']?.toString(),
      stateName: json['StateName']?.toString(),
      countryName: json['CountryName']?.toString(),
      pinCode: json['PinCode']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Address1': address1,
      'Address2': address2,
      'CityName': cityName,
      'StateName': stateName,
      'CountryName': countryName,
      'PinCode': pinCode,
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
