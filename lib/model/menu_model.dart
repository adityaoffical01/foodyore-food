import 'package:foodyore/model/sub_cate_model.dart';

class MenuResponceModel {
  bool? success;
  List<MenuModel>? menus;
  List<MenuItem>? data;
  Pagination? pagination;

  MenuResponceModel({this.success, this.menus, this.data, this.pagination});

  MenuResponceModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];

    if (json["menus"] != null) {
      menus = (json["menus"] as List)
          .map((e) => MenuModel.fromJson(e))
          .toList();
    }

    if (json["data"] != null) {
      data = (json["data"] as List).map((e) => MenuItem.fromJson(e)).toList();
    }

    if (json["pagination"] != null) {
      pagination = Pagination.fromJson(json["pagination"]);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "menus": menus?.map((e) => e.toJson()).toList(),
      "data": data?.map((e) => e.toJson()).toList(),
      "pagination": pagination?.toJson(),
    };
  }
}

class MenuModel {
  String? menuID;
  String? menu;
  String? menuType;
  String? hostID;
  String? categoryID;
  String? subCategoryID;
  String? createdOn;
  int? createdBy;
  String? modifyOn;
  int? modifyBy;
  int? locationID;
  int? titleID;
  String? menuCategory;

  MenuModel({
    this.menuID,
    this.menu,
    this.menuType,
    this.hostID,
    this.categoryID,
    this.subCategoryID,
    this.createdOn,
    this.createdBy,
    this.modifyOn,
    this.modifyBy,
    this.locationID,
    this.titleID,
    this.menuCategory,
  });

  MenuModel.fromJson(Map<String, dynamic> json) {
    menuID = json["MenuID"];
    menu = json["Menu"]?.toString().trim();
    menuType = json["MenuType"];
    hostID = json["HostID"];
    categoryID = json["CategoryID"];
    subCategoryID = json["SubCategoryID"];
    createdOn = json["CreatedOn"];
    createdBy = json["CreatedBy"];
    modifyOn = json["ModifyOn"];
    modifyBy = json["ModifyBy"];
    locationID = json["LocationID"];
    titleID = json["TitleID"];
    menuCategory = json["MenuCategory"];
  }

  Map<String, dynamic> toJson() {
    return {
      "MenuID": menuID,
      "Menu": menu,
      "MenuType": menuType,
      "HostID": hostID,
      "CategoryID": categoryID,
      "SubCategoryID": subCategoryID,
      "CreatedOn": createdOn,
      "CreatedBy": createdBy,
      "ModifyOn": modifyOn,
      "ModifyBy": modifyBy,
      "LocationID": locationID,
      "TitleID": titleID,
      "MenuCategory": menuCategory,
    };
  }
}

class MenuItem {
  String? itemID;
  String? itemType;
  String? itemDetails;
  int? price;
  String? itemImage;
  String? numberOfGuest;
  String? menuID;
  int? quantity;
  String? vegType;
  String? nonVegType;
  String? maxNumberOfGuest;

  String? menu;
  String? menuType;
  String? menuCategory;

  String? hostID;
  String? categoryID;
  String? subCategoryID;
  int? locationID;
  int? titleID;

  String? menuCreatedOn;
  String? menuModifyOn;

  String? hostName;
  String? categoryName;
  String? subCategoryName;

  MenuItem({
    this.itemID,
    this.itemType,
    this.itemDetails,
    this.price,
    this.itemImage,
    this.numberOfGuest,
    this.menuID,
    this.quantity,
    this.vegType,
    this.nonVegType,
    this.maxNumberOfGuest,
    this.menu,
    this.menuType,
    this.menuCategory,
    this.hostID,
    this.categoryID,
    this.subCategoryID,
    this.locationID,
    this.titleID,
    this.menuCreatedOn,
    this.menuModifyOn,
    this.hostName,
    this.categoryName,
    this.subCategoryName,
  });

  MenuItem.fromJson(Map<String, dynamic> json) {
    itemID = json["ItemID"];
    itemType = json["ItemType"];
    itemDetails = json["ItemDetails"];
    price = json["Price"];
    itemImage = json["ItemImage"];
    numberOfGuest = json["NumberofGuest"];
    menuID = json["MenuID"];
    quantity = json["Quantity"];
    vegType = json["VegType"];
    nonVegType = json["NonVegType"];
    maxNumberOfGuest = json["MaxNumberofGuest"];
    menu = json["Menu"]?.toString().trim();
    menuType = json["MenuType"];
    menuCategory = json["MenuCategory"];
    hostID = json["HostID"];
    categoryID = json["CategoryID"];
    subCategoryID = json["SubCategoryID"];
    locationID = json["LocationID"];
    titleID = json["TitleID"];
    menuCreatedOn = json["MenuCreatedOn"];
    menuModifyOn = json["MenuModifyOn"];
    hostName = json["HostName"];
    categoryName = json["CategoryName"];
    subCategoryName = json["SubCategoryName"];
  }

  Map<String, dynamic> toJson() {
    return {
      "ItemID": itemID,
      "ItemType": itemType,
      "ItemDetails": itemDetails,
      "Price": price,
      "ItemImage": itemImage,
      "NumberofGuest": numberOfGuest,
      "MenuID": menuID,
      "Quantity": quantity,
      "VegType": vegType,
      "NonVegType": nonVegType,
      "MaxNumberofGuest": maxNumberOfGuest,
      "Menu": menu,
      "MenuType": menuType,
      "MenuCategory": menuCategory,
      "HostID": hostID,
      "CategoryID": categoryID,
      "SubCategoryID": subCategoryID,
      "LocationID": locationID,
      "TitleID": titleID,
      "MenuCreatedOn": menuCreatedOn,
      "MenuModifyOn": menuModifyOn,
      "HostName": hostName,
      "CategoryName": categoryName,
      "SubCategoryName": subCategoryName,
    };
  }
}
