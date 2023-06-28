import 'dart:async';
import 'dart:convert';

import 'package:bizmart/app/models/busines_details_save_api/device_token_generate_api.dart';
import 'package:bizmart/app/modules/auth/views/manual/login_page.dart';
import 'package:bizmart/app/services/global_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../common/ui.dart';
import '../../../models/user_model.dart';
import '../../../repositories/user_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/firebase_messaging_service.dart';
import '../../root/controllers/root_controller.dart';

class AuthController extends GetxController {
  final Rx<User> currentUser = Get.find<AuthService>().user;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> registerFormKey;
  GlobalKey<FormState> forgotPasswordFormKey;
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgetPasswordController = TextEditingController();

  //FORREGISTER
  final loaderRegister = false.obs;
  final loaderRegi = false.obs;
  final loaderVerify = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();
  TextEditingController regOtpController = TextEditingController();

  //FORLOGIN
  final loaderLogin = false.obs;
  TextEditingController phoneLoginController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  //FORLOGIN

  final loaderForgetOtp = false.obs;
  final loaderForgetVerify = false.obs;
  final forgetLoader = false.obs;
  final otpCheckStatus = false.obs;
  TextEditingController phoneForgetController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController resendPhoneController = TextEditingController();

  final hidePassword = true.obs;
  final loading = false.obs;
  final otpEnable = false.obs;
  final otpLoading = false.obs;

  final smsSent = ''.obs;
  var device_token;
  UserRepository _userRepository;

  AuthController() {
    _userRepository = UserRepository();
  }

  void otpCheck() async {
    try {
      currentUser.value.otp = otpController.text.toString();
      currentUser.value.newPassword = newPasswordController.text;
      currentUser.value.phone_number = "+91"+phoneForgetController.text.toString();;
      currentUser.value.mobile_number = phoneForgetController.text.toString();;
      loaderForgetOtp.value = true;
      await _userRepository.otpCheck(currentUser.value);
      otpCheckStatus.value = true;
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: "Password reset successfully",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0);
      Get.to(LoginPage());
      // Get.toNamed(Routes.LOGIN);
    }
    catch (e)
    {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: e.toString().split("Exception:")[1],
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0);    }
    finally
    {
      loaderForgetOtp.value = false;

    }
    // if (currentUser.value.phone_number.toString() != "null" &&
    //     forgetPasswordController.text.isNotEmpty &&
    //     currentUser.value.otp != null) {
    //   currentUser.value.otp = currentUser.value.otp;
    //   currentUser.value.newPassword = forgetPasswordController.text;
    //   currentUser.value.mobile_number = currentUser.value.phone_number.toString().split("+91")[1];
    //
    //   try {
    //     loading.value = true;
    //     await _userRepository.otpCheck(currentUser.value);
    //     currentUser.value.phone_number = null;
    //     forgetPasswordController.clear();
    //     currentUser.value.otp = null;
    //     forgetLoader.value = false;
    //     Fluttertoast.showToast(
    //         toastLength: Toast.LENGTH_SHORT,
    //         msg: "Password reset successfully",
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 3,
    //         backgroundColor: Get.theme.colorScheme.secondary,
    //         textColor: Colors.white,
    //         fontSize: 14.0);
    //     Get.toNamed(Routes.LOGIN);
    //   } catch (e) {
    //     Fluttertoast.showToast(
    //         toastLength: Toast.LENGTH_SHORT,
    //         msg: "${e}",
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 3,
    //         backgroundColor: Get.theme.colorScheme.secondary,
    //         textColor: Colors.white,
    //         fontSize: 14.0);
    //   } finally {
    //     loading.value = false;
    //   }
    // } else {
    //   Fluttertoast.showToast(
    //       toastLength: Toast.LENGTH_SHORT,
    //       msg: "Please enter all fields",
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 3,
    //       backgroundColor: Get.theme.colorScheme.secondary,
    //       textColor: Colors.white,
    //       fontSize: 14.0);
    // }

  }

  void login() async {
    try {
      loaderLogin.value = true;
      final deviceToken = await FirebaseMessaging.instance.getToken();
      currentUser.value.phone_number =
          "+91" + phoneLoginController.text.toString();
      currentUser.value.password = loginPasswordController.text.toString();
      currentUser.value.deviceToken = deviceToken;
      currentUser.value = await _userRepository.login(currentUser.value);
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: "Login successfully",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0);
      await Get.put(RootController()).changePage(0);
    } catch (e) {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: e.toString().split("Exception:")[1],
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0);
    } finally {
      loaderLogin.value = false;
    }
    // if(currentUser.value.phone_number.toString() == "null" && loginPasswordController.text.isEmpty )
    // {
    //   Fluttertoast.showToast(
    //       toastLength: Toast.LENGTH_SHORT,
    //       msg: "Please enter all fields",
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 3,
    //       backgroundColor: Get.theme.colorScheme.secondary,
    //       textColor: Colors.white,
    //       fontSize: 14.0);
    // }
    // else
    // {
    //   if(currentUser.value.phone_number.length == 13)
    //   {
    //     Get.focusScope.unfocus();
    //     if (loginFormKey.currentState.validate()) {
    //       loginFormKey.currentState.save();
    //       loading.value = true;
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
    //
    // await Get.find<FireBaseMessagingService>().setDeviceToken();
    //       try {
    //         print("DEVICETOKRNVALUESS");
    //         print(currentUser.value.phoneNumber);
    //
    //         currentUser.value.phone_number = currentUser.value.phone_number;
    //         currentUser.value.password = loginPasswordController.text.toString();
    //         currentUser.value = await _userRepository.login(currentUser.value);
    //         // await DeviceTokenData().DeviceTokenDataPost(device_token);
    //         Fluttertoast.showToast(
    //             toastLength: Toast.LENGTH_SHORT,
    //             msg: "Login successfully",
    //             gravity: ToastGravity.BOTTOM,
    //             timeInSecForIosWeb: 3,
    //             backgroundColor: Get.theme.colorScheme.secondary,
    //             textColor: Colors.white,
    //             fontSize: 14.0);
    //
    //         await Get.put(RootController()).changePage(0);
    //
    //         //  await _userRepository.signInWithEmailAndPassword(currentUser.value.email, currentUser.value.apiToken);
    //       }
    //       catch (e) {
    //         Fluttertoast.showToast(
    //             toastLength: Toast.LENGTH_SHORT,
    //             msg: e.toString(),
    //             gravity: ToastGravity.BOTTOM,
    //             timeInSecForIosWeb: 3,
    //             backgroundColor: Get.theme.colorScheme.secondary,
    //             textColor: Colors.white,
    //             fontSize: 14.0);
    //       } finally {
    //
    //       }
    //     }
    //   }
    //   else
    //   {
    //
    //     print("PHONENMBERLENGTH");
    //     print(currentUser.value.phone_number.length);
    //     Fluttertoast.showToast(
    //         toastLength: Toast.LENGTH_SHORT,
    //         msg: "Phone number should be 10 digit",
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 3,
    //         backgroundColor: Get.theme.colorScheme.secondary,
    //         textColor: Colors.white,
    //         fontSize: 14.0);
    //   }
    //
    // }
  }

  void register() async {
    print("OTPCHECKSSSS");
    try {
      currentUser.value.name = nameController.text.toString();
      currentUser.value.phone_number = "+91" + phoneController.text.toString();
      currentUser.value.password = regPasswordController.text.toString();
      currentUser.value.mobile_number = phoneController.text.toString();
      currentUser.value.email = emailController.text.toString();
      currentUser.value.otp = regOtpController.text.toString();
      loaderRegi.value = true;
      currentUser.value = await _userRepository.register(currentUser.value);
      loaderVerify.value = true;
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: "Signup successfully",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0);

      await Get.find<RootController>().changePage(0);
    } catch (e) {
      print("slkdls");
      print(e.toString());
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: e.toString().split("Exception:")[1],
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0);
    } finally {
      loaderRegi.value = false;
      loaderVerify.value = false;
    }
  }

  void otpRegister() async {
    print("GETOTPE");
    print(currentUser.value.otp);
    print(passwordController.text);
    try {
      currentUser.value.name = nameController.text.toString();
      currentUser.value.phone_number = phoneController.text.toString();
      currentUser.value.mobile_number = phoneController.text.toString();
      currentUser.value.password = regPasswordController.text.toString();
      currentUser.value.email = emailController.text.toString();
      loaderRegister.value = true;
      currentUser.value = await _userRepository.otpRegister(currentUser.value);
      otpEnable.value = true;
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: "Please enter otp",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0);
    } catch (e) {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: e.toString(),
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0);
    } finally {
      loaderRegister.value = false;
    }
  }

  Future<void> verifyPhone() async {
    try {
      loading.value = true;
      print("OTPCHEC");
      print(passwordController.text);
      print(currentUser.value.password);
      print(currentUser.value);
      currentUser.value.password = passwordController.text;
      currentUser.value.newPassword = passwordController.text;
      currentUser.value.phone_number =
          currentUser.value.phoneNumber.toString().split("+91")[0];
      currentUser.value.mobile_number = currentUser.value.phoneNumber;
      // await _userRepository.otpCheck(currentUser.value);
      // await _userRepository.verifyPhone(smsSent.value);
      await Get.find<FireBaseMessagingService>().setDeviceToken();
      currentUser.value = await _userRepository.register(currentUser.value);
      // await _userRepository.signUpWithEmailAndPassword(currentUser.value.email, currentUser.value.apiToken);
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: "Verified successfully",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0);
      await Get.find<RootController>().changePage(0);
    } catch (e) {
      // Get.back();
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: "${e.toString()}",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0);
    } finally {
      loading.value = false;
    }
  }

  Future<void> resendOTPCode() async {
    await _userRepository.sendCodeToPhone();
  }

  Future<void> resendOTP() async {
    currentUser.value.phone_number = currentUser.value.phone_number;
    currentUser.value.mobile_number = currentUser.value.phone_number.toString().split("+91")[1];
    var data = {
      "mobile_number": currentUser.value.phone_number.toString().split("+91")[1],
    };
    var body = json.encode(data);
    try {
      // loading.value = true;
      print(" forget page api");
      print(body);
      var url =
      Uri.parse(Get.find<GlobalService>().baseUrl + '/api/resend-otp');
      print(url);
      var respose = await http.post(url,
          headers: {"Content-Type": "application/json"},
          encoding: Encoding.getByName("utf-8"),
          body: body);
      print(respose);
      print(respose.statusCode);
      if (respose.statusCode == 200 || respose.statusCode == 201) {
        var datas = respose.body;
        var resource = json.decode(datas);
        print(resource);
        // forgetLoader.value = true;
        if (resource['status'] == 200 || resource['status'] == "201") {
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              msg: "OTP sent your phone",
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Get.theme.colorScheme.secondary,
              textColor: Colors.white,
              fontSize: 14.0);
        } else {
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              msg: "${resource['message']}",
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Get.theme.colorScheme.secondary,
              textColor: Colors.white,
              fontSize: 14.0);
        }
        return resource;
      }
    }
    catch (e) {
      print("error");
    }
    finally
    {
      // loading.value = false;

    }
  }

  void sendResetLink() async {
    Get.focusScope.unfocus();
    if (forgotPasswordFormKey.currentState.validate()) {
      forgotPasswordFormKey.currentState.save();
      loading.value = true;
      try {
        await _userRepository.sendResetLinkEmail(currentUser.value);
        loading.value = false;
        Get.showSnackbar(Ui.SuccessSnackBar(
            message:
                "The Password reset link has been sent to your email: ".tr +
                    currentUser.value.email));
        Timer(Duration(seconds: 5), () {
          Get.offAndToNamed(Routes.LOGIN);
        });
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }

  void forgetPassWord() async {
    print("FORGETPASSWORD");
    currentUser.value.phone_number = "+91" + phoneForgetController.text;
    currentUser.value.mobile_number = phoneForgetController.text;

    var data = {
      "phone_number": "+91" + phoneForgetController.text,
      "mobile_number": phoneForgetController.text,
      "otp": otpController.text
    };
    var body = json.encode(data);
    try {
      forgetLoader.value = true;
      print(" forget page api");
      print(body);
      var url = Uri.parse(Get.find<GlobalService>().baseUrl + '/api/forget_password');
      print(url);
      var respose = await http.post(url,
          headers: {"Content-Type": "application/json"},
          encoding: Encoding.getByName("utf-8"),
          body: body);
      print(respose);
      print(respose.statusCode);
      var datas = respose.body;
      var resource = json.decode(datas);
      print(resource);
      if (resource['status'] == 200 || resource['status'] == 201)
      {
        loaderForgetVerify.value = true;
      }
      else
      {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT,
            msg: "${resource['message']}",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Get.theme.colorScheme.secondary,
            textColor: Colors.white,
            fontSize: 14.0);
      }

      return resource;
    } catch (e) {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          msg: e.toString().split("Exception:")[1],
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0);
    } finally {
      forgetLoader.value = false;
    }

    // if(currentUser.value.phone_number.toString() == "null" || currentUser.value.phone_number.toString().isEmpty)
    // {
    //   Fluttertoast.showToast(
    //       toastLength: Toast.LENGTH_SHORT,
    //       msg: "Please enter phone number",
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 3,
    //       backgroundColor: Get.theme.colorScheme.secondary,
    //       textColor: Colors.white,
    //       fontSize: 14.0);
    // }
    // else
    // {
    //
    //   currentUser.value.phone_number = currentUser.value.phone_number;
    //   currentUser.value.mobile_number = currentUser.value.phone_number.toString().split("+91")[1];
    //   currentUser.value.password = passwordController.text.toString();
    //   print(currentUser.value.phone_number.toString().split("+91")[1]);
    //   var data={
    //     "phone_number":currentUser.value.phone_number,
    //     "mobile_number":currentUser.value.phone_number.toString().split("+91")[1],
    //     "otp":otpController.text
    //   };
    //   var body= json.encode(data);
    //   try{
    //     loading.value = true;
    //     print(" forget page api");
    //     print(body);
    //     var url =Uri.parse(Get.find<GlobalService>().baseUrl+'/api/forget_password');
    //     print(url);
    //     var respose= await http.post(url,
    //         headers: {"Content-Type": "application/json"},
    //         encoding: Encoding.getByName("utf-8"),
    //         body: body);
    //     print(respose);
    //     print(respose.statusCode);
    //     var datas = respose.body;
    //     var resource =json.decode(datas);
    //     print(resource);
    //     if(resource['status'] == 200 || resource['status'] == 201)
    //     {
    //       forgetLoader.value = true;
    //
    //     }
    //     else
    //     {
    //       Fluttertoast.showToast(
    //           toastLength: Toast.LENGTH_SHORT,
    //           msg: "${resource['message']}",
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 3,
    //           backgroundColor: Get.theme.colorScheme.secondary,
    //           textColor: Colors.white,
    //           fontSize: 14.0);
    //     }
    //
    //     return resource;
    //
    //   }catch(e){
    //     print("error");
    //   }
    //   finally
    //   {
    //     loading.value = false;
    //
    //   }
    // }
  }

  void deviceToken() {
    FirebaseMessaging _firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token) {
      print("++++++++++++++++++DEVICE TOKEN+++++++++++++++++++++++++++++");
      print("token is $token");
    });
  }
}
