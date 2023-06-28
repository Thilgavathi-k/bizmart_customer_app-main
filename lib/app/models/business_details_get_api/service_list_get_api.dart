import 'package:bizmart/app/services/global_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ServiceList{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  ServiceListData(sid) async{
    final prefs = await _prefs;
    var  userId = await prefs.getString('userId');
    var  service_id = await prefs.getString('service_id');
    try
    {
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++SERVICE LIST++++++++++++++++++++++++++++++++++++++++++++++++');
      var url = Uri.parse(Get.find<GlobalService>().baseUrl +'/api/bussiness_services_list?service_id='+sid);
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
        print("+++++++++++++++++++++++new resource+++++++++++++++++++++++++++++++++++++");
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