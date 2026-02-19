


import 'dart:io';

import 'package:foodyore/data/network/network_api_services.dart';



class ApiRepository {
  final _apiService  = NetworkApiServices() ;

  Future<dynamic> getData( String  urls) async{
    dynamic response = await _apiService.getApi( 
     urls);
    return  response;
  }
  Future<dynamic> postData( String urls, var data) async{
    dynamic response = await _apiService.postApi( data,
     urls);
    return  response;
  }
   


    Future<dynamic> postWithImage(String urls, File imageFile, var data, String imageTag) async{
    dynamic response = await _apiService.postApiWithImage(imageFile, data,
     urls, imageTag);
    return  response;
  }

  


}