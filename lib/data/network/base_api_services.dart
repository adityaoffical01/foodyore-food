import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> getApi(String url);

  Future<dynamic> postApi(dynamic data, String url);
  Future<dynamic> postApiJson(dynamic data, String url);
  Future<dynamic> deleteApi(String url);

  Future<dynamic> postApiWithImage(
    File imageFile,
    dynamic data,
    String url,
    imageTag,
  );
  Future<dynamic> postApiWithImageFIle(
    File imageFile,
    file,
    dynamic data,
    String url,
    imageTag,
    fileTag,
  );
  Future<dynamic> postApiWithMultipleFileTypes(
    List<File> images,
    List<File> videos,
    Map<String, dynamic> data,
    String url,
    String imageTag,
    String videoTag,
  );
}
