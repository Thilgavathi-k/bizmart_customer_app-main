import 'package:bizmart/app/services/global_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PaymentList{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  PaymentListData() async{
    final prefs = await _prefs;
    var  userId = await prefs.getString('userId');
    var  service_id = await prefs.getString('service_id');
    try
    {
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Payment LIST++++++++++++++++++++++++++++++++++++++++++++++++');
      var url = Uri.parse(Get.find<GlobalService>().baseUrl +'/api/payment_methods');
      var response = await http.get(url);
      print(url);
      print("User id ");
      print(userId);
      print(response);
      print(response.statusCode);
      if(response.statusCode == 200 || response.statusCode == 201)
      {
        var data = response.body;
        print(data);
        var resource = json.decode(data);
        print("+++++++++++++++++++++++Payment resource+++++++++++++++++++++++++++++++++++++");
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