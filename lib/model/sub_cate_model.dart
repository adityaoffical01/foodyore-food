class SubCategoryResponseModel {
  final bool? success;
  final List<SubCategoryItem>? data;
  final Pagination? pagination;

  SubCategoryResponseModel({this.success, this.data, this.pagination});

  factory SubCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryResponseModel(
      success: json["success"] is bool ? json["success"] : json["success"] == 1,
      data: (json["data"] as List?)
          ?.whereType<Map<String, dynamic>>()
          .map((e) => SubCategoryItem.fromJson(e))
          .toList(),
      pagination: json["pagination"] != null
          ? Pagination.fromJson(json["pagination"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "data": data?.map((e) => e.toJson()).toList(),
      "pagination": pagination?.toJson(),
    };
  }
}

class SubCategoryItem {
  final String? subCategoryID;
  final String? categoryID;
  final String? subCategoryName;
  final String? status;
  final String? hostID;
  final String? hostName;
  final String? updatedOn;
  final String? locationID;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? country;
  final String? pinCode;
  final double? latitude;
  final double? longitude;
  final String? farmLandTitile;
  final String? farmLandCatId;

  SubCategoryItem({
    this.subCategoryID,
    this.categoryID,
    this.subCategoryName,
    this.status,
    this.hostID,
    this.hostName,
    this.updatedOn,
    this.locationID,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.latitude,
    this.longitude,
    this.farmLandTitile,
    this.farmLandCatId,
  });

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) {
    return SubCategoryItem(
      subCategoryID: json["SubCategoryID"]?.toString(),
      categoryID: json["CategoryID"]?.toString(),
      subCategoryName: json["SubCategoryName"]?.toString(),
      status: json["Status"]?.toString(),
      hostID: json["HostID"]?.toString(),
      hostName: json["HostName"]?.toString(),
      updatedOn: json["updated_on"]?.toString(),
      locationID: json["LocationID"]?.toString(),
      address1: json["Address1"]?.toString(),
      address2: json["Address2"]?.toString(),
      city: json["City"]?.toString(),
      state: json["State"]?.toString(),
      country: json["Country"]?.toString(),
      pinCode: json["PinCode"]?.toString(),
      latitude: json["Latitude"] != null
          ? double.tryParse(json["Latitude"].toString())
          : null,
      longitude: json["Longitude"] != null
          ? double.tryParse(json["Longitude"].toString())
          : null,
      farmLandTitile: json['TitleName'] ?? '',
      farmLandCatId: json['TitleID']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "SubCategoryID": subCategoryID,
      "CategoryID": categoryID,
      "SubCategoryName": subCategoryName,
      "Status": status,
      "HostID": hostID,
      "HostName": hostName,
      "updated_on": updatedOn,
      "LocationID": locationID,
      "Address1": address1,
      "Address2": address2,
      "City": city,
      "State": state,
      "Country": country,
      "PinCode": pinCode,
      "Latitude": latitude,
      "Longitude": longitude,
      'TitleName': farmLandTitile,
      'TitleID': farmLandCatId,
    };
  }
}

class Pagination {
  final int? limit;
  final bool? hasMore;
  final String? nextCursor;
  final int? count;

  Pagination({this.limit, this.hasMore, this.nextCursor, this.count});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      limit: json["limit"] is int
          ? json["limit"]
          : int.tryParse(json["limit"]?.toString() ?? ""),
      hasMore: json["hasMore"] is bool ? json["hasMore"] : json["hasMore"] == 1,
      nextCursor: json["nextCursor"]?.toString(),
      count: json["count"] is int
          ? json["count"]
          : int.tryParse(json["count"]?.toString() ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "limit": limit,
      "hasMore": hasMore,
      "nextCursor": nextCursor,
      "count": count,
    };
  }
}
