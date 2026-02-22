
class HostDescripetionsModel {
  bool? success;
  Data? data;

  HostDescripetionsModel({this.success, this.data});

  HostDescripetionsModel.fromJson(Map<String, dynamic> json) {
    if(json["success"] is bool) {
      success = json["success"];
    }
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  static List<HostDescripetionsModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(HostDescripetionsModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  HostDescription? hostDescription;
  Location? location;

  Data({this.hostDescription, this.location});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["hostDescription"] is Map) {
      hostDescription = json["hostDescription"] == null ? null : HostDescription.fromJson(json["hostDescription"]);
    }
    if(json["location"] is Map) {
      location = json["location"] == null ? null : Location.fromJson(json["location"]);
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(hostDescription != null) {
      _data["hostDescription"] = hostDescription?.toJson();
    }
    if(location != null) {
      _data["location"] = location?.toJson();
    }
    return _data;
  }
}

class Location {
  String? locationId;
  String? hostId;
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  int? titleId;
  String? address1;
  String? address2;
  String? cityName;
  String? stateName;
  String? countryName;
  String? pinCode;
  String? latitude;
  String? longitude;
  String? createdBy;
  String? createdOn;
  String? modifyBy;
  String? modifyOn;

  Location({this.locationId, this.hostId, this.categoryId, this.categoryName, this.subCategoryId, this.subCategoryName, this.titleId, this.address1, this.address2, this.cityName, this.stateName, this.countryName, this.pinCode, this.latitude, this.longitude, this.createdBy, this.createdOn, this.modifyBy, this.modifyOn});

  Location.fromJson(Map<String, dynamic> json) {
    if(json["LocationID"] is String) {
      locationId = json["LocationID"];
    }
    if(json["HostID"] is String) {
      hostId = json["HostID"];
    }
    if(json["CategoryID"] is String) {
      categoryId = json["CategoryID"];
    }
    if(json["CategoryName"] is String) {
      categoryName = json["CategoryName"];
    }
    if(json["SubCategoryID"] is String) {
      subCategoryId = json["SubCategoryID"];
    }
    if(json["SubCategoryName"] is String) {
      subCategoryName = json["SubCategoryName"];
    }
    if(json["TitleID"] is int) {
      titleId = json["TitleID"];
    }
    if(json["Address1"] is String) {
      address1 = json["Address1"];
    }
    if(json["Address2"] is String) {
      address2 = json["Address2"];
    }
    if(json["CityName"] is String) {
      cityName = json["CityName"];
    }
    if(json["StateName"] is String) {
      stateName = json["StateName"];
    }
    if(json["CountryName"] is String) {
      countryName = json["CountryName"];
    }
    if(json["PinCode"] is String) {
      pinCode = json["PinCode"];
    }
    if(json["Latitude"] is String) {
      latitude = json["Latitude"];
    }
    if(json["Longitude"] is String) {
      longitude = json["Longitude"];
    }
    if(json["CreatedBy"] is String) {
      createdBy = json["CreatedBy"];
    }
    if(json["CreatedOn"] is String) {
      createdOn = json["CreatedOn"];
    }
    if(json["ModifyBy"] is String) {
      modifyBy = json["ModifyBy"];
    }
    if(json["ModifyOn"] is String) {
      modifyOn = json["ModifyOn"];
    }
  }

  static List<Location> fromList(List<Map<String, dynamic>> list) {
    return list.map(Location.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["LocationID"] = locationId;
    _data["HostID"] = hostId;
    _data["CategoryID"] = categoryId;
    _data["CategoryName"] = categoryName;
    _data["SubCategoryID"] = subCategoryId;
    _data["SubCategoryName"] = subCategoryName;
    _data["TitleID"] = titleId;
    _data["Address1"] = address1;
    _data["Address2"] = address2;
    _data["CityName"] = cityName;
    _data["StateName"] = stateName;
    _data["CountryName"] = countryName;
    _data["PinCode"] = pinCode;
    _data["Latitude"] = latitude;
    _data["Longitude"] = longitude;
    _data["CreatedBy"] = createdBy;
    _data["CreatedOn"] = createdOn;
    _data["ModifyBy"] = modifyBy;
    _data["ModifyOn"] = modifyOn;
    return _data;
  }
}

class HostDescription {
  String? descriptionId;
  String? categoryId;
  String? subCategoryId;
  String? hostId;
  String? descriptionTitle;
  String? description;
  String? fileUpload1;
  String? fileUpload2;
  String? fileUpload3;
  String? fileUpload4;
  int? locationId;
  int? titleId;
  String? createdBy;
  String? createdOn;
  String? modifyBy;
  String? modifyOn;
  String? categoryName;
  String? categoryStatus;
  bool? isCategoryLocationWise;
  String? subCategoryName;
  String? subCategoryStatus;
  String? hostName;
  String? hostEmail;
  String? hostMobile;
  String? hostAddress;

  HostDescription({this.descriptionId, this.categoryId, this.subCategoryId, this.hostId, this.descriptionTitle, this.description, this.fileUpload1, this.fileUpload2, this.fileUpload3, this.fileUpload4, this.locationId, this.titleId, this.createdBy, this.createdOn, this.modifyBy, this.modifyOn, this.categoryName, this.categoryStatus, this.isCategoryLocationWise, this.subCategoryName, this.subCategoryStatus, this.hostName, this.hostEmail, this.hostMobile, this.hostAddress});

  HostDescription.fromJson(Map<String, dynamic> json) {
    if(json["DescriptionID"] is String) {
      descriptionId = json["DescriptionID"];
    }
    if(json["CategoryID"] is String) {
      categoryId = json["CategoryID"];
    }
    if(json["SubCategoryID"] is String) {
      subCategoryId = json["SubCategoryID"];
    }
    if(json["HostID"] is String) {
      hostId = json["HostID"];
    }
    if(json["DescriptionTitle"] is String) {
      descriptionTitle = json["DescriptionTitle"];
    }
    if(json["Description"] is String) {
      description = json["Description"];
    }
    if(json["FileUpload1"] is String) {
      fileUpload1 = json["FileUpload1"];
    }
    if(json["FileUpload2"] is String) {
      fileUpload2 = json["FileUpload2"];
    }
    if(json["FileUpload3"] is String) {
      fileUpload3 = json["FileUpload3"];
    }
    if(json["FileUpload4"] is String) {
      fileUpload4 = json["FileUpload4"];
    }
    if(json["LocationID"] is int) {
      locationId = json["LocationID"];
    }
    if(json["TitleID"] is int) {
      titleId = json["TitleID"];
    }
    if(json["CreatedBy"] is String) {
      createdBy = json["CreatedBy"];
    }
    if(json["CreatedOn"] is String) {
      createdOn = json["CreatedOn"];
    }
    if(json["ModifyBy"] is String) {
      modifyBy = json["ModifyBy"];
    }
    if(json["ModifyOn"] is String) {
      modifyOn = json["ModifyOn"];
    }
    if(json["CategoryName"] is String) {
      categoryName = json["CategoryName"];
    }
    if(json["CategoryStatus"] is String) {
      categoryStatus = json["CategoryStatus"];
    }
    if(json["IsCategoryLocationWise"] is bool) {
      isCategoryLocationWise = json["IsCategoryLocationWise"];
    }
    if(json["SubCategoryName"] is String) {
      subCategoryName = json["SubCategoryName"];
    }
    if(json["SubCategoryStatus"] is String) {
      subCategoryStatus = json["SubCategoryStatus"];
    }
    if(json["HostName"] is String) {
      hostName = json["HostName"];
    }
    if(json["HostEmail"] is String) {
      hostEmail = json["HostEmail"];
    }
    if(json["HostMobile"] is String) {
      hostMobile = json["HostMobile"];
    }
    if(json["HostAddress"] is String) {
      hostAddress = json["HostAddress"];
    }
  }

  static List<HostDescription> fromList(List<Map<String, dynamic>> list) {
    return list.map(HostDescription.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["DescriptionID"] = descriptionId;
    _data["CategoryID"] = categoryId;
    _data["SubCategoryID"] = subCategoryId;
    _data["HostID"] = hostId;
    _data["DescriptionTitle"] = descriptionTitle;
    _data["Description"] = description;
    _data["FileUpload1"] = fileUpload1;
    _data["FileUpload2"] = fileUpload2;
    _data["FileUpload3"] = fileUpload3;
    _data["FileUpload4"] = fileUpload4;
    _data["LocationID"] = locationId;
    _data["TitleID"] = titleId;
    _data["CreatedBy"] = createdBy;
    _data["CreatedOn"] = createdOn;
    _data["ModifyBy"] = modifyBy;
    _data["ModifyOn"] = modifyOn;
    _data["CategoryName"] = categoryName;
    _data["CategoryStatus"] = categoryStatus;
    _data["IsCategoryLocationWise"] = isCategoryLocationWise;
    _data["SubCategoryName"] = subCategoryName;
    _data["SubCategoryStatus"] = subCategoryStatus;
    _data["HostName"] = hostName;
    _data["HostEmail"] = hostEmail;
    _data["HostMobile"] = hostMobile;
    _data["HostAddress"] = hostAddress;
    return _data;
  }
}