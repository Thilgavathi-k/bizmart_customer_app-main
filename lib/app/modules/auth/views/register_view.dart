import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/phone_field_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/auth_controller.dart';

class CustomClipPath extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 200);
    //path.lineTo(size.width / 2, size.height/4);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width, size.height);
    // path.lineTo(size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class RegisterView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    controller.registerFormKey = new GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Container(
        color: Get.theme.colorScheme.secondary,
        child: SafeArea(
          child: Scaffold(
            // appBar: AppBar(
            //   title: Text(
            //     "Bizmart".tr,
            //     style: Get.textTheme.headline6.merge(TextStyle(color: context.theme.primaryColor)),
            //   ),
            //   centerTitle: true,
            //   backgroundColor: Get.theme.colorScheme.secondary,
            //   automaticallyImplyLeading: false,
            //   elevation: 0,
            //   // leading: new IconButton(
            //   //   icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
            //   //   onPressed: () => {Get.find<RootController>().changePageOutRoot(0)},
            //   // ),
            // ),
            body: Container(
              child: Form(
                key: controller.registerFormKey,
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
                            height: 230,
                            color: Get.theme.colorScheme.secondary,
                          ),
                        ),
                        Positioned(
                            bottom: 180,
                            child: Text(
                              "Bizmart",
                              style:
                              TextStyle(color: Colors.white, fontSize: 22),
                            )),
                        // Container(
                        //   height: 160,
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
                        Positioned(
                            bottom: 120,
                            child: Text(
                              "Register",
                              style:
                              TextStyle(color: Colors.white, fontSize: 14),
                            )),
                        Container(
                          decoration: Ui.getBoxDecoration(
                            radius: 14,
                            border: Border.all(
                                width: 5, color: Get.theme.primaryColor),
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
                      return Container(
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFieldWidget(
                              labelText: "Full Name".tr,
                              hintText: "Full Name".tr,
                              initialValue:
                              controller.currentUser?.value?.name,
                              onSaved: (input) =>
                              controller.currentUser.value.name = input,
                              validator: (input)
                              {
                                // controller.otpEnable.value = false;
                                input.length < 3
                                    ? "Should be more than 3 characters".tr
                                    : null;
                              },
                              iconData: Icons.person_outline,
                              isFirst: true,
                              isLast: false,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFieldWidget(
                              labelText: "Email Address".tr,
                              hintText: "Email Address".tr,
                              initialValue:
                              controller.currentUser?.value?.email,
                              onSaved: (input) =>
                              controller.currentUser.value.email = input,
                              validator: (input)
                              {
                                controller.otpEnable.value = false;
                                !input.contains('@')
                                    ? "Should be a valid email".tr
                                    : null;
                              },
                              iconData: Icons.alternate_email,
                              isFirst: false,
                              isLast: false,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
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
                                onSaved: (phone) {
                                  return controller.currentUser.value.phone_number = phone.completeNumber;
                                },
                                onChanged: (phone) {
                                  return controller.currentUser.value.phone_number = phone.completeNumber;
                                },
                                isLast: false,
                                isFirst: false,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Obx(() {
                              return TextFieldWidget(
                                labelText: "Password".tr,
                                hintText: "Password".tr,
                                initialValue: controller.currentUser?.value?.password,
                                onSaved: (input) => controller.currentUser.value.password = input,
                                onChanged: (input) => controller.currentUser.value.password = input,

                                // initialValue: controller.passwordController.text,
                                // onSaved: (input) => controller.passwordController.text = input,
                                // onChanged: (input) => controller.passwordController.text = input,
                                validator: (input)
                                {
                                  controller.otpEnable.value = false;
                                  input.length < 3
                                      ? "Should be more than 3 characters".tr
                                      : null;
                                },
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
                              );
                            }),
                            SizedBox(
                              height: 10,
                            ),
                            // TextFieldWidget(
                            //   labelText: "OTP".tr,
                            //   hintText: "OTP".tr,
                            //   keyboardType: TextInputType.number,
                            //   onSaved: (input) => controller.otpController.text = input,
                            //   onChanged: (input) => controller.otpController.text = input,
                            //   // onSaved: (input) => controller.currentUser.value.otp = input,
                            //   // onChanged: (input) => controller.currentUser.value.otp = input,
                            //   iconData: Icons.phone_android,
                            //   isFirst: false,
                            //   isLast: false,
                            // ),

                          ],
                        ),
                      );
                      // if (controller.loading.isTrue) {
                      //   return CircularLoadingWidget(height: 300);
                      // } else {
                      //   return Container(
                      //     child: Column(
                      //       //crossAxisAlignment: CrossAxisAlignment.stretch,
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         TextFieldWidget(
                      //           labelText: "Full Name".tr,
                      //           hintText: "Full Name".tr,
                      //           initialValue:
                      //               controller.currentUser?.value?.name,
                      //           onSaved: (input) =>
                      //               controller.currentUser.value.name = input,
                      //           validator: (input) => input.length < 3
                      //               ? "Should be more than 3 characters".tr
                      //               : null,
                      //           iconData: Icons.person_outline,
                      //           isFirst: true,
                      //           isLast: false,
                      //         ),
                      //         SizedBox(
                      //           height: 15,
                      //         ),
                      //         TextFieldWidget(
                      //           labelText: "Email Address".tr,
                      //           hintText: "Email Address".tr,
                      //           initialValue:
                      //               controller.currentUser?.value?.email,
                      //           onSaved: (input) =>
                      //               controller.currentUser.value.email = input,
                      //           validator: (input) => !input.contains('@')
                      //               ? "Should be a valid email".tr
                      //               : null,
                      //           iconData: Icons.alternate_email,
                      //           isFirst: false,
                      //           isLast: false,
                      //         ),
                      //         SizedBox(
                      //           height: 15,
                      //         ),
                      //         Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 20),
                      //           child: PhoneFieldWidget(
                      //             labelText: "Phone Number".tr,
                      //             hintText: "Phone Number".tr,
                      //             initialCountryCode: controller
                      //                 .currentUser?.value
                      //                 ?.getPhoneNumber()
                      //                 ?.countryISOCode,
                      //             initialValue: controller.currentUser?.value
                      //                 ?.getPhoneNumber()
                      //                 ?.number,
                      //             onSaved: (phone) {
                      //               return controller.currentUser.value.phoneNumber = phone.completeNumber;
                      //             },
                      //             isLast: false,
                      //             isFirst: false,
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: 15,
                      //         ),
                      //         Obx(() {
                      //           return TextFieldWidget(
                      //             labelText: "Password".tr,
                      //             hintText: "Password".tr,
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
                      //                     !controller.hidePassword.value;
                      //               },
                      //               color: Theme.of(context).focusColor,
                      //               icon: Icon(controller.hidePassword.value
                      //                   ? Icons.visibility_off_outlined
                      //                   : Icons.visibility_outlined),
                      //             ),
                      //           );
                      //         }),
                      //         SizedBox(
                      //           height: 10,
                      //         ),
                      //         // TextFieldWidget(
                      //         //   labelText: "OTP".tr,
                      //         //   hintText: "OTP".tr,
                      //         //   keyboardType: TextInputType.number,
                      //         //   onSaved: (input) => controller.otpController.text = input,
                      //         //   onChanged: (input) => controller.otpController.text = input,
                      //         //   // onSaved: (input) => controller.currentUser.value.otp = input,
                      //         //   // onChanged: (input) => controller.currentUser.value.otp = input,
                      //         //   iconData: Icons.phone_android,
                      //         //   isFirst: false,
                      //         //   isLast: false,
                      //         // ),
                      //
                      //       ],
                      //     ),
                      //   );
                      // }
                    })
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: BlockButtonWidget(
                          onPressed: ()  {
                             controller.otpRegister();
                            // controller.register();
                            if(controller.otpEnable.isTrue)
                            {
                              Get.toNamed(Routes.PHONE_VERIFICATION);

                            }
                          },
                          color: Get.theme.colorScheme.secondary,
                          text: controller.loading.isTrue?
                          CircularProgressIndicator(color: Colors.white,strokeWidth: 2,):Text(
                            "Register".tr,
                            style: Get.textTheme.headline6
                                .merge(TextStyle(color: Get.theme.primaryColor)),
                          ),
                        ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                      ),
                      // Obx(()
                      // {
                      //   return  SizedBox(
                      //     width: Get.width,
                      //     child: BlockButtonWidget(
                      //       onPressed: () {
                      //         controller.otpRegister();
                      //         // controller.register();
                      //         // Get.offAllNamed(Routes.PHONE_VERIFICATION);
                      //       },
                      //       color: Get.theme.colorScheme.secondary,
                      //       text: Text(
                      //         "Register".tr,
                      //         style: Get.textTheme.headline6
                      //             .merge(TextStyle(color: Get.theme.primaryColor)),
                      //       ),
                      //     ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                      //   );
                      //   // if(controller.otpEnable.isTrue)
                      //   //   {
                      //   //     return  SizedBox(
                      //   //       width: Get.width,
                      //   //       child: BlockButtonWidget(
                      //   //         onPressed: () {
                      //   //           // controller.otpRegister();
                      //   //
                      //   //
                      //   //           if(controller.otpController.text.isNotEmpty)
                      //   //           {
                      //   //             controller.register();
                      //   //
                      //   //           }
                      //   //           else
                      //   //           {
                      //   //             Fluttertoast.showToast(
                      //   //                 toastLength: Toast.LENGTH_SHORT,
                      //   //                 msg: "Please enter otp",
                      //   //                 gravity: ToastGravity.BOTTOM,
                      //   //                 timeInSecForIosWeb: 3,
                      //   //                 backgroundColor: Colors.black,
                      //   //                 textColor: Colors.white,
                      //   //                 fontSize: 14.0);
                      //   //
                      //   //           }
                      //   //           //Get.offAllNamed(Routes.PHONE_VERIFICATION);
                      //   //         },
                      //   //         color: Get.theme.colorScheme.secondary,
                      //   //         text: Text(
                      //   //           "Register".tr,
                      //   //           style: Get.textTheme.headline6
                      //   //               .merge(TextStyle(color: Get.theme.primaryColor)),
                      //   //         ),
                      //   //       ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                      //   //     );
                      //   //
                      //   //   }
                      //   // else
                      //   //   {
                      //   //     return  SizedBox(
                      //   //       width: Get.width,
                      //   //       child: BlockButtonWidget(
                      //   //         onPressed: () {
                      //   //           controller.otpRegister();
                      //   //           // controller.register();
                      //   //           //Get.offAllNamed(Routes.PHONE_VERIFICATION);
                      //   //         },
                      //   //         color: Get.theme.colorScheme.secondary,
                      //   //         text: Text(
                      //   //           "Get OTP".tr,
                      //   //           style: Get.textTheme.headline6
                      //   //               .merge(TextStyle(color: Get.theme.primaryColor)),
                      //   //         ),
                      //   //       ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                      //   //     );
                      //   //   }
                      //
                      // }),


                      TextButton(
                        onPressed: () async{
                          // controller.currentUser.value.phone_number ="";
                          controller.currentUser.value.phone_number =  null;
                          controller.currentUser.value.password =  null;

                          await   Get.toNamed(Routes.LOGIN);
                        },
                        child: Text("You already have an account?".tr),
                      ).paddingOnly(bottom: 10),
                    ],
                  );
                }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
