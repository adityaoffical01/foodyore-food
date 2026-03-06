class SearchResponseModel {
  final bool? success;
  final String? message;
  final List<SearchCityItemModel>? data;
  final int? totalResults;

  const SearchResponseModel({
    this.success,
    this.message,
    this.data,
    this.totalResults,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchResponseModel(
      success: json['success'] as bool?,
      message: json['message']?.toString(),
      data: json['data'] is List
          ? List<SearchCityItemModel>.from(
              (json['data'] as List).map(
                (item) =>
                    SearchCityItemModel.fromJson(item as Map<String, dynamic>),
              ),
            )
          : null,
      totalResults: _toInt(json['totalResults']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
      'totalResults': totalResults,
    };
  }
}

class SearchCityItemModel {
  final String? cityId;
  final String? cityName;
  final String? stateId;
  final String? stateName;
  final String? countryId;
  final String? countryName;
  final int? totalLocations;
  final int? totalSubcategories;

  const SearchCityItemModel({
    this.cityId,
    this.cityName,
    this.stateId,
    this.stateName,
    this.countryId,
    this.countryName,
    this.totalLocations,
    this.totalSubcategories,
  });

  factory SearchCityItemModel.fromJson(Map<String, dynamic> json) {
    return SearchCityItemModel(
      cityId: json['CityID']?.toString(),
      cityName: json['CityName']?.toString(),
      stateId: json['StateID']?.toString(),
      stateName: json['StateName']?.toString(),
      countryId: json['CountryId']?.toString(),
      countryName: json['CountryName']?.toString(),
      totalLocations: _toInt(json['TotalLocations']),
      totalSubcategories: _toInt(json['TotalSubcategories']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CityID': cityId,
      'CityName': cityName,
      'StateID': stateId,
      'StateName': stateName,
      'CountryId': countryId,
      'CountryName': countryName,
      'TotalLocations': totalLocations,
      'TotalSubcategories': totalSubcategories,
    };
  }
}

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}
