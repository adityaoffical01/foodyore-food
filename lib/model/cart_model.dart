class CartResponseModel {
  final bool? success;
  final CartSummary? summary;
  final PriceBreakup? priceBreakup;
  final String? discountMessage;
  final dynamic promoInfo;
  final List<CartItem>? data;

  CartResponseModel({
    this.success,
    this.summary,
    this.priceBreakup,
    this.discountMessage,
    this.promoInfo,
    this.data,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      success: json['success'],
      summary: json['summary'] != null
          ? CartSummary.fromJson(json['summary'])
          : null,
      priceBreakup: json['priceBreakup'] != null
          ? PriceBreakup.fromJson(json['priceBreakup'])
          : null,
      discountMessage: json['discountMessage'],
      promoInfo: json['promoInfo'],
      data: json['data'] != null
          ? List<CartItem>.from(json['data'].map((x) => CartItem.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "summary": summary?.toJson(),
      "priceBreakup": priceBreakup?.toJson(),
      "discountMessage": discountMessage,
      "promoInfo": promoInfo,
      "data": data?.map((x) => x.toJson()).toList(),
    };
  }
}

class CartSummary {
  final int? totalItems;
  final int? totalQuantity;
  final int? subtotal;

  CartSummary({this.totalItems, this.totalQuantity, this.subtotal});

  factory CartSummary.fromJson(Map<String, dynamic> json) {
    return CartSummary(
      totalItems: json['totalItems'],
      totalQuantity: json['totalQuantity'],
      subtotal: json['subtotal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "totalItems": totalItems,
      "totalQuantity": totalQuantity,
      "subtotal": subtotal,
    };
  }
}

class PriceBreakup {
  final int? itemTotal;
  final int? taxPercent;
  final int? taxAmount;
  final int? discountPercent;
  final int? discountAmount;
  final int? totalAmount;

  PriceBreakup({
    this.itemTotal,
    this.taxPercent,
    this.taxAmount,
    this.discountPercent,
    this.discountAmount,
    this.totalAmount,
  });

  factory PriceBreakup.fromJson(Map<String, dynamic> json) {
    return PriceBreakup(
      itemTotal: json['itemTotal'],
      taxPercent: json['taxPercent'],
      taxAmount: json['taxAmount'],
      discountPercent: json['discountPercent'],
      discountAmount: json['discountAmount'],
      totalAmount: json['totalAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "itemTotal": itemTotal,
      "taxPercent": taxPercent,
      "taxAmount": taxAmount,
      "discountPercent": discountPercent,
      "discountAmount": discountAmount,
      "totalAmount": totalAmount,
    };
  }
}

class CartItem {
  final String? cartId;
  final String? itemType;
  final int? quantity;
  final String? cartDateAdded;
  final String? purchasedFlag;
  final String? itemId;
  final String? hostId;
  final String? locationId;
  final String? categoryId;
  final String? subCategoryId;
  final int? price;
  final int? netAmount;
  final String? itemDetails;
  final String? categoryName;
  final String? subCategoryName;
  final String? hostName;
  final String? address1;
  final String? address2;
  final String? pinCode;
  final String? cityName;
  final String? stateName;
  final String? countryName;
  final String? itemName;
  final String? itemImage;
  final String? menuId;
  final String? menuType;
  final String? menuCategory;
  final int? lineTotal;

  CartItem({
    this.cartId,
    this.itemType,
    this.quantity,
    this.cartDateAdded,
    this.purchasedFlag,
    this.itemId,
    this.hostId,
    this.locationId,
    this.categoryId,
    this.subCategoryId,
    this.price,
    this.netAmount,
    this.itemDetails,
    this.categoryName,
    this.subCategoryName,
    this.hostName,
    this.address1,
    this.address2,
    this.pinCode,
    this.cityName,
    this.stateName,
    this.countryName,
    this.itemName,
    this.itemImage,
    this.menuId,
    this.menuType,
    this.menuCategory,
    this.lineTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartId: json['Cart_ID'],
      itemType: json['ItemType'],
      quantity: json['Quantity'],
      cartDateAdded: json['CartDate_Added'],
      purchasedFlag: json['Purchased_Flag'],
      itemId: json['ItemID'],
      hostId: json['HostID'],
      locationId: json['LocationID'],
      categoryId: json['CategoryID'],
      subCategoryId: json['SubCategoryID'],
      price: json['Price'],
      netAmount: json['NetAmount'],
      itemDetails: json['ItemDetails'],
      categoryName: json['CategoryName'],
      subCategoryName: json['SubCategoryName'],
      hostName: json['HostName'],
      address1: json['Address1'],
      address2: json['Address2'],
      pinCode: json['PinCode'],
      cityName: json['CityName'],
      stateName: json['StateName'],
      countryName: json['CountryName'],
      itemName: json['ItemName'],
      itemImage: json['ItemImage'],
      menuId: json['MenuID'],
      menuType: json['MenuType'],
      menuCategory: json['MenuCategory'],
      lineTotal: json['LineTotal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Cart_ID": cartId,
      "ItemType": itemType,
      "Quantity": quantity,
      "CartDate_Added": cartDateAdded,
      "Purchased_Flag": purchasedFlag,
      "ItemID": itemId,
      "HostID": hostId,
      "LocationID": locationId,
      "CategoryID": categoryId,
      "SubCategoryID": subCategoryId,
      "Price": price,
      "NetAmount": netAmount,
      "ItemDetails": itemDetails,
      "CategoryName": categoryName,
      "SubCategoryName": subCategoryName,
      "HostName": hostName,
      "Address1": address1,
      "Address2": address2,
      "PinCode": pinCode,
      "CityName": cityName,
      "StateName": stateName,
      "CountryName": countryName,
      "ItemName": itemName,
      "ItemImage": itemImage,
      "MenuID": menuId,
      "MenuType": menuType,
      "MenuCategory": menuCategory,
      "LineTotal": lineTotal,
    };
  }
}
