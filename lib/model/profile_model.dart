class UserProfileResponseModel {
  final bool? success;
  final UserData? data;

  UserProfileResponseModel({
    this.success,
    this.data,
  });

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return UserProfileResponseModel(
      success: json["success"] is bool
          ? json["success"]
          : json["success"] == 1,
      data: json["data"] != null
          ? UserData.fromJson(json["data"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "data": data?.toJson(),
    };
  }
}

class UserData {
  final String? tableId;
  final String? fullName;
  final String? password;
  final String? emailAddress;
  final String? gender;
  final String? alterNateNumber;
  final String? alterNateName;
  final String? createdDate;
  final String? mobileNumber;
  final String? occupation;
  final String? martialStats;
  final String? dateOfBirth;
  final bool? isActive;
  final int? country;
  final int? state;
  final int? city;
  final String? address;

  UserData({
    this.tableId,
    this.fullName,
    this.password,
    this.emailAddress,
    this.gender,
    this.alterNateNumber,
    this.alterNateName,
    this.createdDate,
    this.mobileNumber,
    this.occupation,
    this.martialStats,
    this.dateOfBirth,
    this.isActive,
    this.country,
    this.state,
    this.city,
    this.address,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      tableId: json["TableId"]?.toString(),
      fullName: json["FullName"]?.toString(),
      password: json["Password"]?.toString(),
      emailAddress: json["EmailAddress"]?.toString(),
      gender: json["Gender"]?.toString(),
      alterNateNumber: json["AlterNateNumber"]?.toString(),
      alterNateName: json["AlterNateName"]?.toString(),
      createdDate: json["CreatedDate"]?.toString(),
      mobileNumber: json["MobileNumber"]?.toString(),
      occupation: json["Occupation"]?.toString(),
      martialStats: json["MartialStats"]?.toString(),
      dateOfBirth: json["DateOfBirth"]?.toString(),
      isActive: json["IsActive"] is bool
          ? json["IsActive"]
          : json["IsActive"] == 1,
      address: json["Address"]?.toString(),
      country: json["country"] is int
          ? json["country"]
          : int.tryParse(json["country"]?.toString() ?? ""),
      state: json["State"] is int
          ? json["State"]
          : int.tryParse(json["State"]?.toString() ?? ""),
      city: json["City"] is int
          ? json["City"]
          : int.tryParse(json["City"]?.toString() ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TableId": tableId,
      "FullName": fullName,
      "Password": password,
      "EmailAddress": emailAddress,
      "Gender": gender,
      "AlterNateNumber": alterNateNumber,
      "AlterNateName": alterNateName,
      "CreatedDate": createdDate,
      "MobileNumber": mobileNumber,
      "Occupation": occupation,
      "MartialStats": martialStats,
      "DateOfBirth": dateOfBirth,
      "IsActive": isActive,
      "Address": address,
      "country": country,
      "State": state,
      "City": city,
    };
  }
}