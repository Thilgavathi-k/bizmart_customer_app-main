import 'package:bizmart/app/models/const_bse_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class GstDetailsGetlist{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  GstDetailsGetDatas() async{
    final prefs = await _prefs;
    var  userId = await prefs.getString('userId');
    var  service_id = await prefs.getString('service_id');

    // var postData = {
    //   "user_id":userId
    //   // "uid": userId,
    //   //"cityid": cityId,
    // };

    //var body = json.encode(postData);
    try
    {
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Address api call++++++++++++++++++++++++++++++++++++++++++++++++');
       print("RECENT");
      var url = Uri.parse('http://localhost/FORMS/new.php');
      var response = await http.get(url);
      print(url);
     // print(body);
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