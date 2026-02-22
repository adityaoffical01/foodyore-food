
class AmenitiesListModel {
  bool? success;
  List<AmenitiesData>? amenitiesData;
  Pagination? pagination;

  AmenitiesListModel({this.success, this.amenitiesData, this.pagination});

  AmenitiesListModel.fromJson(Map<String, dynamic> json) {
    if(json["success"] is bool) {
      success = json["success"];
    }
    if(json["data"] is List) {
      amenitiesData = json["data"] == null ? null : (json["data"] as List).map((e) => AmenitiesData.fromJson(e)).toList();
    }
    if(json["pagination"] is Map) {
      pagination = json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]);
    }
  }

  static List<AmenitiesListModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(AmenitiesListModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if(amenitiesData != null) {
      _data["data"] = amenitiesData?.map((e) => e.toJson()).toList();
    }
    if(pagination != null) {
      _data["pagination"] = pagination?.toJson();
    }
    return _data;
  }
}

class Pagination {
  int? limit;
  bool? hasMore;
  dynamic nextCursor;
  int? count;

  Pagination({this.limit, this.hasMore, this.nextCursor, this.count});

  Pagination.fromJson(Map<String, dynamic> json) {
    if(json["limit"] is int) {
      limit = json["limit"];
    }
    if(json["hasMore"] is bool) {
      hasMore = json["hasMore"];
    }
    nextCursor = json["nextCursor"];
    if(json["count"] is int) {
      count = json["count"];
    }
  }

  static List<Pagination> fromList(List<Map<String, dynamic>> list) {
    return list.map(Pagination.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["limit"] = limit;
    _data["hasMore"] = hasMore;
    _data["nextCursor"] = nextCursor;
    _data["count"] = count;
    return _data;
  }
}

class AmenitiesData {
  String? amenitieId;
  String? amenitieType;
  int? price;
  String? amenitieImage;
  String? hostId;
  String? hostName;
  String? unit;
  String? locationId;
  String? categoryId;
  String? subCategoryId;
  String? createdOn;
  String? modifyOn;
  String? categoryName;
  String? subCategoryName;

  AmenitiesData({this.amenitieId, this.amenitieType, this.price, this.amenitieImage, this.hostId, this.hostName, this.unit, this.locationId, this.categoryId, this.subCategoryId, this.createdOn, this.modifyOn, this.categoryName, this.subCategoryName});

  AmenitiesData.fromJson(Map<String, dynamic> json) {
    if(json["AmenitieID"] is String) {
      amenitieId = json["AmenitieID"];
    }
    if(json["AmenitieType"] is String) {
      amenitieType = json["AmenitieType"];
    }
    if(json["Price"] is int) {
      price = json["Price"];
    }
    if(json["AmenitieImage"] is String) {
      amenitieImage = json["AmenitieImage"];
    }
    if(json["HostID"] is String) {
      hostId = json["HostID"];
    }
    if(json["HostName"] is String) {
      hostName = json["HostName"];
    }
    if(json["Unit"] is String) {
      unit = json["Unit"];
    }
    if(json["LocationID"] is String) {
      locationId = json["LocationID"];
    }
    if(json["CategoryID"] is String) {
      categoryId = json["CategoryID"];
    }
    if(json["SubCategoryID"] is String) {
      subCategoryId = json["SubCategoryID"];
    }
    if(json["CreatedOn"] is String) {
      createdOn = json["CreatedOn"];
    }
    if(json["ModifyOn"] is String) {
      modifyOn = json["ModifyOn"];
    }
    if(json["CategoryName"] is String) {
      categoryName = json["CategoryName"];
    }
    if(json["SubCategoryName"] is String) {
      subCategoryName = json["SubCategoryName"];
    }
  }

  static List<AmenitiesData> fromList(List<Map<String, dynamic>> list) {
    return list.map(AmenitiesData.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["AmenitieID"] = amenitieId;
    _data["AmenitieType"] = amenitieType;
    _data["Price"] = price;
    _data["AmenitieImage"] = amenitieImage;
    _data["HostID"] = hostId;
    _data["HostName"] = hostName;
    _data["Unit"] = unit;
    _data["LocationID"] = locationId;
    _data["CategoryID"] = categoryId;
    _data["SubCategoryID"] = subCategoryId;
    _data["CreatedOn"] = createdOn;
    _data["ModifyOn"] = modifyOn;
    _data["CategoryName"] = categoryName;
    _data["SubCategoryName"] = subCategoryName;
    return _data;
  }
}