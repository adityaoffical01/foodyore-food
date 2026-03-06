class AppUrl {
  static const String baseSlugUrl = 'https://foodyore.apsinghdev.in/api';
  static const String baseUrl = 'https://foodyore.apsinghdev.in';
  static const String imageUrl = 'https://foodyore.apsinghdev.in';

  static const String initiate_otp = '$baseSlugUrl/auth/initiate-registration';
  static const String verify_otp = '$baseSlugUrl/auth/verify-registration-otp';
  static const String register_user = '$baseSlugUrl/auth/complete-registration';
  static String login_user(String user_id) => '$baseSlugUrl/users/$user_id';
  // for home
  static const String homeGalleryUrls = '$baseSlugUrl/home/gallery';
  static const String getHostDecyUrls =
      '$baseSlugUrl/products/host-descriptions/';
  static const String getAmenitiesyUrls = '$baseSlugUrl/products/amenities?';

  // for products
  static const String categroryUrls = '$baseSlugUrl/products/categories';

  static const String contact_us_URL = '$baseSlugUrl/engagement/contact';

  // for sub categroy
  static String subCategoryUrls(String categoryId, [String cursor = '']) {
    final String base =
        '$baseSlugUrl/products/categories/$categoryId/subcategories?limit=10';
    if (cursor.trim().isEmpty) return base;
    return '$base&cursor=$cursor';
  }

  // for sub sub category
  static String sub_sub_category(String cate_id, sub_cate_id, host_id) =>
      '$baseSlugUrl/products/host-descriptions?subCategoryId=$sub_cate_id&categoryId=$cate_id&hostId=$host_id';

  // for menu Itesms
  static String get_menu_urls(String cate_id, sub_cate_id, host_id, loca_id) =>
      '$baseSlugUrl/products/menu/items?subCategoryId=$sub_cate_id&categoryId=$cate_id&hostId=$host_id&locationId=$loca_id';

  // for cart items
  static const String cart_URL = '$baseSlugUrl/cart';
  static const String put_cart_URL = '$baseSlugUrl/cart/';
  static const String remove_cart_URL = '$baseSlugUrl/cart/';
  static const String clear_cart_URL = '$baseSlugUrl/cart/';
  static const String create_order_URL = '$baseSlugUrl/orders';
  static String get_order_history_URL(String customerId) =>
      '$baseSlugUrl/orders?customerId=$customerId';

  static String get_cart_urls(String userMachine) =>
      '$baseSlugUrl/cart?userMachine=$userMachine';

  static String checkAvailabilityUrl({
    required String locationId,
    required String checkDate,
    required String fromTime,
    required String toTime,
  }) {
    return Uri.parse(
      '$baseSlugUrl/hosts/check-availability',
    ).replace(
      queryParameters: {
        'locationId': locationId,
        'checkDate': checkDate,
        'fromTime': fromTime,
        'toTime': toTime,
      },
    ).toString();
  }
}
