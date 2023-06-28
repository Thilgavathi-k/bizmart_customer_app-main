
import 'package:bizmart/app/models/const_bse_url.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BusinessService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  BusinessServiceData(_service_discount,_service_desc,_service_name,_service_cat,_service_price,_service_unit,_service_duration,_service_img) async {
    print('Business services on press');
    print("_selectedServices");
    print(mainUrl + "/api/bussiness_services");

    final prefs = await _prefs;
    var service_id = await prefs.getString('serviceId');

    var userId = await prefs.getString('userId');
    String images = _service_img !=null ?_service_img.path.split('/').last:'';

    var body = {
      "service_name":_service_name,
      "service_price":_service_price,
      "service_discount_price":_service_discount,
      "price_unit":_service_unit,
      "duration":_service_duration,
      "description":_service_desc,
      "provi":userId,
      "cat_name":_service_cat,
      "user_id": userId,
      "image": _service_img != null ?await MultipartFile.fromFile(_service_img.path, filename: images):"",
    };
    print(body);


    var dio = Dio();

    dio.options.contentType = 'application/json';
    FormData formData;
    formData = FormData.fromMap({
      "service_name":_service_name,
      "service_price":_service_price,
      "service_discount_price":_service_discount,
      "price_unit":_service_unit,
      "duration":_service_duration,
      "description":_service_desc,
      "provi":userId,
      "cat_name":_service_cat,
      "user_id": userId,
      "image": _service_img != null ?await MultipartFile.fromFile(_service_img.path, filename: images):"",

    });
    try {
      final prefs = await _prefs;

      print("_selectedServices");
      print(mainUrl + "/api/bussiness_services");
      print(_service_img);
      print(_service_name);
      print(_service_price);
      print(_service_discount);
      print(_service_unit);
      print(_service_duration);
      print(_service_cat);
      print(service_id);

      Response response = await dio.post(mainUrl + "/api/bussiness_services",
        data: formData,
        options: Options(
          method: 'POST',
          followRedirects: false,
          validateStatus: (status) => true,
          // or ResponseType.JSON
        ),
      ).whenComplete(() {
        debugPrint("complete:");
      }).catchError((onError) {
        debugPrint("error:${onError.toString()}");
      });
      print("response dataaaaa");

      print(response);
      await prefs.setString('serviceId', response.data['data']['id'].toString());
      var serviceId = await prefs.getString('serviceId');
      print(serviceId);
      return response.statusCode;
    } catch (e) {
      print('Error: $e');
    }

  }

}

