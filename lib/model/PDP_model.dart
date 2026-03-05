class PdpCommonModel {
  /// Basic Info
  final String? title;
  final String? description;

  /// Category
  final String? categoryName;
  final String? subCategoryName;

  /// Host
  final String? hostName;
  final String? mobile;
  final String? email;

  /// Location
  final String? locationId;  
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? pinCode;

  /// Map
  final String? latitude;
  final String? longitude;

  /// Images
  final List<String> images;

  const PdpCommonModel({
    this.title,
    this.description,
    this.categoryName,
    this.subCategoryName,
    this.hostName,
    this.mobile,
    this.email,
    this.locationId, 
    this.address,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.latitude,
    this.longitude,
    this.images = const [],
  });

  PdpCommonModel copyWith({
    String? title,
    String? description,
    String? categoryName,
    String? subCategoryName,
    String? hostName,
    String? mobile,
    String? email,
     String? locationId, 
    String? address,
    String? city,
    String? state,
    String? country,
    String? pinCode,
    String? latitude,
    String? longitude,
    
    List<String>? images,
  }) {
    return PdpCommonModel(
      title: title ?? this.title,
      description: description ?? this.description,
      categoryName: categoryName ?? this.categoryName,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      hostName: hostName ?? this.hostName,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
       locationId: locationId ?? this.locationId,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      pinCode: pinCode ?? this.pinCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      images: images ?? this.images,
    );
  }
}
