
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../services/global_service.dart';

var userId;
var cityId;
var CouponId;
class CategoriesData{
  CategoryData() async{
    var getCityData={};
    var url = Uri.parse('${Get.find<GlobalService>().baseUrl}categories?parent=true&orderBy=order&sortBy=asc');
    final response = await http.get(url);
    print('----------------------------------Get Category data Data----------------------------------');
    print(response);
    print(url);
    print(response.statusCode);
    if( response.statusCode == 200 || response.statusCode == 201)
    {
      getCityData = json.decode(response.body);
      print(getCityData);
    }
    else
    {
      print('get city data error');
    }

    return getCityData;


  }
}