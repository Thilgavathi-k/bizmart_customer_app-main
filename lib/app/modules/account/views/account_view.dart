import 'dart:convert';

import 'package:bizmart/app/models/business_details_get_api/all_categories_api.dart';
import 'package:bizmart/app/modules/business_details_form.dart';
import 'package:bizmart/app/modules/service_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../common/ui.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../global_widgets/notifications_button_widget.dart';
import '../../root/controllers/root_controller.dart';
import '../controllers/account_controller.dart';
import '../widgets/account_link_widget.dart';

class AccountView extends GetView<AccountController> {
  @override

  Widget build(BuildContext context) {
    List cat_list = [];
    int index =0;

    var _currentUser = Get.find<AuthService>().user;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Account".tr,
            style: Get.textTheme.headline6.merge(TextStyle(color: context.theme.primaryColor)),
          ),
          centerTitle: true,
          backgroundColor: Get.theme.colorScheme.secondary,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Get.theme.primaryColor),
            onPressed: () => {Scaffold.of(context).openDrawer()},
          ),
          elevation: 0,
          actions: [
            NotificationsButtonWidget(
              iconColor: Get.theme.primaryColor,
              labelColor: Get.theme.hintColor,
            )
          ],
        ),
        body: ListView(
          primary: true,
          children: [
            Obx(() {
              return Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 150,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.secondary,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(color: Get.theme.focusColor.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 5)),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            _currentUser.value.name ?? '',
                            style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor)),
                          ),
                          SizedBox(height: 10),
                          Text(_currentUser.value.email ?? '', style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: Ui.getBoxDecoration(
                      radius: 14,
                      border: Border.all(width: 5, color: Get.theme.primaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        imageUrl: _currentUser.value.avatar?.thumb ?? '',
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.image_outlined,color: Colors.grey,size: 40,),
                      ),
                    ),
                  ),
                ],
              );
            }),
            // FutureBuilder(
            //     future: AllCategories().AllCategoriesData(),
            //     builder: (ctx,snapshot)
            //     {
            //       if(snapshot.hasData)
            //         {
            //
            //           return   ListView.builder(
            //             shrinkWrap: true,
            //               itemCount:snapshot.data['data'].length,
            //               itemBuilder: (Buildcontext, index)
            //               {
            //                   if(snapshot.data['data'] == null ||snapshot.data['data'].length == 0 )
            //                     {
            //                       return Container();
            //                     }
            //                   else
            //                     {
            //                       cat_list.add(snapshot.data['data'][index]);
            //                       print("********************CAT LIST*******************");
            //                       print(cat_list);
            //                       return Container(
            //                         //child: Center(child: Text(snapshot.data['data'][index]['name']['en'].toString())),
            //                       );
            //                     }
            //
            //               }
            //           );
            //         }
            //       else
            //         {
            //           return Container();
            //         }
            //
            //     }
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //   decoration: Ui.getBoxDecoration(),
            //   child: Column(
            //     children: [
            //       InkWell(
            //         onTap: ()
            //         {
            //           print("********************INKWEL  DATA LIST START*******************");
            //           print(cat_list);
            //           var data_list = cat_list;
            //         //  print(data_list);
            //           Navigator.push(context, MaterialPageRoute(builder: (Context)=>BusinessDetails(cat_list:cat_list)));
            //           print("********************INKWEL  DATA LIST END*******************");
            //
            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 15),
            //           child: Row(
            //             children: [
            //               Icon(Icons.upload_rounded, color: Get.theme.colorScheme.secondary),
            //               Container(
            //                 margin: EdgeInsets.symmetric(horizontal: 12),
            //                 width: 1,
            //                 height: 24,
            //                 color: Get.theme.focusColor.withOpacity(0.3),
            //               ),
            //               Expanded(
            //                 child: Text("Add business details".tr),
            //               ),
            //               Icon(
            //                 Icons.arrow_forward_ios,
            //                 size: 12,
            //                 color: Get.theme.focusColor,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //
            //       // InkWell(
            //       //   onTap: ()
            //       //   {
            //       //       Navigator.push(context, MaterialPageRoute(builder: (Context)=>BusinessDetails()));
            //       //   },
            //       //   child: Padding(
            //       //     padding: const EdgeInsets.symmetric(vertical: 15),
            //       //     child: Row(
            //       //       children: [
            //       //         Icon(Icons.edit, color: Get.theme.colorScheme.secondary),
            //       //         Container(
            //       //           margin: EdgeInsets.symmetric(horizontal: 12),
            //       //           width: 1,
            //       //           height: 24,
            //       //           color: Get.theme.focusColor.withOpacity(0.3),
            //       //         ),
            //       //         Expanded(
            //       //           child: Text(" Edit Service Detail".tr),
            //       //         ),
            //       //         Icon(
            //       //           Icons.arrow_forward_ios,
            //       //           size: 12,
            //       //           color: Get.theme.focusColor,
            //       //         ),
            //       //       ],
            //       //     ),
            //       //   ),
            //       // ),
            //       AccountLinkWidget(
            //         icon: Icon(Icons.person_outline, color: Get.theme.colorScheme.secondary),
            //         text: Text("Profile".tr),
            //         onTap: (e) {
            //           Get.toNamed(Routes.PROFILE);
            //         },
            //       ),
            //       // AccountLinkWidget(
            //       //   icon: Icon(Icons.assignment_outlined, color: Get.theme.colorScheme.secondary),
            //       //   text: Text("My Bookings".tr),
            //       //   onTap: (e) {
            //       //     Get.find<RootController>().changePage(1);
            //       //   },
            //       // ),
            //       AccountLinkWidget(
            //         icon: Icon(Icons.notifications_outlined, color: Get.theme.colorScheme.secondary),
            //         text: Text("Notifications".tr),
            //         onTap: (e) {
            //           Get.toNamed(Routes.NOTIFICATIONS);
            //         },
            //       ),
            //       // AccountLinkWidget(
            //       //   icon: Icon(Icons.chat_outlined, color: Get.theme.colorScheme.secondary),
            //       //   text: Text("Messages".tr),
            //       //   onTap: (e) {
            //       //     Get.find<RootController>().changePage(2);
            //       //   },
            //       // ),
            //     ],
            //   ),
            // ),
            // // Container(
            // //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            // //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            // //   decoration: Ui.getBoxDecoration(),
            // //   child: Column(
            // //     children: [
            // //       AccountLinkWidget(
            // //         icon: Icon(Icons.settings_outlined, color: Get.theme.colorScheme.secondary),
            // //         text: Text("Settings".tr),
            // //         onTap: (e) {
            // //           Get.toNamed(Routes.SETTINGS);
            // //         },
            // //       ),
            // //       // AccountLinkWidget(
            // //       //   icon: Icon(Icons.translate_outlined, color: Get.theme.colorScheme.secondary),
            // //       //   text: Text("Languages".tr),
            // //       //   onTap: (e) {
            // //       //     Get.toNamed(Routes.SETTINGS_LANGUAGE);
            // //       //   },
            // //       // ),
            // //       // AccountLinkWidget(
            // //       //   icon: Icon(Icons.brightness_6_outlined, color: Get.theme.colorScheme.secondary),
            // //       //   text: Text("Theme Mode".tr),
            // //       //   onTap: (e) {
            // //       //     Get.toNamed(Routes.SETTINGS_THEME_MODE);
            // //       //   },
            // //       // ),
            // //     ],
            // //   ),
            // // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //   decoration: Ui.getBoxDecoration(),
            //   child: Column(
            //     children: [
            //       AccountLinkWidget(
            //         icon: Icon(Icons.support_outlined, color: Get.theme.colorScheme.secondary),
            //         text: Text("Help & FAQ".tr),
            //         onTap: (e) {
            //           Get.toNamed(Routes.HELP);
            //         },
            //       ),
            //       AccountLinkWidget(
            //         icon: Icon(Icons.logout, color: Get.theme.colorScheme.secondary),
            //         text: Text("Logout".tr),
            //         onTap: (e) async {
            //           await Get.find<AuthService>().removeCurrentUser();
            //           Get.find<RootController>().changePage(0);
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ));
  }
}
