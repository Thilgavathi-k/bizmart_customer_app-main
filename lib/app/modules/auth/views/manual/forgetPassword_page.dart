import 'package:bizmart/app/modules/auth/controllers/auth_controller.dart';
import 'package:bizmart/app/modules/auth/views/manual/regiser_page.dart';
import 'package:bizmart/app/modules/global_widgets/block_button_widget.dart';
import 'package:bizmart/app/modules/global_widgets/text_field_widget.dart';
import 'package:bizmart/common/ui.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../forgot_password_view.dart';
import 'login_page.dart';
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  AuthController controller = Get.put(AuthController());
  void initState()
  {
    super.initState();
    controller.phoneForgetController.clear();
    controller.newPasswordController.clear();
    controller.otpController.clear();

  }
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.colorScheme.secondary,

      child: SafeArea(
        child: Scaffold(
            body: Form(
              key: controller.forgotPasswordFormKey,
              child: ListView(
                primary: true,
                children: [

                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      ClipPath(
                        clipper: CustomClipPath(),
                        child: Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          height: 280,
                          color: Get.theme.colorScheme.secondary,

                        ),
                      ),     Positioned(
                          bottom: 220,
                          child: Text("Bizmart",style: TextStyle(color: Colors.white,fontSize: 22),)),
                      Positioned(
                          bottom: 120,
                          child: Text("Forget password",style: TextStyle(color: Colors.white,fontSize: 14),)),
                      // Container(
                      //   height: 180,
                      //   width: Get.width,
                      //   decoration: BoxDecoration(
                      //     color: Get.theme.colorScheme.secondary,
                      //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                      //     boxShadow: [
                      //       BoxShadow(color: Get.theme.focusColor.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 5)),
                      //     ],
                      //   ),
                      //   margin: EdgeInsets.only(bottom: 50),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(20),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           _settings.appName,
                      //           style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor, fontSize: 24)),
                      //         ),
                      //         SizedBox(height: 5),
                      //         Text(
                      //           "Welcome to the best service provider system!".tr,
                      //           style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor)),
                      //           textAlign: TextAlign.center,
                      //         ),
                      //         // Text("Fill the following credentials to login your account", style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Container(
                        decoration: Ui.getBoxDecoration(
                          radius: 14,
                          border: Border.all(width: 5, color: Get.theme.primaryColor),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(
                            'assets/icon/icon.png',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),
                        TextFieldWidget(
                          labelText: "Phone".tr,
                          hintText: "Phone".tr,
                          // initialValue:
                          // controller.currentUser?.value?.email,
                          // onSaved: (input) =>
                          // controller.currentUser.value.email = input,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          onSaved: (input) => controller.phoneForgetController.text = input,
                          onChanged: (input) => controller.phoneForgetController.text = input,

                          iconData: Icons.phone,
                          isFirst: false,
                          isLast: false,
                        ),
                        SizedBox(height: 20),
                        if(controller.loaderForgetVerify.isTrue)
                          Column(
                            children: [
                              TextFieldWidget(
                                labelText: "New Password".tr,
                                hintText: "New Password".tr,
                                onSaved: (input) => controller.newPasswordController.text = input,
                                onChanged: (input) => controller.newPasswordController.text = input,
                                validator: (input) => input.length < 3
                                    ? "Should be more than 3 characters".tr
                                    : null,
                                obscureText: controller.hidePassword.value,
                                iconData: Icons.lock_outline,
                                keyboardType: TextInputType.visiblePassword,
                                isLast: true,
                                isFirst: false,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.hidePassword.value =
                                    !controller.hidePassword.value;
                                  },
                                  color: Theme.of(context).focusColor,
                                  icon: Icon(controller.hidePassword.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFieldWidget(
                                labelText: "OTP".tr,
                                hintText: "OTP".tr,
                                // initialValue:
                                // controller.currentUser?.value?.email,
                                // onSaved: (input) =>
                                // controller.currentUser.value.email = input,
                                onSaved: (input) => controller.otpController.text = input,
                                onChanged: (input) => controller.otpController.text = input,
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                                iconData: Icons.phone_android,
                                isFirst: false,
                                isLast: false,
                              )
                            ],
                          )
                        else
                          Container(),
                        if(controller.loaderForgetVerify.isTrue)
                          BlockButtonWidget(
                            onPressed: ()
                            {
                              if(controller.otpController.text.isNotEmpty && controller.phoneForgetController.text.isNotEmpty)
                              {
                                if(controller.phoneForgetController.text.length == 10)
                                {

                                  controller.otpCheck();
                                  // if(controller.otpCheckStatus.isTrue)
                                  //   {
                                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                  //
                                  //   }

                                }
                                else
                                {
                                  Fluttertoast.showToast(
                                      toastLength: Toast.LENGTH_SHORT,
                                      msg: "Phone number should be 10 digit",
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Get.theme.colorScheme.secondary,
                                      textColor: Colors.white,
                                      fontSize: 14.0);
                                }

                              }
                              else
                              {
                                Fluttertoast.showToast(
                                    toastLength: Toast.LENGTH_SHORT,
                                    msg: "Please enter all fields",
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Get.theme.colorScheme.secondary,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
                              }
                              },
                            color: Get.theme.colorScheme.secondary,
                            text:controller.loaderForgetOtp.isTrue?
                            CircularProgressIndicator(color: Colors.white,strokeWidth: 2,):
                            Text(
                              "Submit".tr,
                              style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor)),
                            ),
                          ).paddingSymmetric(vertical: 35, horizontal: 20)
                        else
                          BlockButtonWidget(
                            onPressed: ()
                            {
                              if(controller.phoneForgetController.text.isNotEmpty)
                              {
                                if(controller.phoneForgetController.text.length == 10)
                                {
                                  controller.forgetPassWord();

                                }
                                else
                                {
                                  Fluttertoast.showToast(
                                      toastLength: Toast.LENGTH_SHORT,
                                      msg: "Phone number should be 10 digit",
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Get.theme.colorScheme.secondary,
                                      textColor: Colors.white,
                                      fontSize: 14.0);
                                }

                              }
                              else
                              {
                                Fluttertoast.showToast(
                                    toastLength: Toast.LENGTH_SHORT,
                                    msg: "Please enter phone number",
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Get.theme.colorScheme.secondary,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
                              }
                            },
                            color: Get.theme.colorScheme.secondary,
                            text: controller.forgetLoader.isTrue?
                            CircularProgressIndicator(color: Colors.white,strokeWidth: 2,):Text(
                              "Send".tr,
                              style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor)),
                            ),
                          ).paddingSymmetric(vertical: 35, horizontal: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));

                              },
                              child: Text("You don't have an account?".tr),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.resendPhoneController.text = controller.phoneForgetController.text;

                                if(controller.phoneForgetController.text.isNotEmpty && controller.resendPhoneController.text.isNotEmpty)
                                {
                                  if(controller.phoneForgetController.text.length == 10 && controller.resendPhoneController.text.length == 10)
                                    {

                                      controller.resendOTP();

                                    }
                                  else
                                    {
                                      Fluttertoast.showToast(
                                          toastLength: Toast.LENGTH_SHORT,
                                          msg: "Phone number should be 10 digit",
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Get.theme.colorScheme.secondary,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    }

                                }
                                else
                                  {
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg: "Please enter phone number",
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Get.theme.colorScheme.secondary,
                                        textColor: Colors.white,
                                        fontSize: 14.0);
                                  }
                              },
                              child: Text("Resend the OTP Code Again".tr),
                            ),
                          ],
                        )

                      ],
                    );

                  }),
                ],
              ),
            )),
      ),
    );
  }
}
