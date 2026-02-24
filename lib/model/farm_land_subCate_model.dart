import 'package:foodyore/model/sub_cate_model.dart';

class FarmLandSubCategoryResponse {
  final bool success;
  final List<TitleData> data;
  final Pagination pagination;

  FarmLandSubCategoryResponse({
    required this.success,
    required this.data,
    required this.pagination,
  });

  factory FarmLandSubCategoryResponse.fromJson(Map<String, dynamic> json) {
    return FarmLandSubCategoryResponse(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? List<TitleData>.from(json['data'].map((x) => TitleData.fromJson(x)))
          : [],
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((x) => x.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class TitleData {
  final String titleID;
  final String categoryID;
  final String subCategoryID;
  final String hostID;
  final String titleName;
  final String status;
  final DateTime? createdOn;
  final int? createdBy;
  final DateTime? modifyOn;
  final int? modifyBy;
  final String categoryName;
  final String subCategoryName;
  final String hostName;

  TitleData({
    required this.titleID,
    required this.categoryID,
    required this.subCategoryID,
    required this.hostID,
    required this.titleName,
    required this.status,
    this.createdOn,
    this.createdBy,
    this.modifyOn,
    this.modifyBy,
    required this.categoryName,
    required this.subCategoryName,
    required this.hostName,
  });

  factory TitleData.fromJson(Map<String, dynamic> json) {
    return TitleData(
      titleID: json['TitleID'] ?? '',
      categoryID: json['CategoryID'] ?? '',
      subCategoryID: json['SubCategoryID'] ?? '',
      hostID: json['HostID'] ?? '',
      titleName: json['TitleName'] ?? '',
      status: json['Status'] ?? '',
      createdOn: json['CreatedOn'] != null
          ? DateTime.tryParse(json['CreatedOn'])
          : null,
      createdBy: json['CreatedBy'],
      modifyOn: json['ModifyOn'] != null
          ? DateTime.tryParse(json['ModifyOn'])
          : null,
      modifyBy: json['ModifyBy'],
      categoryName: json['CategoryName'] ?? '',
      subCategoryName: json['SubCategoryName'] ?? '',
      hostName: json['HostName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TitleID': titleID,
      'CategoryID': categoryID,
      'SubCategoryID': subCategoryID,
      'HostID': hostID,
      'TitleName': titleName,
      'Status': status,
      'CreatedOn': createdOn?.toIso8601String(),
      'CreatedBy': createdBy,
      'ModifyOn': modifyOn?.toIso8601String(),
      'ModifyBy': modifyBy,
      'CategoryName': categoryName,
      'SubCategoryName': subCategoryName,
      'HostName': hostName,
    };
  }
}
