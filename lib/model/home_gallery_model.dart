class HomeGalleryModel {
  bool? success;
  String? code;
  String? message;
  List<GalleryDataList>? galleryDataList;
  int? total;

  HomeGalleryModel({
    this.success,
    this.code,
    this.message,
    this.galleryDataList,
    this.total,
  });

  HomeGalleryModel.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      galleryDataList = json["data"] == null
          ? null
          : (json["data"] as List)
                .map((e) => GalleryDataList.fromJson(e))
                .toList();
    }
    if (json["total"] is int) {
      total = json["total"];
    }
  }

  static List<HomeGalleryModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(HomeGalleryModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    _data["code"] = code;
    _data["message"] = message;
    if (galleryDataList != null) {
      _data["data"] = galleryDataList?.map((e) => e.toJson()).toList();
    }
    _data["total"] = total;
    return _data;
  }
}

class GalleryDataList {
  String? tableId;
  String? title;
  String? fileName;
  String? filePath;
  String? uploadedDate;
  dynamic uploadedBy;
  String? pageUrl;

  GalleryDataList({
    this.tableId,
    this.title,
    this.fileName,
    this.filePath,
    this.uploadedDate,
    this.uploadedBy,
    this.pageUrl,
  });

  GalleryDataList.fromJson(Map<String, dynamic> json) {
    if (json["TableId"] is String) {
      tableId = json["TableId"];
    }
    if (json["Title"] is String) {
      title = json["Title"];
    }
    if (json["fileName"] is String) {
      fileName = json["fileName"];
    }
    if (json["FilePath"] is String) {
      filePath = json["FilePath"];
    }
    if (json["UploadedDate"] is String) {
      uploadedDate = json["UploadedDate"];
    }
    uploadedBy = json["UploadedBy"];
    if (json["PageUrl"] is String) {
      pageUrl = json["PageUrl"];
    }
  }

  static List<GalleryDataList> fromList(List<Map<String, dynamic>> list) {
    return list.map(GalleryDataList.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["TableId"] = tableId;
    _data["Title"] = title;
    _data["fileName"] = fileName;
    _data["FilePath"] = filePath;
    _data["UploadedDate"] = uploadedDate;
    _data["UploadedBy"] = uploadedBy;
    _data["PageUrl"] = pageUrl;
    return _data;
  }
}