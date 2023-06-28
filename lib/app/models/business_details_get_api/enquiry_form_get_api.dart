import 'package:bizmart/app/services/global_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../modules/enquiry_form.dart';


class EnquiryFormGet{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  EnquiryFormGetData(sid) async{
    final prefs = await _prefs;
    var  userId = await prefs.getString('userId');
    var  service_id = await prefs.getString('service_id');
    try
    {
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Enquiry Form LIST++++++++++++++++++++++++++++++++++++++++++++++++');
      var url = Uri.parse(Get.find<GlobalService>().baseUrl +'/api/enquiry_form_list/${sid}/${userId}');
      var response = await http.get(url);
      print(url);
      print(response);
      print(response.statusCode);
      if(response.statusCode == 200 || response.statusCode == 201)
      {
        var data = response.body;
        print(data);
        var resource = json.decode(data);
        print("+++++++++++++++++++++++Enquiry Form LIST+++++++++++++++++++++++++++++++++++++");
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