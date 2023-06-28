import 'package:bizmart/app/modules/global_widgets/phone_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/auth_controller.dart';
class CustomClipPath extends CustomClipper<Path> {
  var radius=5.0;
  @override

  Path getClip(Size size) {

    var path = Path();
    path.lineTo(0, size.height-200);
    //path.lineTo(size.width / 2, size.height/4);
    path.quadraticBezierTo(size.width / 4, size.height, size.width, size.height);
    // path.lineTo(size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class ForgotPasswordView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    controller.forgotPasswordFormKey = new GlobalKey<FormState>();
    return Container(
      color: Get.theme.colorScheme.secondary,

      child: SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //   // title: Text(
            //   //   "Phone Verification".tr,
            //   //   style: Get.textTheme.headline6.merge(TextStyle(color: context.theme.primaryColor)),
            //   // ),
            //   centerTitle: true,
            //   backgroundColor: Get.theme.colorScheme.secondary,
            //   automaticallyImplyLeading: false,
            //   elevation: 0,
            //   leading: new IconButton(
            //     icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
            //     onPressed: () => {Get.back()},
            //   ),
            // ),

            // appBar: AppBar(
            //   title: Text(
            //     "Forgot Password".tr,
            //     style: Get.textTheme.headline6.merge(TextStyle(color: context.theme.primaryColor)),
            //   ),
            //   centerTitle: true,
            //   backgroundColor: Get.theme.colorScheme.secondary,
            //   automaticallyImplyLeading: false,
            //   elevation: 0,
            // ),
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
                        SizedBox(height: 10),
                        // TextFieldWidget(
                        //   labelText: "Email Address".tr,
                        //   hintText: "Email Address".tr,
                        //   initialValue: controller.currentUser?.value?.email,
                        //   onSaved: (input) => controller.currentUser.value.email = input,
                        //   validator: (input) => !GetUtils.isEmail(input) ? "Should be a valid email".tr : null,
                        //   iconData: Icons.alternate_email,
                        // ),
                        Container(
                          padding: EdgeInsets.only(top: 30, bottom: 8, left: 20, right: 20),
                          // margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                          child: PhoneFieldWidget(
                            labelText: "Phone Number".tr,
                            hintText: "Phone Number".tr,
                            initialCountryCode: controller
                                .currentUser?.value
                                ?.getPhoneNumber()
                                ?.countryISOCode,
                            initialValue: controller.currentUser?.value
                                ?.getPhoneNumber()
                                ?.number,
                            onChanged: (phone) {
                              return controller.currentUser.value.phone_number = phone.completeNumber;
                            },
                            onSaved: (phone) {
                              return controller.currentUser.value.phone_number = phone.completeNumber;
                            },
                            isLast: false,
                            isFirst: false,
                          ),
                        ),
                        SizedBox(height: 10),
                        if(controller.forgetLoader.isTrue)
                          Column(
                            children: [
                              TextFieldWidget(
                                labelText: "New Password".tr,
                                hintText: "New Password".tr,
                                // initialValue: controller.currentUser?.value?.password,
                                // onSaved: (input) => controller.currentUser.value.password = input,
                                // onSaved: (input) => controller.currentUser.value.password = input,

                                initialValue: controller.forgetPasswordController.text,
                                onSaved: (input) => controller.forgetPasswordController.text = input,
                                onChanged: (input) => controller.forgetPasswordController.text = input,
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
                              TextFieldWidget(
                                labelText: "OTP Code".tr,
                                hintText: "OTP Code".tr,

                                style: Get.textTheme.headline4.merge(TextStyle(letterSpacing: 8)),
                                textAlign: TextAlign.center,
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                onChanged: (input) => controller.currentUser.value.otp = input,
                                onSaved: (input) => controller.currentUser.value.otp = input,
                                // iconData: Icons.add_to_home_screen_outlined,
                              ),
                            ],
                          )
                        else
                          Container(),
                        //   Obx(() {
                        //   if(controller.forgetLoader.isTrue)
                        //     {
                        //       return Column(
                        //         children: [
                        //           TextFieldWidget(
                        //             labelText: "New Password".tr,
                        //             hintText: "New Password".tr,
                        //             // initialValue: controller.currentUser?.value?.password,
                        //             // onSaved: (input) => controller.currentUser.value.password = input,
                        //             // onSaved: (input) => controller.currentUser.value.password = input,
                        //
                        //             initialValue: controller.passwordController.text,
                        //             onSaved: (input) => controller.passwordController.text = input,
                        //             onChanged: (input) => controller.passwordController.text = input,
                        //             validator: (input) => input.length < 3
                        //                 ? "Should be more than 3 characters".tr
                        //                 : null,
                        //             obscureText: controller.hidePassword.value,
                        //             iconData: Icons.lock_outline,
                        //             keyboardType: TextInputType.visiblePassword,
                        //             isLast: true,
                        //             isFirst: false,
                        //             suffixIcon: IconButton(
                        //               onPressed: () {
                        //                 controller.hidePassword.value =
                        //                 !controller.hidePassword.value;
                        //               },
                        //               color: Theme.of(context).focusColor,
                        //               icon: Icon(controller.hidePassword.value
                        //                   ? Icons.visibility_off_outlined
                        //                   : Icons.visibility_outlined),
                        //             ),
                        //           ),
                        //           TextFieldWidget(
                        //             labelText: "OTP Code".tr,
                        //             hintText: "OTP Code".tr,
                        //
                        //             style: Get.textTheme.headline4.merge(TextStyle(letterSpacing: 8)),
                        //             textAlign: TextAlign.center,
                        //             maxLength: 4,
                        //             keyboardType: TextInputType.number,
                        //             onChanged: (input) => controller.currentUser.value.otp = input,
                        //             onSaved: (input) => controller.currentUser.value.otp = input,
                        //             // iconData: Icons.add_to_home_screen_outlined,
                        //           ),
                        //         ],
                        //       );
                        //
                        //     }
                        //   else
                        //     {
                        //       return Container();
                        //     }
                        // }),
                        if(controller.forgetLoader.isTrue)
                          BlockButtonWidget(
                            onPressed: controller.otpCheck,
                            color: Get.theme.colorScheme.secondary,
                            text:controller.loading.isTrue?
                            CircularProgressIndicator(color: Colors.white,strokeWidth: 2,):
                            Text(
                              "Submit".tr,
                              style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor)),
                            ),
                          ).paddingSymmetric(vertical: 35, horizontal: 20)
                        else
                          BlockButtonWidget(
                            onPressed: controller.forgetPassWord,
                            color: Get.theme.colorScheme.secondary,
                            text: controller.loading.isTrue?
                            CircularProgressIndicator(color: Colors.white,strokeWidth: 2,):Text(
                              "Send".tr,
                              style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor)),
                            ),
                          ).paddingSymmetric(vertical: 35, horizontal: 20),
                        // Obx(()
                        // {
                        //   if(controller.forgetLoader.isTrue)
                        //     {
                        //       return BlockButtonWidget(
                        //         onPressed: controller.verifyPhone,
                        //         color: Get.theme.colorScheme.secondary,
                        //         text: Text(
                        //           "Submit".tr,
                        //           style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor)),
                        //         ),
                        //       ).paddingSymmetric(vertical: 35, horizontal: 20);
                        //     }
                        //   else
                        //     {
                        //       return BlockButtonWidget(
                        //         onPressed: controller.forgetPassWord,
                        //         color: Get.theme.colorScheme.secondary,
                        //         text: Text(
                        //           "Send".tr,
                        //           style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor)),
                        //         ),
                        //       ).paddingSymmetric(vertical: 35, horizontal: 20);
                        //     }
                        // }),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.forgetPasswordController.clear();
                                controller.currentUser.value.otp = null;
                                controller.currentUser.value.phone_number = null;
                                Get.offAllNamed(Routes.REGISTER);
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
                                controller.resendOTP();
                              },
                              child: Text("Resend the OTP Code Again".tr),
                            ),
                          ],
                        )

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     TextButton(
                        //       onPressed: () {
                        //         Get.offAllNamed(Routes.REGISTER);
                        //       },
                        //       child: Text("You remember my password!".tr),
                        //     ),
                        //   ],
                        // ),
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
