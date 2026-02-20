class CategoryResponseModel {
  final bool? success;
  final String? code;
  final String? message;
  final List<CategoryItem>? data;
  final int? total;

  CategoryResponseModel({
    this.success,
    this.code,
    this.message,
    this.data,
    this.total,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryResponseModel(
      success: json["success"] as bool?,
      code: json["code"] as String?,
      message: json["message"] as String?,
      total: json["total"] as int?,
      data: (json["data"] as List?)
          ?.whereType<Map<String, dynamic>>()
          .map((e) => CategoryItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "code": code,
      "message": message,
      "total": total,
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryItem {
  final String? categoryID;
  final String? categoryName;
  final String? status;
  final bool? isCategoryLocationWise;
  final String? hostID;
  final String? updatedBy;
  final String? updatedOn;

  CategoryItem({
    this.categoryID,
    this.categoryName,
    this.status,
    this.isCategoryLocationWise,
    this.hostID,
    this.updatedBy,
    this.updatedOn,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      categoryID: json["CategoryID"] as String?,
      categoryName: json["CategoryName"] as String?,
      status: json["Status"] as String?,
      isCategoryLocationWise: json["IsCategoryLocationWise"] as bool?,
      hostID: json["HostID"]?.toString(),
      updatedBy: json["updatedby"]?.toString(),
      updatedOn: json["updated_on"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "CategoryID": categoryID,
      "CategoryName": categoryName,
      "Status": status,
      "IsCategoryLocationWise": isCategoryLocationWise,
      "HostID": hostID,
      "updatedby": updatedBy,
      "updated_on": updatedOn,
    };
  }
}