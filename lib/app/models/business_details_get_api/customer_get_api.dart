import 'package:bizmart/app/services/global_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CustomerPlan{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  CustomerPlanDetails() async{
    final prefs = await _prefs;
    var  service_id = await prefs.getString('service_id');
    var  userId = await prefs.getString('userId');

    var postData = {};

    var body = json.encode(postData);
    try
    {
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Business api call++++++++++++++++++++++++++++++++++++++++++++++++');
      var url = Uri.parse(Get.find<GlobalService>().baseUrl + '/api/customer_plans?user_id='+userId);
      var response = await http.get(url);
      print(url);
      print(body);
      print(response);
      print(response.statusCode);
      if(response.statusCode == 200 || response.statusCode == 201)
      {
        var data = response.body;
        print(data);
        var resource = json.decode(data);
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