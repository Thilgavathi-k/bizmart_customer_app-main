
import 'package:bizmart/app/services/global_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BusinessDetaols {
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  BusinessDetaolsData(_establishment,_payment,awards,_website,_image,_video,certificate) async {
    print('Business deatils on press');
    print(_video);
    print(_image);
    print(certificate);
    final prefs = await _prefs;
    var userId = await prefs.getString('userId');
    var service_id = await prefs.getString('serviceId');

 //   String services = _selectedServices.join(', ');
  //  print(services);

    var dio = Dio();
    String images =_image==null?"": _image.path.split('/').last;
    String video = _video==null ?"":_video.path.split('/').last;
    String certificates = certificate == null ?"":certificate.path.split('/').last;
    dio.options.contentType = 'application/json';
    FormData formData;
    formData = FormData.fromMap({
      "user_id": userId,
      "service_id":service_id,
      "add_your_establishment": _establishment,
      "payment_method": _payment,
      "add_awards": awards,
      "bussiness_website": _website,
      "image": _image == null?"":await MultipartFile.fromFile(_image.path, filename: images),
      "video":  _video == null ?"":await MultipartFile.fromFile(_video.path, filename: video),
      "pdf": certificate == null?"":await MultipartFile.fromFile(certificate.path, filename: certificates),

    });
    try {
      print("_selectedServices");
      print(_image);
      print(_video);
      print(certificates);
      print(awards);
      print(_website);
      print(userId);
      Response response = await dio.post(Get.find<GlobalService>().baseUrl + "/api/bussiness_details",
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
      print(response.statusCode);

      return response.statusCode;
    } catch (e) {
      print('Error: $e');
    }

  }

}

