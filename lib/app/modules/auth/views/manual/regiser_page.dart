import 'package:bizmart/app/modules/auth/controllers/auth_controller.dart';
import 'package:bizmart/app/modules/auth/views/manual/login_page.dart';
import 'package:bizmart/app/modules/global_widgets/block_button_widget.dart';
import 'package:bizmart/app/modules/global_widgets/text_field_widget.dart';
import 'package:bizmart/app/routes/app_routes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../common/helper.dart';
import '../../../../../common/ui.dart';
import '../../../global_widgets/phone_field_widget.dart';
import '../forgot_password_view.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  AuthController controller = Get.put(AuthController());
  void initState()
  {
    super.initState();
    controller.phoneController.clear();
    controller.regPasswordController.clear();
    controller.emailController.clear();
    controller.nameController.clear();
    controller.regOtpController.clear();
  }
  Widget build(BuildContext context) {
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
                    Container(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldWidget(
                            labelText: "Full Name".tr,
                            hintText: "Full Name".tr,
                            // initialValue: controller.currentUser?.value?.name,
                            onSaved: (input) => controller.nameController.text = input,
                            onChanged: (input) => controller.nameController.text = input,
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
                            // initialValue:
                            // controller.currentUser?.value?.email,
                            // onSaved: (input) =>
                            // controller.currentUser.value.email = input,
                            onSaved: (input) => controller.emailController.text = input,
                            onChanged: (input) => controller.emailController.text = input,
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
                          TextFieldWidget(
                            labelText: "Phone".tr,
                            hintText: "Phone".tr,
                            // initialValue:
                            // controller.currentUser?.value?.email,
                            // onSaved: (input) =>
                            // controller.currentUser.value.email = input,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            onSaved: (input) => controller.phoneController.text = input,
                            onChanged: (input) => controller.phoneController.text = input,

                            iconData: Icons.phone,
                            isFirst: false,
                            isLast: false,
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          Obx(() {
                            return TextFieldWidget(
                              labelText: "Password".tr,
                              hintText: "Password".tr,
                              // initialValue: controller.currentUser?.value?.password,
                              // onSaved: (input) => controller.currentUser.value.password = input,
                              // onChanged: (input) => controller.currentUser.value.password = input,

                              onSaved: (input) => controller.regPasswordController.text = input,
                              onChanged: (input) => controller.regPasswordController.text = input,
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

                         Obx(() {
                           if(controller.otpEnable.isTrue)
                             {
                               return TextFieldWidget(
                                 labelText: "OTP".tr,
                                 hintText: "OTP".tr,
                                 // initialValue:
                                 // controller.currentUser?.value?.email,
                                 // onSaved: (input) =>
                                 // controller.currentUser.value.email = input,
                                 onSaved: (input) => controller.regOtpController.text = input,
                                 onChanged: (input) => controller.regOtpController.text = input,
                                 keyboardType: TextInputType.number,
                                 maxLength: 4,
                                 iconData: Icons.phone_android,
                                 isFirst: false,
                                 isLast: false,
                               );
                             }
                           else
                             {
                               return Container();
                             }

                           }
                         ),
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
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    if(controller.otpEnable.isTrue)
                      {
                        return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.vertical,
                          children: [
                            SizedBox(
                              width: Get.width,
                              child: BlockButtonWidget(
                                onPressed: ()  async{

                                  if(controller.regOtpController.text.isNotEmpty && controller.nameController.text.isNotEmpty && controller.emailController.text.isNotEmpty && controller.phoneController.text.isNotEmpty && controller.regPasswordController.text.isNotEmpty)
                                  {
                                    final bool isValid = EmailValidator.validate(controller.emailController.text.trim());

                                    if(controller.phoneController.text.length == 10)
                                    {
                                      if(isValid == true)
                                      {
                                        if(controller.regOtpController.text.length == 4)
                                          {
                                            controller.register();

                                          }
                                        else
                                          {
                                            Fluttertoast.showToast(
                                                toastLength: Toast.LENGTH_SHORT,
                                                msg: "OTP should be 4 digit",
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
                                            msg: "Please enter valid email",
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
                                text: controller.loaderRegi.isTrue?
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));

                                // await   Get.toNamed(Routes.LOGIN);
                              },
                              child: Text("You already have an account?".tr),
                            ).paddingOnly(bottom: 10),
                          ],
                        );

                      }
                    else
                      {
                        return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.vertical,
                          children: [
                            SizedBox(
                              width: Get.width,
                              child: BlockButtonWidget(
                                onPressed: ()  async{

                                  if(controller.nameController.text.isNotEmpty && controller.emailController.text.isNotEmpty && controller.phoneController.text.isNotEmpty && controller.regPasswordController.text.isNotEmpty)
                                  {
                                    final bool isValid = EmailValidator.validate(controller.emailController.text.trim());

                                    if(controller.phoneController.text.length == 10)
                                    {
                                      if(isValid == true)
                                      {
                                        await controller.otpRegister();
                                        // if(controller.otpEnable.value == true)
                                        // {
                                        //   Get.to(Routes.PHONE_VERIFICATION);
                                        //
                                        // }
                                      }
                                      else
                                      {
                                        Fluttertoast.showToast(
                                            toastLength: Toast.LENGTH_SHORT,
                                            msg: "Please enter valid email",
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
                                text: controller.loaderRegister.isTrue?
                                CircularProgressIndicator(color: Colors.white,strokeWidth: 2,):Text(
                                  "Send".tr,
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
                                // controller.currentUser.value.phone_number =  null;
                                // controller.currentUser.value.password =  null;

                                // await   Get.toNamed(Routes.LOGIN);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));

                              },
                              child: Text("You already have an account?".tr),
                            ).paddingOnly(bottom: 10),
                            Obx(() {
                              if(controller.otpEnable.isTrue)
                                {
                                  return TextButton(
                                    onPressed: () async{
                                      controller.resendPhoneController.text = controller.phoneController.text;

                                      if(controller.phoneController.text.isNotEmpty && controller.resendPhoneController.text.isNotEmpty)
                                      {
                                        if(controller.phoneController.text.length == 10 && controller.resendPhoneController.text.length == 10)
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
                                    child: Text("Resend the OTP Code Again.".tr),
                                  ).paddingOnly(bottom: 10);

                                }
                              else
                                {
                                  return Container(height: 5,);
                                }
                              }
                            ),
                          ],
                        );

                      }
                  }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
