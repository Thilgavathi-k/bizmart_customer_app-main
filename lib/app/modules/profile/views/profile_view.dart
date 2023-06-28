import 'package:bizmart/app/models/media_model.dart';
import 'package:bizmart/app/modules/global_widgets/image_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/phone_field_widget.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final bool hideAppBar;

  ProfileView({this.hideAppBar = false}) {
    // controller.profileForm = new GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    controller.profileForm = new GlobalKey<FormState>();
    return Scaffold(
        appBar: hideAppBar ? null : AppBar(
                title: Text(
                  "Profile".tr,
                  style: context.textTheme.headline6,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.sort,
                      color: Get.theme.colorScheme.secondary),
                  onPressed: () => {Scaffold.of(context).openDrawer()},
                ),
                elevation: 0,
              ),
        // bottomNavigationBar: Container(
        //   padding: EdgeInsets.symmetric(vertical: 10),
        //   decoration: BoxDecoration(
        //     color: Get.theme.primaryColor,
        //     borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        //     boxShadow: [
        //       BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5)),
        //     ],
        //   ),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: MaterialButton(
        //           onPressed: () {
        //             controller.saveProfileForm();
        //           },
        //           padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //           color: Get.theme.colorScheme.secondary,
        //           child: Text("Save".tr, style: Get.textTheme.bodyText2.merge(TextStyle(color: Get.theme.primaryColor))),
        //           elevation: 0,
        //           highlightElevation: 0,
        //           hoverElevation: 0,
        //           focusElevation: 0,
        //         ),
        //       ),
        //       SizedBox(width: 10),
        //       MaterialButton(
        //         onPressed: () {
        //           controller.resetProfileForm();
        //         },
        //         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //         color: Get.theme.hintColor.withOpacity(0.1),
        //         child: Text("Reset".tr, style: Get.textTheme.bodyText2),
        //         elevation: 0,
        //         highlightElevation: 0,
        //         hoverElevation: 0,
        //         focusElevation: 0,
        //       ),
        //     ],
        //   ).paddingSymmetric(vertical: 10, horizontal: 20),
        // ),
        body: Form(
          key: controller.profileForm,
          child: ListView(
            primary: true,
            children: [
              Text("Profile details".tr, style: Get.textTheme.headline5)
                  .paddingOnly(top: 20, bottom: 10, right: 22, left: 22),
              Text("Change the following details and save them".tr,
                      style: Get.textTheme.caption)
                  .paddingSymmetric(horizontal: 22, vertical: 5),
              Obx(() {
                return ImageFieldWidget(
                  label: "Image".tr,
                  field: 'avatar',
                  tag: controller.profileForm.hashCode.toString(),
                  initialImage: controller.avatar.value,
                  uploadCompleted: (uuid) {
                    Get.log("---------------IMAGES UPLOAD COMPLETED++++++++++++++++++++++++++++++");
                    Get.log("${controller.avatar.value}");
                    Get.log("---------------IMAGES UPLOAD END++++++++++++++++++++++++++++++");

                    controller.avatar.value = new Media(id: uuid);
                  },
                  reset: (uuid) {
                    controller.avatar.value = new Media(thumb: controller.user.value.avatar.thumb);
                  },
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  children: [
                    Card(
                      elevation: 2,
                      child: TextFormField(
                        onSaved: (input) => controller.user.value.name = input,
                        validator: (input) => input.length < 3
                            ? "Should be more than 3 letters".tr
                            : null,
                        initialValue: controller.user.value.name,
                        decoration: InputDecoration(
                          // hintText: "Full Name".tr,
                          labelText: "Full Name".tr,
                          border: OutlineInputBorder(),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 2,
                      child: TextFormField(
                        onSaved: (input) => controller.user.value.email = input,
                        validator: (input) => !input.contains('@')
                            ? "Should be a valid email"
                            : null,
                        initialValue: controller.user.value.email,
                        decoration: InputDecoration(
                          // hintText: "Email",
                          labelText: "Email".tr,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),

              // TextFieldWidget(
              //   onSaved: (input) => controller.user.value.name = input,
              //   validator: (input) => input.length < 3
              //       ? "Should be more than 3 letters".tr
              //       : null,
              //   initialValue: controller.user.value.name,
              //   hintText: "Full Name".tr,
              //   labelText: "Full Name".tr,
              //   iconData: Icons.person_outline,
              // ),
              // TextFieldWidget(
              //   onSaved: (input) => controller.user.value.email = input,
              //   validator: (input) =>
              //       !input.contains('@') ? "Should be a valid email" : null,
              //   initialValue: controller.user.value.email,
              //   hintText: "Email",
              //   labelText: "Email".tr,
              //   iconData: Icons.alternate_email,
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Card(
                  elevation: 2,
                  child: PhoneFieldWidget(
                    labelText: "Phone Number".tr,
                    // hintText: "Phone Number".tr,
                    initialCountryCode:
                        controller.user.value.getPhoneNumber()?.countryISOCode,
                    initialValue:
                        controller.user.value.getPhoneNumber()?.number,
                    onSaved: (phone) {
                      return controller.user.value.phoneNumber =
                          phone.completeNumber;
                    },
                    // suffix: controller.user.value.verifiedPhone
                    //     ? Text(
                    //   "Verified".tr,
                    //   style: Get.textTheme.caption.merge(TextStyle(color: Colors.green)),
                    // )
                    //     : Text(
                    //   "Not Verified".tr,
                    //   style: Get.textTheme.caption.merge(TextStyle(color: Colors.redAccent)),
                    // ),
                  ),
                ),
              ),
              // TextFieldWidget(
              //   onSaved: (input) => controller.user.value.address = input,
              //   validator: (input) => input.length < 3 ? "Should be more than 3 letters".tr : null,
              //   initialValue: controller.user.value.address,
              //   hintText: " Street, City , State, Country".tr,
              //   labelText: "Address".tr,
              //   iconData: Icons.map_outlined,
              // ),
              // TextFieldWidget(
              //   onSaved: (input) => controller.user.value.bio = input,
              //   initialValue: controller.user.value.bio,
              //   hintText: "Your short biography here".tr,
              //   labelText: "Short Biography".tr,
              //   iconData: Icons.article_outlined,
              // ),
              Text("Change password".tr, style: Get.textTheme.headline5)
                  .paddingOnly(top: 20, bottom: 10, right: 22, left: 22),
              // Text(
              //         "Fill your old password and type new password and confirm it"
              //             .tr,
              //         style: Get.textTheme.caption)
              //     .paddingSymmetric(horizontal: 22, vertical: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  children: [
                    Obx(() {
                      return Card(
                        elevation: 2,
                        child: TextFormField(
                          onSaved: (input) =>
                              controller.oldPassword.value = input,
                          onChanged: (input) =>
                              controller.oldPassword.value = input,
                          validator: (input) =>
                              input.length > 0 && input.length < 3
                                  ? "Should be more than 3 letters".tr
                                  : null,
                          initialValue: controller.oldPassword.value,
                          obscureText: controller.hidePassword.value,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            // hintText: "Old Password".tr,
                            labelText: "Old Password".tr,
                            border: OutlineInputBorder(),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.key,
                            ),
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
                        ),
                      );
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      return Card(
                        elevation: 2,
                        child: TextFormField(
                          onSaved: (input) =>
                              controller.newPassword.value = input,
                          onChanged: (input) =>
                              controller.newPassword.value = input,
                          validator: (input) {
                            if (input.length > 0 && input.length < 3) {
                              return "Should be more than 3 letters".tr;
                            } else if (input !=
                                controller.confirmPassword.value) {
                              return "Passwords do not match".tr;
                            } else {
                              return null;
                            }
                          },
                          initialValue: controller.newPassword.value,
                          obscureText: controller.hidePassword.value,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            // hintText: "New Password".tr,
                            labelText: "New Password".tr,
                            border: OutlineInputBorder(),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.key,
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      return Card(
                        elevation: 2,
                        child: TextFormField(
                          onSaved: (input) =>
                              controller.confirmPassword.value = input,
                          onChanged: (input) =>
                              controller.confirmPassword.value = input,
                          validator: (input) {
                            if (input.length > 0 && input.length < 3) {
                              return "Should be more than 3 letters".tr;
                            } else if (input != controller.newPassword.value) {
                              return "Passwords do not match".tr;
                            } else {
                              return null;
                            }
                          },
                          initialValue: controller.confirmPassword.value,
                          obscureText: controller.hidePassword.value,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            // hintText: "Confirm New Password".tr,
                            labelText: "Confirm New Password".tr,
                            border: OutlineInputBorder(),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.key,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              // Obx(() {
              //   // TODO verify old password
              //   return TextFieldWidget(
              //     labelText: "Old Password".tr,
              //     hintText: "Old Password".tr,
              //     onSaved: (input) => controller.oldPassword.value = input,
              //     onChanged: (input) => controller.oldPassword.value = input,
              //     validator: (input) => input.length > 0 && input.length < 3
              //         ? "Should be more than 3 letters".tr
              //         : null,
              //     initialValue: controller.oldPassword.value,
              //     obscureText: controller.hidePassword.value,
              //     iconData: Icons.lock_outline,
              //     keyboardType: TextInputType.visiblePassword,
              //     suffixIcon: IconButton(
              //       onPressed: () {
              //         controller.hidePassword.value =
              //             !controller.hidePassword.value;
              //       },
              //       color: Theme.of(context).focusColor,
              //       icon: Icon(controller.hidePassword.value
              //           ? Icons.visibility_off_outlined
              //           : Icons.visibility_outlined),
              //     ),
              //     isFirst: true,
              //     isLast: false,
              //   );
              // }),
              // SizedBox(
              //   height: 8,
              // ),
              // Obx(() {
              //   return TextFieldWidget(
              //     labelText: "New Password".tr,
              //     hintText: "New Password".tr,
              //     onSaved: (input) => controller.newPassword.value = input,
              //     onChanged: (input) => controller.newPassword.value = input,
              //     validator: (input) {
              //       if (input.length > 0 && input.length < 3) {
              //         return "Should be more than 3 letters".tr;
              //       } else if (input != controller.confirmPassword.value) {
              //         return "Passwords do not match".tr;
              //       } else {
              //         return null;
              //       }
              //     },
              //     initialValue: controller.newPassword.value,
              //     obscureText: controller.hidePassword.value,
              //     iconData: Icons.lock_outline,
              //     keyboardType: TextInputType.visiblePassword,
              //     isFirst: false,
              //     isLast: false,
              //   );
              // }),
              // SizedBox(
              //   height: 8,
              // ),
              // Obx(() {
              //   return TextFieldWidget(
              //     labelText: "Confirm New Password".tr,
              //     hintText: "Confirm New Password".tr,
              //     onSaved: (input) => controller.confirmPassword.value = input,
              //     onChanged: (input) =>
              //         controller.confirmPassword.value = input,
              //     validator: (input) {
              //       if (input.length > 0 && input.length < 3) {
              //         return "Should be more than 3 letters".tr;
              //       } else if (input != controller.newPassword.value) {
              //         return "Passwords do not match".tr;
              //       } else {
              //         return null;
              //       }
              //     },
              //     initialValue: controller.confirmPassword.value,
              //     obscureText: controller.hidePassword.value,
              //     iconData: Icons.lock_outline,
              //     keyboardType: TextInputType.visiblePassword,
              //     isFirst: false,
              //     isLast: true,
              //   );
              // }),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                // decoration: BoxDecoration(
                //   color: Get.theme.primaryColor,
                //   borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(20),
                //       topRight: Radius.circular(20)),
                //   boxShadow: [
                //     BoxShadow(
                //         color: Get.theme.focusColor.withOpacity(0.1),
                //         blurRadius: 10,
                //         offset: Offset(0, -5)),
                //   ],
                // ),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          controller.saveProfileForm();
                        },
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Get.theme.colorScheme.secondary,
                        child: Text("Save".tr,
                            style: Get.textTheme.bodyText2.merge(
                                TextStyle(color: Get.theme.primaryColor))),
                        elevation: 0,
                        highlightElevation: 0,
                        hoverElevation: 0,
                        focusElevation: 0,
                      ),
                    ),
                    SizedBox(width: 10),
                    MaterialButton(
                      onPressed: () {
                        controller.resetProfileForm();
                      },
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Get.theme.hintColor.withOpacity(0.1),
                      child: Text("Reset".tr, style: Get.textTheme.bodyText2),
                      elevation: 0,
                      highlightElevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                    ),
                  ],
                ).paddingSymmetric(vertical: 10, horizontal: 20),
              ),
            ],
          ),
        ));
  }
}
