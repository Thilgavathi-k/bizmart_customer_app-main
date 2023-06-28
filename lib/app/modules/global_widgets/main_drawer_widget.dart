/*
 * Copyright (c) 2020 .
 */

import 'package:bizmart/app/models/business_details_get_api/all_categories_api.dart';
import 'package:bizmart/app/models/business_details_get_api/myservice_list.dart';
import 'package:bizmart/app/modules/auth/views/manual/login_page.dart';
import 'package:bizmart/app/modules/auth/views/manual/regiser_page.dart';
import 'package:bizmart/app/modules/business_create_form.dart';
import 'package:bizmart/app/modules/business_details_form.dart';
import 'package:bizmart/app/modules/enquiry_list_page.dart';
import 'package:bizmart/app/modules/my_services.dart';
import 'package:bizmart/app/modules/testedd.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../custom_pages/views/custom_page_drawer_link_widget.dart';
import '../root/controllers/root_controller.dart' show RootController;
import 'drawer_link_widget.dart';

class MainDrawerWidget extends StatefulWidget {
  @override
  State<MainDrawerWidget> createState() => _MainDrawerWidgetState();
}

class _MainDrawerWidgetState extends State<MainDrawerWidget> {
  @override
  List cat_list = [];
  String cat_id;
  var apiCall;
  bool catStatus = false;
  bool isFIrst = false;
  var catapi;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      apiCall = AllCategories().AllCategoriesData();
      AllCategories().AllCategoriesData().then((val)
      {
        cat_list = val['data'];
        int i =0;
        for(i=0; i<catapi.length;i++)
        {

          cat_list.add(catapi['data'][i]);

        }
        print("CAT LIST FROM FOR LOOP");
      //  print(catapi);
        print(cat_list);

      });



    });
  }

  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.colorScheme.secondary,
      child: SafeArea(
        child: Container(
          child: Drawer(
            child: ListView(
              children: [
                Obx(() {
                  if (!Get.find<AuthService>().isAuth) {
                    return GestureDetector(
                      onTap: () {
                        // Get.toNamed(Routes.LOGIN);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        decoration: BoxDecoration(
                          // color: Theme.of(context).hintColor.withOpacity(0.1),
                          color: Get.theme.colorScheme.secondary,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Welcome".tr,
                                style: Get.textTheme.headline5
                                    .merge(TextStyle(color: Colors.white))),
                            SizedBox(height: 5),
                            //  Text("Login account or create new one for free".tr, style: TextStyle(color: Colors.white)),
                            SizedBox(height: 15),
                            Wrap(
                              spacing: 10,
                              children: <Widget>[
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));

                                    // Get.toNamed(Routes.LOGIN);
                                  },
                                  //  color: Get.theme.colorScheme.secondary,
                                  color: Colors.white,
                                  height: 40,
                                  elevation: 0,
                                  child: Wrap(
                                    runAlignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 9,
                                    children: [
                                      Icon(Icons.exit_to_app_outlined,
                                          color:
                                              Get.theme.colorScheme.secondary,
                                          size: 24),
                                      Text(
                                        "Login".tr,
                                        style: Get.textTheme.subtitle1.merge(
                                            TextStyle(
                                                color: Get.theme.colorScheme
                                                    .secondary)),
                                      ),
                                    ],
                                  ),
                                  shape: StadiumBorder(),
                                ),
                                MaterialButton(
                                  color: Colors.white,
                                  height: 40,
                                  elevation: 0,
                                  onPressed: () {
                                    // Get.toNamed(Routes.REGISTER);
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                                  },
                                  child: Wrap(
                                    runAlignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 9,
                                    children: [
                                      Icon(Icons.person_add_outlined,
                                          color:
                                              Get.theme.colorScheme.secondary,
                                          size: 24),
                                      Text(
                                        "Register".tr,
                                        style: Get.textTheme.subtitle1.merge(
                                            TextStyle(
                                                color: Get.theme.colorScheme
                                                    .secondary)),
                                      ),
                                    ],
                                  ),
                                  shape: StadiumBorder(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () async {
                        // await Get.find<RootController>().changePage(3);
                      },
                      child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          // color: Theme.of(context).hintColor.withOpacity(0.1),
                          color: Get.theme.colorScheme.secondary,
                        ),
                        accountName: Text(
                          Get.find<AuthService>().user.value.name,
                          //  style: Theme.of(context).textTheme.headline6,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        accountEmail: Text(
                          Get.find<AuthService>().user.value.email,
                          //style: Theme.of(context).textTheme.caption,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        currentAccountPicture: Stack(
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                  imageUrl: Get.find<AuthService>().user.value.avatar.thumb,
                                  placeholder: (context, url) => Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(100)

                                      ),
                                      child: Center(child: Icon(Icons.person,color: Colors.black.withOpacity(0.4),size: 30,))
                                  ),
                                  //     Image.asset(
                                  //   'assets/img/loading.gif',
                                  //   fit: BoxFit.cover,
                                  //   height: 80,
                                  //   width: 80,
                                  // ),
                                  errorWidget: (context, url, error) => Container(
                                      height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100)
                                      
                                    ),
                                    child: Center(child: Icon(Icons.person,color: Colors.black.withOpacity(0.4),size: 30,))
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Get.find<AuthService>().user.value.verifiedPhone ?? false ? Icon(Icons.check_circle, color: Get.theme.colorScheme.secondary, size: 24) : SizedBox(),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }),
                SizedBox(height: 25,),
                DrawerLinkWidget(
                  icon: Icons.home_outlined,
                  text: "Home",
                  onTap: (e) async {
                    // Get.back();
                    Navigator.pop(context);
                    await Get.find<RootController>().changePage(0);
                  },
                ),
                SizedBox(height: 25,),
                DrawerLinkWidget(
                  icon: Icons.folder_special_outlined,
                  text: "Categories",
                  onTap: (e) async {
                     // Get.back();
                    Navigator.pop(context);

                    Get.find<RootController>().changePage(1);
                    // Get.offAndToNamed(Routes.CATEGORIES);
                  },
                ),
                SizedBox(height: 25,),
                Get.find<AuthService>().isAuth?Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print(
                            "********************INKWEL  DATA LIST START*******************");
                        print(catapi);
                        Navigator.push(context, MaterialPageRoute(builder: (Context) => BusinessDetailsData(cat_list: cat_list)));
                        print(
                            "********************INKWELL  DATA LIST END*******************");
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 20,),
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.upload_rounded,
                                color: Get.theme.focusColor,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 12),
                                width: 1,
                                height: 24,
                                color: Get.theme.focusColor.withOpacity(0.3),
                              ),
                              Expanded(
                                child: Text("Add Business Details".tr),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),
                    DrawerLinkWidget(
                      icon: Icons.person_outline,
                      text: "Profile",
                      onTap: (e) async {
                        // Get.toNamed(Routes.PROFILE);
                        //  Get.back();
                        Navigator.pop(context);
                        await Get.find<RootController>().changePage(3);
                      },
                    ),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap: () {
                        print(
                            "********************INKWEL  DATA LIST START*******************");
                        print(catapi);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyEnquirylist()));
                        print(
                            "********************INKWELL  DATA LIST END*******************");
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 20,),
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.note_add,
                                color: Get.theme.focusColor,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 12),
                                width: 1,
                                height: 24,
                                color: Get.theme.focusColor.withOpacity(0.3),
                              ),
                              Expanded(
                                child: Text("Enquiry List".tr),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Nyservices()));


                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 20,),
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.work,
                                color: Get.theme.focusColor,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 12),
                                width: 1,
                                height: 24,
                                color: Get.theme.focusColor.withOpacity(0.3),
                              ),
                              Expanded(
                                child: Text("My Services".tr),
                              ),
                              //  InkWell(
                              //   onTap: ()
                              //   {
                              //
                              //   },
                              //   child: Icon(
                              //     Icons.arrow_drop_down,
                              //     color: Get.theme.focusColor,
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),

                  ],
                ):Container(),

                // !Get.find<AuthService>().isAuth? Container(): InkWell(
                //   onTap: () {
                //     print(
                //         "********************INKWEL  DATA LIST START*******************");
                //     print(catapi);
                //     Navigator.push(context, MaterialPageRoute(builder: (Context) => BusinessDetailsData(cat_list: cat_list)));
                //     print(
                //         "********************INKWELL  DATA LIST END*******************");
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 20,),
                //     child: Container(
                //       child: Row(
                //         children: [
                //           Icon(
                //             Icons.upload_rounded,
                //             color: Get.theme.focusColor,
                //           ),
                //           Container(
                //             margin: EdgeInsets.symmetric(horizontal: 12),
                //             width: 1,
                //             height: 24,
                //             color: Get.theme.focusColor.withOpacity(0.3),
                //           ),
                //           Expanded(
                //             child: Text("Add business details".tr),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // !Get.find<AuthService>().isAuth?SizedBox(height: 20,):Container(),
                //
                // !Get.find<AuthService>().isAuth? Container():DrawerLinkWidget(
                //   icon: Icons.person_outline,
                //   text: "Profile",
                //   onTap: (e) async {
                //     // Get.toNamed(Routes.PROFILE);
                //     Get.back();
                //     await Get.find<RootController>().changePage(3);
                //   },
                // ),
                // !Get.find<AuthService>().isAuth?SizedBox(height: 20,):Container(),
                //
                // !Get.find<AuthService>().isAuth? Container():InkWell(
                //   onTap: () {
                //     print(
                //         "********************INKWEL  DATA LIST START*******************");
                //     print(catapi);
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>MyEnquirylist()));
                //     print(
                //         "********************INKWELL  DATA LIST END*******************");
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 20,),
                //     child: Container(
                //       child: Row(
                //         children: [
                //           Icon(
                //             Icons.note_add,
                //             color: Get.theme.focusColor,
                //           ),
                //           Container(
                //             margin: EdgeInsets.symmetric(horizontal: 12),
                //             width: 1,
                //             height: 24,
                //             color: Get.theme.focusColor.withOpacity(0.3),
                //           ),
                //           Expanded(
                //             child: Text("Enquiry list".tr),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // !Get.find<AuthService>().isAuth?SizedBox(height: 20,):Container(),
                //
                // !Get.find<AuthService>().isAuth? Container():isFIrst == true ? InkWell(
                //   onTap: () {
                //     print("STATUSSS");
                //     setState(() {
                //       catStatus = false;
                //       isFIrst = false;
                //       print(isFIrst);
                //
                //
                //     });
                //     //   }
                //
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 20,),
                //     child: Container(
                //       child: Row(
                //         children: [
                //           Icon(
                //             Icons.work,
                //             color: Get.theme.focusColor,
                //           ),
                //           Container(
                //             margin: EdgeInsets.symmetric(horizontal: 12),
                //             width: 1,
                //             height: 24,
                //             color: Get.theme.focusColor.withOpacity(0.3),
                //           ),
                //           Expanded(
                //             child: Text("My services".tr),
                //           ),
                //           isFIrst == true ?  InkWell(
                //             onTap: ()
                //             {
                //               setState(() {
                //                 catStatus = false;
                //                 isFIrst = false;
                //
                //               });
                //             },
                //             child: Icon(
                //               Icons.arrow_drop_down,
                //               color: Get.theme.focusColor,
                //             ),
                //           ):Container(),
                //         ],
                //       ),
                //     ),
                //   ),
                // ): InkWell(
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Nyservices()));
                //
                //
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 20,),
                //     child: Container(
                //       child: Row(
                //         children: [
                //           Icon(
                //             Icons.work,
                //             color: Get.theme.focusColor,
                //           ),
                //           Container(
                //             margin: EdgeInsets.symmetric(horizontal: 12),
                //             width: 1,
                //             height: 24,
                //             color: Get.theme.focusColor.withOpacity(0.3),
                //           ),
                //           Expanded(
                //             child: Text("My services".tr),
                //           ),
                //           //  InkWell(
                //           //   onTap: ()
                //           //   {
                //           //
                //           //   },
                //           //   child: Icon(
                //           //     Icons.arrow_drop_down,
                //           //     color: Get.theme.focusColor,
                //           //   ),
                //           // )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // !Get.find<AuthService>().isAuth?SizedBox(height: 20,):Container(),

                CustomPageDrawerLinkWidget(),
                SizedBox(height: 25,),

                Obx(() {
                  if (Get.find<AuthService>().isAuth) {
                    return DrawerLinkWidget(
                      icon: Icons.logout,
                      text: "Logout",
                      onTap: (e) async {


                        return  showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Logout'),
                            content: Text('Are you sure want  to logout?'),
                            actions:[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child:Text('No'),
                                  ),


                                  ElevatedButton(
                                    onPressed: ()
                                    async {
                                      Get.find<AuthService>().removeCurrentUser();
                                      Navigator.pop(context);
                                      Get.back();
                                      await Get.find<RootController>().changePage(0);
                                    },
                                    child:Text('Yes'),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        );
                        // await Get.find<AuthService>().removeCurrentUser();
                        // Get.back();
                        // await Get.find<RootController>().changePage(0);
                      },
                    );
                  } else {
                    return SizedBox(height: 0);
                  }
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
// catStatus == true? FutureBuilder(
//     future: Mysevice().Mysevicelist(),
//     builder: (ctx,snapshot)
//     {
//       if(snapshot.hasData)
//       {
//         return ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: snapshot.data['data'].length,
//             itemBuilder: (ctx,index)
//             {
//               String sid = snapshot.data['data'][index]['id'].toString();
//
//               return   Padding(
//                 padding:  EdgeInsets.only(left: 20.0,),
//                 child:    InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (Context) =>
//                                 BusinessDetails(cat_list: cat_list,sid:sid)));
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 25,top: 5),
//                     child: Container(
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.arrow_right,
//                             color: Colors.black,
//                           ),
//
//                           Expanded(
//                             child: Text(snapshot.data['data'][index]['name']['en'].toString()),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }
//         );
//
//
//       }
//       else
//       {
//         return Container();
//       }
//
//     }
// ): Container(),
