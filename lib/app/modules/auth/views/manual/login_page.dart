import 'package:bizmart/app/modules/auth/controllers/auth_controller.dart';
import 'package:bizmart/app/modules/auth/views/manual/forgetPassword_page.dart';
import 'package:bizmart/app/modules/auth/views/manual/regiser_page.dart';
import 'package:bizmart/app/modules/global_widgets/text_field_widget.dart';
import 'package:bizmart/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/helper.dart';
import '../../../../../common/ui.dart';
import '../../../global_widgets/block_button_widget.dart';
import '../forgot_password_view.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  AuthController controller = Get.put(AuthController());
  void initState()
  {
    super.initState();
    controller.phoneLoginController.clear();
    controller.loginPasswordController.clear();
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
            body: Form(
              key: controller.loginFormKey,
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
                          height: 250,
                          color: Get.theme.colorScheme.secondary,
                        ),
                      ),
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
                          border:
                          Border.all(width: 1, color: Colors.grey.shade300),
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
                      Positioned(
                          bottom: 180,
                          child: Text(
                            "Bizmart",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          )),
                      Positioned(
                          bottom: 120,
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )),
                    ],
                  ),
                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                          onSaved: (input) => controller.phoneLoginController.text = input,
                          onChanged: (input) => controller.phoneLoginController.text = input,

                          iconData: Icons.phone,
                          isFirst: false,
                          isLast: false,
                        ),
                        Obx(() {
                          return TextFieldWidget(
                            labelText: "Password".tr,
                            hintText: "Password".tr,
                            initialValue: controller.loginPasswordController.text,
                            onSaved: (input) => controller.loginPasswordController.text = input,
                            onChanged: (input) => controller.loginPasswordController.text = input,
                            // initialValue: controller.currentUser?.value?.password,
                            // onSaved: (input) => controller.currentUser.value.password = input,
                            validator: (input) => input.length < 3
                                ? "Should be more than 3 characters".tr
                                : null,
                            obscureText: controller.hidePassword.value,
                            iconData: Icons.lock_outline,
                            keyboardType: TextInputType.visiblePassword,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Get.toNamed(Routes.FORGOT_PASSWORD);
                                controller.loaderForgetVerify.value = false;
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordPage()));

                              },
                              child: Text("Forgot Password?".tr),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20),
                        BlockButtonWidget(
                          onPressed: () {
                            if(controller.phoneLoginController.text.isNotEmpty && controller.loginPasswordController.text.isNotEmpty)
                              {
                                if(controller.phoneLoginController.text.length == 10)
                                  {
                                    controller.login();

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
                            //controller.deviceToken();
                          },
                          color: Get.theme.colorScheme.secondary,
                          text: controller. loaderLogin.isTrue?
                          CircularProgressIndicator(color: Colors.white,strokeWidth: 2,):Text(
                            "Login".tr,
                            style: Get.textTheme.headline6.merge(
                                TextStyle(color: Get.theme.primaryColor)),
                          ),
                        ).paddingSymmetric(vertical: 10, horizontal: 20),
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
                        ).paddingSymmetric(vertical: 20),
                      ],
                    );

                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
