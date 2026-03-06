import 'package:foodyore/model/sub_cate_model.dart';

class SubCategorySearchResponseModel {
  final bool? success;
  final String? message;
  final List<SubCategoryItem>? data;
  final SubCategorySearchSummaryModel? summary;

  const SubCategorySearchResponseModel({
    this.success,
    this.message,
    this.data,
    this.summary,
  });

  factory SubCategorySearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SubCategorySearchResponseModel(
      success: json['success'] as bool?,
      message: json['message']?.toString(),
      data: json['data'] is List
          ? List<SubCategoryItem>.from(
              (json['data'] as List).map(
                (item) =>
                    SubCategoryItem.fromJson(item as Map<String, dynamic>),
              ),
            )
          : null,
      summary: json['summary'] is Map<String, dynamic>
          ? SubCategorySearchSummaryModel.fromJson(
              json['summary'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
      'summary': summary?.toJson(),
    };
  }
}

class SubCategorySearchSummaryModel {
  final int? totalResults;
  final int? totalSubcategories;
  final SubCategorySearchCityModel? city;
  final List<SubCategorySummaryItemModel>? subcategories;

  const SubCategorySearchSummaryModel({
    this.totalResults,
    this.totalSubcategories,
    this.city,
    this.subcategories,
  });

  factory SubCategorySearchSummaryModel.fromJson(Map<String, dynamic> json) {
    return SubCategorySearchSummaryModel(
      totalResults: _toInt(json['totalResults']),
      totalSubcategories: _toInt(json['totalSubcategories']),
      city: json['city'] is Map<String, dynamic>
          ? SubCategorySearchCityModel.fromJson(
              json['city'] as Map<String, dynamic>,
            )
          : null,
      subcategories: json['subcategories'] is List
          ? List<SubCategorySummaryItemModel>.from(
              (json['subcategories'] as List).map(
                (item) => SubCategorySummaryItemModel.fromJson(
                  item as Map<String, dynamic>,
                ),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalResults': totalResults,
      'totalSubcategories': totalSubcategories,
      'city': city?.toJson(),
      'subcategories': subcategories?.map((e) => e.toJson()).toList(),
    };
  }
}

class SubCategorySearchCityModel {
  final String? cityId;
  final String? cityName;
  final String? stateName;
  final String? countryName;

  const SubCategorySearchCityModel({
    this.cityId,
    this.cityName,
    this.stateName,
    this.countryName,
  });

  factory SubCategorySearchCityModel.fromJson(Map<String, dynamic> json) {
    return SubCategorySearchCityModel(
      cityId: json['CityID']?.toString(),
      cityName: json['CityName']?.toString(),
      stateName: json['StateName']?.toString(),
      countryName: json['CountryName']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CityID': cityId,
      'CityName': cityName,
      'StateName': stateName,
      'CountryName': countryName,
    };
  }
}

class SubCategorySummaryItemModel {
  final String? subCategoryId;
  final String? subCategoryName;
  final String? categoryId;
  final String? categoryName;
  final int? totalLocations;

  const SubCategorySummaryItemModel({
    this.subCategoryId,
    this.subCategoryName,
    this.categoryId,
    this.categoryName,
    this.totalLocations,
  });

  factory SubCategorySummaryItemModel.fromJson(Map<String, dynamic> json) {
    return SubCategorySummaryItemModel(
      subCategoryId: json['SubCategoryID']?.toString(),
      subCategoryName: json['SubCategoryName']?.toString(),
      categoryId: json['CategoryID']?.toString(),
      categoryName: json['CategoryName']?.toString(),
      totalLocations: _toInt(json['TotalLocations']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SubCategoryID': subCategoryId,
      'SubCategoryName': subCategoryName,
      'CategoryID': categoryId,
      'CategoryName': categoryName,
      'TotalLocations': totalLocations,
    };
  }
}

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}
