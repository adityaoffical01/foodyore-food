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

  // for products
  static const String categroryUrls = '$baseSlugUrl/products/categories';
  // for sub categroy
  static String subCategoryUrls(String categoryId, [String cursor = '']) {
    final String base =
        '$baseSlugUrl/products/categories/$categoryId/subcategories?limit=10';
    if (cursor.trim().isEmpty) return base;
    return '$base&cursor=$cursor';
  }

  // for sub sub category
  static String sub_sub_category(String cate_id, sub_cate_id, host_id) =>
      '$baseSlugUrl/products/farm-land-titles?subCategoryId=$sub_cate_id&categoryId=$cate_id&hostId=$host_id';
}
