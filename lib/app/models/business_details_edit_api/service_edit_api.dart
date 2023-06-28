
import 'package:bizmart/app/models/const_bse_url.dart';
import 'package:bizmart/app/services/global_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessServiceEdit{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  BusinessServiceDataEdit(sid,_service_discount,_service_desc,_service_name,_service_cat,_service_price,_service_unit,_service_duration,_service_img) async {
    print('Business services on press');
    final prefs = await _prefs;
    var userId = await prefs.getString('userId');
    //   String services = _selectedServices.join(', ');
    //  print(services);

    var dio = Dio();
    String images = _service_img !=null ?_service_img.path.split('/').last:'';
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
      // await MultipartFile.fromFile(_image.path, filename: images),
      "image": _service_img != null ?await MultipartFile.fromFile(_service_img.path, filename: images):"",

    });
    // if (_certificate != null) {
    //   formData = FormData.fromMap({
    //     "name": _name,
    //     "email": _email,
    //     "password": _password,
    //     "phone_number": _phone,
    //     "alternate_phone_number": _altr_name,
    //     "aadhar_card":
    //     await MultipartFile.fromFile(_aadhar.path, filename: aadhar),
    //     "aadhar_card_back": await MultipartFile.fromFile(_aadharBack.path,
    //         filename: aadharBack),
    //     "pan_card": await MultipartFile.fromFile(_pancard.path, filename: pan),
    //     "image": await MultipartFile.fromFile(_profile.path, filename: profile),
    //     "certificate": await MultipartFile.fromFile(_certificate.path,
    //         filename: _certificate.path.split('/').last),
    //     "profession": _profession,
    //     "experience": _experience,
    //     "location": placeAddress,
    //     "services": services
    //   });
    // } else {
    //   formData = FormData.fromMap({
    //     "name": _name,
    //     "email": _email,
    //     "password": _password,
    //     "phone_number": _phone,
    //     "alternate_phone_number": _altr_name,
    //     "aadhar_card":
    //     await MultipartFile.fromFile(_aadhar.path, filename: aadhar),
    //     "aadhar_card_back": await MultipartFile.fromFile(_aadharBack.path,
    //         filename: aadharBack),
    //     "pan_card": await MultipartFile.fromFile(_pancard.path, filename: pan),
    //     "image": await MultipartFile.fromFile(_profile.path, filename: profile),
    //     "profession": _profession,
    //     "experience": _experience,
    //     "location": placeAddress,
    //     "services": services
    //   });
    // }

    try {
      final prefs = await _prefs;

      print("_selectedServices");
      print(_service_img);
      print(_service_name);
      print(_service_price);
      print(_service_discount);
      print(_service_unit);
      print(_service_duration);
      print(_service_cat);
      print(userId);

      Response response = await dio.post(mainUrl + "/api/bussiness_services/${sid}",
        data: formData,
        options: Options(
          method: 'POST',
          followRedirects: false,
          validateStatus: (status) => true,
          // or ResponseType.JSON
        ),
      )
          .whenComplete(() {
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

