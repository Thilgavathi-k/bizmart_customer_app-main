import 'package:bizmart/app/services/auth_service.dart';
import 'package:bizmart/app/services/global_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/laravel_provider.dart';
class PlanBuy{

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  PlanBuyData(id,pay_method,price,pay_id,payment_status) async {
    final prefs = await _prefs;
    var userId = await prefs.getString('userId');
    var service_id = await prefs.getString('serviceId');
    print("PAYMET STATUS DETAILS");
    print(price);
    print(id);
    print(pay_method);
    print(pay_id);
    print(payment_status);
    print("PAYMET STATUS DETAILS END");
    var PostAdress =
    {
      "customer_id":userId,
      "plan_id":id,
      "payment_type":pay_method,
      "payment_id":pay_id,
      "paid_amount":price,
       "payment_status":payment_status,
    };

    var body = json.encode(PostAdress);
    try
    {
      print('plan buy Save Data  api call');
      print(userId);
      print(body);
      //Uri _uri = getApiBaseUrl("bussiness_address");

      var url = Uri.parse(Get.find<GlobalService>().baseUrl+'/api/plan_buy');
      print(url);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          encoding: Encoding.getByName("utf-8"),
          body: body);
      print(response);
      print(response.statusCode);
      if(response.statusCode == 200 || response.statusCode ==201)
      {
        var data = response.body;
        print(data);
        var resource = json.decode(data);
        print(resource);
        return resource;
      }
      else
      {
        print("Error");
      }

    }
    catch(e)
    {
      print("Error");
    }
  }




}







