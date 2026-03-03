import 'package:foodyore/model/host_descripetions_model.dart';
import 'package:foodyore/model/sub_cate_model.dart';

class FarmLandSubCategoryResponse {
  final bool success;
  final List<HostDescription> data;
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
          ? List<HostDescription>.from(
              json['data'].map((x) => HostDescription.fromJson(x)),
            )
          : [],
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "data": data.map((x) => x.toJson()).toList(),
      "pagination": pagination.toJson(),
    };
  }
}
