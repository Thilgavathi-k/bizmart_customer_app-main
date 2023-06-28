import 'package:bizmart/app/services/global_service.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class KycDetailsGet{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  KycDetailsGetData(sid) async{
    final prefs = await _prefs;
    var  userId = await prefs.getString('userId');
    var  service_id = await prefs.getString('service_id');

    var postData = {
      "user_id":userId
      // "uid": userId,
      //"cityid": cityId,
    };

    var body = json.encode(postData);
    try
    {
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++contract_kyc_list api call++++++++++++++++++++++++++++++++++++++++++++++++');
      var url = Uri.parse(Get.find<GlobalService>().baseUrl + '/api/contract_kyc_list?user_id='+userId+'&service_id='+sid);
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