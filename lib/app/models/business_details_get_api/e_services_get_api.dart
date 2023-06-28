import 'package:bizmart/app/services/global_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EservicesData{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  EservicesDataLst(id) async{
    final prefs = await _prefs;
    var  service_id = await prefs.getString('service_id');
    var  userId = await prefs.getString('userId');

    var postData = {};

    var body = json.encode(postData);
    try
    {
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++e_services api call++++++++++++++++++++++++++++++++++++++++++++++++');
     // var url = Uri.parse(Get.find<GlobalService>().baseUrl + 'e_services/'+id+"?with=eProvider%3BeProvider.taxes%3Bcategories&api_token=5h6Aw5wchs1d0FxsU2Al9HGWlNDZpBfOzGyFPzFLHv9MDzi3YZjopvJpraNJ");
      var url = Uri.parse(Get.find<GlobalService>().baseUrl + '/api/e_services/'+id);
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