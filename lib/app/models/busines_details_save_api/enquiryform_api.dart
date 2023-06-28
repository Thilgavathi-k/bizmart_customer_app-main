import 'package:bizmart/app/services/auth_service.dart';
import 'package:bizmart/app/services/global_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/laravel_provider.dart';
class EnquiryFormData{
  final globalService = Get.find<GlobalService>();
  final authService = Get.find<AuthService>();
  String baseUrl;

  Rx<String> _progress = Rx(null);

  String getBaseUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    if (!baseUrl.endsWith('/')) {
      return baseUrl + '/' + path;
    }
    return baseUrl + path;
  }

  String getApiBaseUrl(String path) {
    String _apiPath = globalService.global.value.apiPath;
    if (path.startsWith('/')) {
      return getBaseUrl(_apiPath) + path.substring(1);
    }
    return getBaseUrl(_apiPath) + path;
  }
  Uri getBaseUri(String path) {
    return Uri.parse(getBaseUrl(path));
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  EnquiryFormSave(sid,name,email,phone,description) async {
    final prefs = await _prefs;
    var userId = await prefs.getString('userId');
    var service_id = await prefs.getString('serviceId');
    var PostData =
    {

      "user_id":userId,
      "service_id":sid,
      "name":name,
      "email":email,
      "phone":phone,
      "description":description

    };

    var body = json.encode(PostData);
    try
    {
      print('Enquiryform Save Data  api call');
      print(userId);
      print(sid);
      print(body);
      //Uri _uri = getApiBaseUrl("bussiness_address");

      var url = Uri.parse(Get.find<GlobalService>().baseUrl+'/api/enquiry_form');
      print(url);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          encoding: Encoding.getByName("utf-8"),
          body: body);
      print(response);
      print(response.statusCode);
      if(response.statusCode == 200 || response.statusCode ==201)
      {
        var data = response.body;
        print(data);
        var resource = json.decode(data);
        print(resource);
        return resource;
      }
      else
      {
        print("Error");
      }

    }
    catch(e)
    {
      print("Error");
    }
  }




}







