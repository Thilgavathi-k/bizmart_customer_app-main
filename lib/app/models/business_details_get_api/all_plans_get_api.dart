import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../services/global_service.dart';


class AllPlans{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AllPlansData() async{
    final prefs = await _prefs;
    // var  userId = await prefs.getString('userId');
    // var  service_id = await prefs.getString('service_id');
    try
    {
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++All Plans LIST++++++++++++++++++++++++++++++++++++++++++++++++');
      var url = Uri.parse(Get.find<GlobalService>().baseUrl +'/api/all_plans');
      var response = await http.get(url);
      print(url);

      print(response);
      print(response.statusCode);
      if(response.statusCode == 200 || response.statusCode == 201)
      {
        var data = response.body;
        print(data);
        var resource = json.decode(data);
        print("+++++++++++++++++++++++All Plans Data+++++++++++++++++++++++++++++++++++++");
        print(resource);
        return resource;
      }
      else
      {
        print("ERROR");

      }
    }
    catch(e)
    {
      print('error');
    }


  }
}