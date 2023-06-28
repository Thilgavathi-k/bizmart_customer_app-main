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
class SocialMediaDataEdit{

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SocialMediaLinkEdit(sid,_facebook,_instagram,_twitter,_youtube,_linkedin,_yahoo) async {
    final prefs = await _prefs;
    var userId = await prefs.getString('userId');
    var service_id = await prefs.getString('serviceId');


    var PostAdress =
    {
      "user_id":userId,
      "service_id":sid,
      "facebook_link":_facebook,
      "instagram_link":_instagram,
      "twitter_link":_twitter,
      "youtube_link":_youtube,
      "linkedin_link":_linkedin,
      "yahoo":_yahoo

    };

    var body = json.encode(PostAdress);
    try
    {
      print('Social media Save Data  api call');
      print(userId);
      print(service_id);
      print(body);
      //Uri _uri = getApiBaseUrl("bussiness_address");

      var url = Uri.parse(Get.find<GlobalService>().baseUrl+'/api/social_media_links');
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







