import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../services/global_service.dart';


class AllCategories{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  AllCategoriesData() async{
    final prefs = await _prefs;
    var  service_id = await prefs.getString('service_id');
    try
    {
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++All categories api call++++++++++++++++++++++++++++++++++++++++++++++++');
      var url = Uri.parse("${Get.find<GlobalService>().baseUrl }/api/categories");
      var response = await http.get(url);
      print(url);
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