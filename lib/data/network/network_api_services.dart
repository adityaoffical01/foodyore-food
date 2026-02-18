// ignore_for_file: avoid_renaming_method_parameters


import 'dart:convert';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:foodyore/data/app_exceptions.dart';
import 'package:foodyore/data/network/base_api_services.dart';
import 'package:foodyore/services/auth.dart';
import 'package:http/http.dart' as http;


class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
      print(setHeaders());
    }
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url), headers: setHeaders()).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print("====responseJson==$responseJson=======");
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
       print(setHeaders());
    }

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url),headers: setHeaders(), body: data)
          .timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print("responseJson===$responseJson");
    }
    return responseJson;
  }


 @override
  Future<dynamic> postApiJson(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
       print(setHeaders2());
    }

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url),headers: setHeaders2(), body: data)
          .timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print("responseJson===$responseJson");
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApiWithImage(File ?image, var data, String url, imageTag) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });
 if(image !=null){
 final imageFile = await http.MultipartFile.fromPath(imageTag, image.path);
      request.files.add(imageFile);
 }
     

      request.headers.addAll(setHeaders());

      final response = await request.send().timeout(const Duration(seconds: 60));
      responseJson =
          await returnResponse(await http.Response.fromStream(response));
    } 
    
    on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print("responseJson$responseJson");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
            'Error accoured while communicating with server ${response.statusCode}');
    }
  }



@override
Future<dynamic> deleteApi(String url) async {
  if (kDebugMode) {
    print("DELETE => $url");
    print("Headers => ${setHeaders()}");
  }

  dynamic responseJson;
  try {
    final response = await http
        .delete(Uri.parse(url), headers: setHeaders())
        .timeout(const Duration(seconds: 60));
    responseJson = returnResponse(response);
  } on SocketException {
    throw InternetException('');
  } on RequestTimeOut {
    throw RequestTimeOut('');
  }
  if (kDebugMode) {
    print("DELETE Response => $responseJson");
  }
  return responseJson;
}



   @override
  Future<dynamic> postApiWithImageFIle(File image,file, var data, String url, imageTag, fileTage) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      final imageFile1 = await http.MultipartFile.fromPath(imageTag, image.path);
      final imageFile2 = await http.MultipartFile.fromPath(fileTage, file.path);
      request.files.add(imageFile1);
      request.files.add(imageFile2);
      request.headers.addAll(setHeaders());

      final response = await request.send().timeout(const Duration(seconds: 60));
      responseJson =
          await returnResponse(await http.Response.fromStream(response));
    } 
   
    on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print("responseJson$responseJson");
    }
    return responseJson;
  }




@override
Future<dynamic> postApiWithMultipleFileTypes(
  List<File> images,
  List<File> videos,
  Map<String, dynamic> data,
  String url,
  String imageTag,
  String videoTag,
) async {
  dynamic responseJson;
  try {
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // 🔹 Print and add all form fields
    print("🔽 Adding Form Fields:");
    data.forEach((key, value) {
      print("  🔹 $key : $value");
      request.fields[key] = value.toString();
    });

    // 🔹 Print and attach image files
    print("🔽 Adding Images:");
    for (File image in images) {
      print("  🖼️ ${image.path}");
      final multipartImage = await http.MultipartFile.fromPath(imageTag, image.path);
      request.files.add(multipartImage);
    }

    // 🔹 Print and attach video files
    print("🔽 Adding Videos:");
    for (File video in videos) {
      print("  🎥 ${video.path}");
      final multipartVideo = await http.MultipartFile.fromPath(videoTag, video.path);
      request.files.add(multipartVideo);
    }

    request.headers.addAll(setHeaders());

    print("🔹 Sending request to: $url");
    final response = await request.send().timeout(const Duration(seconds: 60));
    responseJson = await returnResponse(await http.Response.fromStream(response));
  } on SocketException {
    throw InternetException('');
  } on RequestTimeOut {
    throw RequestTimeOut('');
  }

  print("✅ Response Received: $responseJson");
  return responseJson;
}

  
}
