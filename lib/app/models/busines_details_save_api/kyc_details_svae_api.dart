
import 'package:bizmart/app/services/global_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';
class KycDetails {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  KycDetailsDadta(Pan, driving, passport_file, liquir, trade, llp, company,documnet,Fssai) async {
    print('Business deatils on press');
    final prefs = await _prefs;
    var userId = await prefs.getString('userId');
    var service_id = await prefs.getString('serviceId');

    //   String services = _selectedServices.join(', ');
    //  print(services);

    var dio = Dio();
    String pan =Pan !=null? Pan.path.split('/').last:"";
    String drive =driving !=null? driving.path.split('/').last:'';
    String liq = liquir !=null ?liquir.path.split('/').last:"";
    String trades = trade !=null ?trade.path.split('/').last:"";
    String companies = company !=null ?company.path.split('/').last:"";
    String documents = documnet!=null ?documnet .path.split('/').last:"";
    String llp_number = llp !=null?llp.path.split('/').last:"";
    String fassaii = Fssai!=null?Fssai.path.split('/').last:"";
    String passport =passport_file!=null? passport_file.path.split('/').last:"";
    dio.options.contentType = 'application/json';
    FormData formData;
    formData = FormData.fromMap({
      "user_id":userId,
      "service_id":service_id,
      "pan": Pan !=null ?await MultipartFile.fromFile(Pan.path, filename: pan):"",
      "driving_license": driving !=null? await MultipartFile.fromFile(driving.path, filename: drive):"",
      "passport_number": passport_file!=null?await MultipartFile.fromFile(passport_file.path, filename: passport):"",
      "business_llp": llp !=null?await MultipartFile.fromFile(llp.path, filename: llp_number):"",
      "company_license": company !=null ?await MultipartFile.fromFile(company.path, filename: companies):"",

      // await MultipartFile.fromFile(_image.path, filename: images),
      "fssai_license": Fssai!=null?await MultipartFile.fromFile(Fssai.path, filename:fassaii):"",
      "liquor_license": liquir !=null ?await MultipartFile.fromFile(liquir.path, filename: liq):"",
      "trade_license":trade !=null ? await MultipartFile.fromFile(trade.path, filename: trades):"",
      "other_documents": documnet!=null ?await MultipartFile.fromFile(documnet.path, filename: documents):"",

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
      print("_selectedServices");
      print(driving);
      print(passport_file);
      print(llp);
      print(company);
      print(documnet);
      print(service_id);

      Response response = await dio.post(Get.find<GlobalService>().baseUrl + "/api/contract_kyc",
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

      return response.statusCode;
    } catch (e) {
      print('Error: $e');
    }

  }

}

