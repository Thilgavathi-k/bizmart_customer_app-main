// import 'dart:io';
// import 'dart:math';
//
// import 'package:bizmart/app/models/business_details_get_api/address_get_api.dart';
// import 'package:bizmart/app/models/business_details_get_api/business_details.dart';
// import 'package:bizmart/app/models/business_details_get_api/get_vakue.dart';
// import 'package:bizmart/app/models/business_details_get_api/gst_detail_get.dart';
// import 'package:bizmart/app/models/business_details_get_api/service_list_get_api.dart';
// import 'package:bizmart/app/modules/file_download.dart';
// import 'package:bizmart/app/modules/global_widgets/home_search_bar_widget.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_file_downloader/flutter_file_downloader.dart';
// import 'package:get/get.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../../../common/ui.dart';
// import '../../../models/e_service_model.dart';
// import '../../../models/media_model.dart';
// import '../../../providers/laravel_provider.dart';
// import '../../../routes/app_routes.dart';
// import '../../../services/auth_service.dart';
// import '../../global_widgets/block_button_widget.dart';
// import '../../global_widgets/circular_loading_widget.dart';
// import '../controllers/e_service_controller.dart';
// import '../widgets/e_provider_item_widget.dart';
// import '../widgets/e_service_til_widget.dart';
// import '../widgets/e_service_title_bar_widget.dart';
// import '../widgets/option_group_item_widget.dart';
// import '../widgets/review_item_widget.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
//
// class EServiceView extends GetView<EServiceController> {
//   @override
//   var desc;
//   var name;
//   var flink;
//   var ylink;
//   var linkedin;
//   var Name;
//   var email;
//   var yahoo;
//   var instalink;
//   var phone_number;
//   var whatsapp_number;
//   String video;
//   Barcode result;
//
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Widget build(BuildContext context) {
//     return Obx(() {
//       var _eService = controller.eService.value;
//       if (!_eService.hasData) {
//         return Scaffold(
//           body: CircularLoadingWidget(height: Get.height),
//         );
//       } else {
//         print("+++++++++++++++++++++++VIDEO PLAYER++++++++++++++++++++++++++");
//         print(_eService.videoPlayerController);
//         print(_eService.qrcontroller);
//         return Scaffold(
//           backgroundColor: Color(0xfff7f9fc),
//           bottomNavigationBar: buildBottomWidget(_eService),
//           body: RefreshIndicator(
//               onRefresh: () async {
//                 Get.find<LaravelApiClient>().forceRefresh();
//                 controller.refreshEService(showMessage: true);
//                 Get.find<LaravelApiClient>().unForceRefresh();
//               },
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Obx(() {
//                       return Stack(
//                         alignment: AlignmentDirectional.bottomCenter,
//                         children: <Widget>[
//                           buildCarouselSlider(_eService),
//                         //  buildCarouselBullets(_eService),
//                           Positioned(
//                             bottom:170,
//                             child: Padding(
//                               padding:  EdgeInsets.all(10.0),
//                               child: Container(
//                                 width:800,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//
//                                   // mainAxisAlignment:MainAxisAlignment.spacebetween
//                                   children: [
//                                     InkWell(
//                                       onTap: ()=>{Get.back()},
//                                       child: Container(
//                                         height: 40,
//                                         width: 40,
//                                         padding: EdgeInsets.all(3),
//                                         decoration: BoxDecoration(
//                                             color: Colors.black.withOpacity(0.4),
//                                             borderRadius: BorderRadius.circular(100)
//                                         ),
//                                         child: Icon(Icons.arrow_left, color: Colors.white,size: 35,)
//                                       ),
//                                     ),
//                                     // IconButton(
//                                     //   icon: CircleAvatar(
//                                     //     radius: 190,
//                                     //     backgroundColor:  Colors.black.withOpacity(0.4),
//                                     //     child:
//                                     //   ),
//                                     //   onPressed: () => {Get.back()},
//                                     // ),
//                                     InkWell(
//                                       onTap: ()
//                                       {
//                                         Get.toNamed(Routes.SEARCH, arguments: controller.heroTag.value);
//
//                                       },
//                                       child:CircleAvatar(
//                                         backgroundColor:  Colors.black.withOpacity(0.3),
//                                         // height: 30,
//                                         // width: 30,
//                                         // padding: EdgeInsets.all(5),
//                                         // decoration: BoxDecoration(
//                                         //     color: Colors.black.withOpacity(0.3),
//                                         //     borderRadius: BorderRadius.circular(100)
//                                         // ),
//                                         child: Center(
//                                           child: Container(
//                                               height: 20,
//                                               width: 20,
//                                               // height: 10,width: 30,
//
//                                               child: Center(child: Image.asset('assets/img/search.png',height: 25,width: 25,))),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       );
//                     }),
//                     // CustomScrollView(
//                     //   primary: true,
//                     //   shrinkWrap: false,
//                     //   slivers: <Widget>[
//                     //     SliverAppBar(
//                     //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                     //       expandedHeight: 250,
//                     //       elevation: 0,
//                     //       floating: true,
//                     //       iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
//                     //       centerTitle: true,
//                     //       automaticallyImplyLeading: false,
//                     //       leading: new IconButton(
//                     //         icon: CircleAvatar(
//                     //           backgroundColor:  Colors.black.withOpacity(0.4),
//                     //           child: Padding(
//                     //               padding: EdgeInsets.only(left: 10),
//                     //               child: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor)),
//                     //         ),
//                     //         onPressed: () => {Get.back()},
//                     //       ),
//                     //       actions: [InkWell(
//                     //         onTap: ()
//                     //         {
//                     //           Get.toNamed(Routes.SEARCH, arguments: controller.heroTag.value);
//                     //
//                     //         },
//                     //         child:CircleAvatar(
//                     //           backgroundColor:  Colors.black.withOpacity(0.3),
//                     //           // height: 30,
//                     //           // width: 30,
//                     //           // padding: EdgeInsets.all(5),
//                     //           // decoration: BoxDecoration(
//                     //           //     color: Colors.black.withOpacity(0.3),
//                     //           //     borderRadius: BorderRadius.circular(100)
//                     //           // ),
//                     //           child: Center(
//                     //             child: Container(
//                     //                 height: 20,
//                     //                 width: 20,
//                     //                 // height: 10,width: 30,
//                     //
//                     //                 child: Center(child: Image.asset('assets/img/search.png',height: 25,width: 25,))),
//                     //           ),
//                     //         ),
//                     //       ),],
//                     //       // actions: [new IconButton(
//                     //       //     icon: Container(
//                     //       //       decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
//                     //       //         BoxShadow(
//                     //       //           color: Get.theme.primaryColor.withOpacity(0.5),
//                     //       //           blurRadius: 20,
//                     //       //         ),
//                     //       //       ]),
//                     //       //       child: (_eService?.isFavorite ?? false) ? Icon(Icons.favorite, color: Colors.redAccent) : Icon(Icons.favorite_outline, color: Get.theme.hintColor),
//                     //       //     ),
//                     //       //     onPressed: () {
//                     //       //       if (!Get.find<AuthService>().isAuth) {
//                     //       //         Get.toNamed(Routes.LOGIN);
//                     //       //       } else {
//                     //       //         if (_eService?.isFavorite ?? false) {
//                     //       //           controller.removeFromFavorite();
//                     //       //         } else {
//                     //       //           controller.addToFavorite();
//                     //       //         }
//                     //       //       }
//                     //       //     },
//                     //       //   ).marginSymmetric(horizontal: 10),],
//                     //       //  bottom: buildEServiceTitleBarWidget(_eService),
//                     //       flexibleSpace: FlexibleSpaceBar(
//                     //         collapseMode: CollapseMode.parallax,
//                     //         background: Obx(() {
//                     //           return Stack(
//                     //             alignment: AlignmentDirectional.bottomCenter,
//                     //             children: <Widget>[
//                     //               buildCarouselSlider(_eService),
//                     //               buildCarouselBullets(_eService),
//                     //             ],
//                     //           );
//                     //         }),
//                     //       ).marginOnly(bottom: 50),
//                     //     ),
//                     //
//                     //
//                     //     // WelcomeWidget(),
//                     //     // SliverToBoxAdapter(
//                     //     //   child: Column(
//                     //     //     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     //     //     children: [
//                     //     //       buildEServiceTitleBarWidget(_eService),
//                     //     //       SizedBox(height: 10),
//                     //     //       buildCategories(_eService),
//                     //     //       EServiceTilWidget(
//                     //     //         title: Text("Description".tr, style: Get.textTheme.subtitle2),
//                     //     //         content: Obx(() {
//                     //     //           if (controller.eService.value.description == '') {
//                     //     //             return SizedBox();
//                     //     //           }
//                     //     //           return Ui.applyHtml(_eService.description, style: Get.textTheme.bodyText1);
//                     //     //         }),
//                     //     //       ),
//                     //     //       buildDuration(_eService),
//                     //     //       buildOptions(_eService),
//                     //     //       buildServiceProvider(_eService),
//                     //     //       if (_eService.images.isNotEmpty)
//                     //     //         EServiceTilWidget(
//                     //     //           horizontalPadding: 0,
//                     //     //           title: Text("Galleries".tr, style: Get.textTheme.subtitle2).paddingSymmetric(horizontal: 20),
//                     //     //           content: Container(
//                     //     //             height: 120,
//                     //     //             child: ListView.builder(
//                     //     //                 primary: false,
//                     //     //                 shrinkWrap: false,
//                     //     //                 scrollDirection: Axis.horizontal,
//                     //     //                 itemCount: _eService.images.length,
//                     //     //                 itemBuilder: (_, index) {
//                     //     //                   var _media = _eService.images.elementAt(index);
//                     //     //                   return InkWell(
//                     //     //                     onTap: () {
//                     //     //                       Get.toNamed(Routes.GALLERY, arguments: {'media': _eService.images, 'current': _media, 'heroTag': 'e_services_galleries'});
//                     //     //                     },
//                     //     //                     child: Container(
//                     //     //                       width: 100,
//                     //     //                       height: 100,
//                     //     //                       margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 10, bottom: 10),
//                     //     //                       child: Stack(
//                     //     //                         alignment: AlignmentDirectional.topStart,
//                     //     //                         children: [
//                     //     //                           Hero(
//                     //     //                             tag: 'e_services_galleries' + (_media?.id ?? ''),
//                     //     //                             child: ClipRRect(
//                     //     //                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                     //     //                               child: CachedNetworkImage(
//                     //     //                                 height: 100,
//                     //     //                                 width: double.infinity,
//                     //     //                                 fit: BoxFit.cover,
//                     //     //                                 imageUrl: _media.thumb,
//                     //     //                                 placeholder: (context, url) => Image.asset(
//                     //     //                                   'assets/img/loading.gif',
//                     //     //                                   fit: BoxFit.cover,
//                     //     //                                   width: double.infinity,
//                     //     //                                   height: 100,
//                     //     //                                 ),
//                     //     //                                 errorWidget: (context, url, error) => Icon(Icons.error_outline),
//                     //     //                               ),
//                     //     //                             ),
//                     //     //                           ),
//                     //     //                           Padding(
//                     //     //                             padding: const EdgeInsetsDirectional.only(start: 12, top: 8),
//                     //     //                             child: Text(
//                     //     //                               _media.name ?? '',
//                     //     //                               maxLines: 2,
//                     //     //                               style: Get.textTheme.bodyText2.merge(TextStyle(
//                     //     //                                 color: Get.theme.primaryColor,
//                     //     //                                 shadows: <Shadow>[
//                     //     //                                   Shadow(
//                     //     //                                     offset: Offset(0, 1),
//                     //     //                                     blurRadius: 6.0,
//                     //     //                                     color: Get.theme.hintColor.withOpacity(0.6),
//                     //     //                                   ),
//                     //     //                                 ],
//                     //     //                               )),
//                     //     //                             ),
//                     //     //                           ),
//                     //     //                         ],
//                     //     //                       ),
//                     //     //                     ),
//                     //     //                   );
//                     //     //                 }),
//                     //     //           ),
//                     //     //           actions: [
//                     //     //             // TODO View all galleries
//                     //     //           ],
//                     //     //         ),
//                     //     //       EServiceTilWidget(
//                     //     //         title: Text("Reviews & Ratings".tr, style: Get.textTheme.subtitle2),
//                     //     //         content: Column(
//                     //     //           children: [
//                     //     //             Text(_eService.rate.toString(), style: Get.textTheme.headline1),
//                     //     //             Wrap(
//                     //     //               children: Ui.getStarsList(_eService.rate, size: 32),
//                     //     //             ),
//                     //     //             Text(
//                     //     //               "Reviews (%s)".trArgs([_eService.totalReviews.toString()]),
//                     //     //               style: Get.textTheme.caption,
//                     //     //             ).paddingOnly(top: 10),
//                     //     //             Divider(height: 35, thickness: 1.3),
//                     //     //             Obx(() {
//                     //     //               if (controller.reviews.isEmpty) {
//                     //     //                 return CircularLoadingWidget(height: 100);
//                     //     //               }
//                     //     //               return ListView.separated(
//                     //     //                 padding: EdgeInsets.all(0),
//                     //     //                 itemBuilder: (context, index) {
//                     //     //                   return ReviewItemWidget(review: controller.reviews.elementAt(index));
//                     //     //                 },
//                     //     //                 separatorBuilder: (context, index) {
//                     //     //                   return Divider(height: 35, thickness: 1.3);
//                     //     //                 },
//                     //     //                 itemCount: controller.reviews.length,
//                     //     //                 primary: false,
//                     //     //                 shrinkWrap: true,
//                     //     //               );
//                     //     //             }),
//                     //     //           ],
//                     //     //         ),
//                     //     //         actions: [
//                     //     //           // TODO view all reviews
//                     //     //         ],
//                     //     //       ),
//                     //     //     ],
//                     //     //   ),
//                     //     // ),
//                     //   ],
//                     // ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Padding(
//                           padding:  EdgeInsets.all(15.0),
//                           child: Container(
//                             width: 200,
//                             child:
//                             Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(_eService.name,style: TextStyle(fontSize: 18),),
//                                     Text("₹ "+_eService.getPrice.toString(),style: TextStyle(fontSize: 18),),
//
//                                   ],
//                                 ),
//                                 SizedBox(height: 10,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Unit price"),
//                                     Text(_eService.priceUnit),
//                                   ],
//                                 ),  SizedBox(height: 10,),
//
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Duration"),
//                                     Text(_eService.duration),
//                                   ],
//                                 ),
//                                 SizedBox(height: 10,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Discount price"),
//                                     Text("₹ "+_eService.discountPrice.toString()),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//
//
//                         SizedBox(height: 10,),
//                         //buildCategories(_eService),
//                         //++++++++++++++++++++++Address++++++++++++++++++++++++++++++++++++
//
//                         Padding(
//                           padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                           child: Text("Address",style: TextStyle(color: Colors.black,fontSize: 16),),
//                         ),
//
//                         FutureBuilder(
//                             future: AddressData().AddressDataList(_eService.id),
//                             builder: (ctx,snapshot)
//                                 {
//                                   if(snapshot.hasData)
//                                     {
//                                       if(snapshot.data['data'] == null || snapshot.data['data'].length ==0)
//                                         {
//                                           return Padding(
//                                             padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                             child: Container(
//                                               height: 200,
//                                               padding: EdgeInsets.all(10),
//                                               decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   border: Border.all(
//                                                     color: Colors.grey.shade200,
//
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(10)
//                                               ),
//                                             ),
//                                           );
//                                         }
//                                       else
//                                         {
//                                           return Padding(
//                                             padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                             child: Container(
//                                                 height: 200,
//                                                 padding: EdgeInsets.all(10),
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     border: Border.all(
//                                                       color: Colors.grey.shade200,
//
//                                                     ),
//                                                     borderRadius: BorderRadius.circular(10)
//                                                 ),
//                                                 child: Column(
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                   children: [
//                                                     Container(
//                                                       // height: 35,
//
//                                                       child: Flexible(child: Text(snapshot.data['data']['company_name'].toString(),
//                                                         style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 20),
//                                                         maxLines: 1,
//                                                         overflow: TextOverflow.ellipsis,
//                                                       )),
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         Icon(Icons.location_on,size: 20,),
//                                                         SizedBox(width: 5,),
//
//                                                         Flexible(child: Text(snapshot.data['data']['address'].toString()+","+snapshot.data['data']['district'].toString()+","+snapshot.data['data']['city'].toString()+","+snapshot.data['data']['pincode'].toString(),
//                                                           style: TextStyle(color: Get.theme.colorScheme.secondary),
//                                                           maxLines: 1,
//                                                           overflow: TextOverflow.ellipsis,
//                                                         )),
//                                                       ],
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         Icon(Icons.location_on,size: 20,),
//                                                         SizedBox(width: 5,),
//
//                                                         Text(snapshot.data['data']['landmark'].toString(), style: TextStyle(color:Get.theme.colorScheme.secondary)),
//                                                       ],
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         Icon(Icons.phone,size: 20,),
//                                                         SizedBox(width: 5,),
//
//                                                         Text(snapshot.data['data']['mobile_number'].toString(), style: TextStyle(color: Get.theme.colorScheme.secondary)),
//                                                       ],
//                                                     ),
//
//                                                   ],
//                                                 )
//
//                                             ),
//                                           );
//
//                                         }
//                                     }
//                                   else
//                                     {
//                                       return Padding(
//                                         padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                         child: Container(
//                                           height: 200,
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               border: Border.all(
//                                                 color: Colors.grey.shade200,
//
//                                               ),
//                                               borderRadius: BorderRadius.circular(10)
//                                           ),
//                                         ),
//                                       );
//                                     }
//
//                                 }
//                         ),
//                         Padding(
//                           padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                           child: Text("Business Details",style: TextStyle(color: Colors.black,fontSize: 16),),
//                         ),
//                         FutureBuilder(
//                             future: BusinessDetailsGet().BusinessDetailsGetData(_eService.id),
//                             builder: (ctx,snapshot)
//                             {
//                               if(snapshot.hasData)
//                               {
//                                 if(snapshot.data['data'] == null || snapshot.data['data'].length == 0)
//                                   {
//                                     return Padding(
//                                       padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                       child: Container(
//                                         height: 160,
//                                         padding: EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             border: Border.all(
//                                               color: Colors.grey.shade200,
//
//                                             ),
//                                             borderRadius: BorderRadius.circular(10)
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                 else
//                                   {
//
//                                     return Padding(
//                                       padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                       child: Container(
//                                           height: 160,
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               border: Border.all(
//                                                 color: Colors.grey.shade200,
//
//                                               ),
//                                               borderRadius: BorderRadius.circular(10)
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                             children: [
//
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                                                 children: [
//                                                   Text("Awards:"),
//                                                   Flexible(child: Text(snapshot.data['data']['add_awards'].toString(),
//                                                     style: TextStyle(color: Get.theme.colorScheme.secondary),
//                                                     maxLines: 1,
//                                                     overflow: TextOverflow.ellipsis,
//                                                   )),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                                                 children: [
//                                                   Text("Establiment:"),
//                                                   Text(snapshot.data['data']['add_your_establishment'].toString(), style: TextStyle(color:Get.theme.colorScheme.secondary)),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                                                 children: [
//                                                   Text("Payment method:"),
//                                                   Text(snapshot.data['data']['payment_method'].toString(), style: TextStyle(color: Get.theme.colorScheme.secondary)),
//                                                 ],
//                                               ),
//
//                                             ],
//                                           )
//
//                                       ),
//                                     );
//                                   }
//                               }
//                               else
//                               {
//                                 return Padding(
//                                   padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                   child: Container(
//                                     height: 160,
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         border: Border.all(
//                                           color: Colors.grey.shade200,
//
//                                         ),
//                                         borderRadius: BorderRadius.circular(10)
//                                     ),
//                                   ),
//                                 );
//                               }
//
//                             }
//                         ),
//                         FutureBuilder(
//                             future: GstDetailsGet().GstDetailsGetData(_eService.id),
//                             builder: (ctx,snapshot)
//                             {
//                               if(snapshot.hasData)
//                               {
//                                 if(snapshot.data['data'] ==  null || snapshot.data['data'].length == 0)
//                                   {
//                                     return Padding(
//                                       padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                       child: Container(
//                                         height: 60,
//                                         padding: EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             border: Border.all(
//                                               color: Colors.grey.shade200,
//
//                                             ),
//                                             borderRadius: BorderRadius.circular(10)
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                 else
//                                   {
//                                     return Padding(
//                                       padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                       child: Container(
//                                           height: 60,
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               border: Border.all(
//                                                 color: Colors.grey.shade200,
//
//                                               ),
//                                               borderRadius: BorderRadius.circular(10)
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Text("GST No:",style: TextStyle(color: Colors.black,fontSize: 14),),
//                                                   SizedBox(width: 5,),
//                                                   Text(snapshot.data['data']['gst_no_uin_of_registered'],style: TextStyle(color: Colors.black,fontSize: 14),),
//                                                 ],
//                                               ),
//
//                                             ],
//                                           )
//
//                                       ),
//                                     );
//
//                                   }
//                               }
//                               else
//                               {
//                                 return Padding(
//                                   padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                   child: Container(
//                                     height: 60,
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         border: Border.all(
//                                           color: Colors.grey.shade200,
//
//                                         ),
//                                         borderRadius: BorderRadius.circular(10)
//                                     ),
//                                   ),
//                                 );
//                               }
//
//                             }
//                         ),
//                         SizedBox(height: 15,),
//                         Padding(
//                           padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                           child: Text("Certificates",style: TextStyle(color: Colors.black,fontSize: 16),),
//                         ),
//                         // InkWell(
//                         //   onTap: ()
//                         //   {
//                         //     Navigator.push(context,MaterialPageRoute(builder: (context)=>FileDownload()));
//                         //   },
//                         //   child: Container(
//                         //     height: 50,
//                         //     width: 400,
//                         //     color: Colors.green,
//                         //     child: Text("click"),
//                         //   ),
//                         // ),
//                         FutureBuilder(
//                             future: BusinessDetailsGet().BusinessDetailsGetData(_eService.id),
//                             builder: (ctx,snapshot)
//                             {
//                               if(snapshot.hasData)
//                               {
//                                 if(snapshot.data['data'] ==  null || snapshot.data['data'].length == 0)
//                                 {
//                                   return Padding(
//                                     padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                     child: Container(
//                                       height: 60,
//                                       padding: EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           border: Border.all(
//                                             color: Colors.grey.shade200,
//
//                                           ),
//                                           borderRadius: BorderRadius.circular(10)
//                                       ),
//                                     ),
//                                   );
//                                 }
//                                 else
//                                 {
//                                    var download;
//                                   return Padding(
//                                     padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                     child: InkWell(
//                                       onTap: () async{
//                                         final List<File> result = await FileDownloader.downloadFiles(
//                                             urls: [
//                                               snapshot.data['data']['add_certificate'].toString()
//                                             ],
//                                             isParallel: false);
//                                         print('FILES: ${result.map((e) => e?.path).join(',\n')}');
//                                         download = result.map((e) => e?.path.toString());
//                                         print("++++++++++++++++++++++++DOWNLOAD+++++++++++++++DATA+++++++++++++++++++++++++++++++++");
//                                         print(download);
//                                       },
//                                       child: Container(
//                                           height: 140,
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               border: Border.all(
//                                                 color: Colors.grey.shade200,
//
//                                               ),
//                                               borderRadius: BorderRadius.circular(10)
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Icon(Icons.download),
//                                                   SizedBox(width: 10,),
//                                                   Flexible(child: Text(snapshot.data['data']['add_certificate'].toString(),style: TextStyle(color: Colors.black,fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,)),
//                                                 ],
//                                               ),
//                                               download == snapshot.data['data']['add_certificate'].toString() ?
//                                               Row(
//                                                 children: [
//                                                   Icon(Icons.check,color: Colors.green,),
//                                                   SizedBox(width: 10,),
//                                                   Flexible(child: Text("Downloaded".toString(),style: TextStyle(color: Colors.black,fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,)),
//                                                 ],
//                                               ):Container(),
//
//
//                                             ],
//                                           )
//
//                                       ),
//                                     ),
//                                   );
//
//                                 }
//                               }
//                               else
//                               {
//                                 return Padding(
//                                   padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                                   child: Container(
//                                     height: 60,
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         border: Border.all(
//                                           color: Colors.grey.shade200,
//
//                                         ),
//                                         borderRadius: BorderRadius.circular(10)
//                                     ),
//                                   ),
//                                 );
//                               }
//
//                             }
//                         ),
//                         SizedBox(height: 15,),
//                         Padding(
//                           padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                           child: Text("Videos",style: TextStyle(color: Colors.black,fontSize: 16),),
//                         ),
//                         SizedBox(height: 10,),
//                         FutureBuilder(
//                   future: BusinessDetailsGet().BusinessDetailsGetData(_eService.id),
//                   builder: (ctx,snapshot)
//                   {
//                     if(snapshot.hasData)
//                     {
//                       video = snapshot.data['data']['video'];
//                       _eService.videoPlayerController = VideoPlayerController.network(video);
//                       _eService.videoPlayerController.initialize();
//                       _eService.videoPlayerController.play();
//                       _eService.startedPlaying = true;
//                       print("+++++++++++++++++++++VIDEO FILE+++++++++++++++++++++");
//                       print(video);
//                       print(_eService.videoPlayerController);
//                       print("++++++++++++++++VIDEO FILE END+++++++++++++++++++++++");
//                       if(_eService.videoPlayerController == null  || video == null)
//                         {
//                           return Container(
//                             width: 120,
//                             child:   Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding:  EdgeInsets.only(left: 15.0),
//                                   child: Container(
//                                     height:100,
//                                     width: 100,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: Colors.grey.shade200
//                                       ),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Center(child: Icon(Icons.image,color: Colors.grey,)),
//
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }
//                       else
//                         {
//                           return Padding(
//                             padding:  EdgeInsets.all(20.0),
//                             child: Container(
//                               width: 120,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   _eService.videoPlayerController !=null ?
//                                   FittedBox(
//                                       fit: BoxFit.cover,
//                                       child: SizedBox(
//                                         height: 120,
//                                         width: 140,
//                                         child: AspectRatio(
//                                           aspectRatio: 20 / 10,
//                                           // aspectRatio: _videoPlayerController.value.aspectRatio,
//                                           child: VideoPlayer(_eService.videoPlayerController),
//                                         ),
//                                       ),
//                                     ):Container(
//                                     width: 120,
//                                     child:   Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding:  EdgeInsets.only(left: 15.0),
//                                           child: Container(
//                                             height:100,
//                                             width: 100,
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               border: Border.all(
//                                                   color: Colors.grey.shade200
//                                               ),
//                                               borderRadius: BorderRadius.circular(5),
//                                             ),
//                                             child: Center(child: Icon(Icons.image,color: Colors.grey,)),
//
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//                     }
//                     else
//                       {
//                         return Container(
//                           width: 120,
//                           child:   Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding:  EdgeInsets.only(left: 15.0),
//                                 child: Container(
//                                   height:100,
//                                   width: 100,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: Colors.grey.shade200
//                                     ),
//                                     borderRadius: BorderRadius.circular(5),
//                                   ),
//                                   child: Center(child: Icon(Icons.image,color: Colors.grey,)),
//
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//
//
//                   }),
//                         SizedBox(height: 15,),
//                         Padding(
//                           padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                           child: Text("Services",style: TextStyle(color: Colors.black,fontSize: 16),),
//                         ),
//                         SizedBox(height: 10,),
//                         FutureBuilder(
//                   future: ServiceList().ServiceListData(),
//                   builder: (ctx,snapshot)
//                   {
//                     if(snapshot.hasData)
//                     {
//                       video = snapshot.data['data']['video'];
//                       _eService.videoPlayerController = VideoPlayerController.network(video);
//                       _eService.videoPlayerController.initialize();
//                       _eService.videoPlayerController.play();
//                       _eService.startedPlaying = true;
//                       if(  _eService.videoPlayerController == null || snapshot.data['data'].length == 0)
//                         {
//                           return Container(
//                             width: 120,
//                             child:   Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding:  EdgeInsets.only(left: 15.0),
//                                   child: Container(
//                                     height:100,
//                                     width: 100,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: Colors.grey.shade200
//                                       ),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Center(child: Icon(Icons.image,color: Colors.grey,)),
//
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }
//                       else
//                         {
//                           return Padding(
//                             padding:  EdgeInsets.all(20.0),
//                             child: Container(
//                               width: 120,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   if(video != null)
//
//                                     FittedBox(
//                                       fit: BoxFit.cover,
//                                       child: SizedBox(
//                                         height: 120,
//                                         width: 140,
//                                         child: AspectRatio(
//                                           aspectRatio: 20 / 10,
//                                           // aspectRatio: _videoPlayerController.value.aspectRatio,
//                                           child: VideoPlayer(_eService.videoPlayerController),
//                                         ),
//                                       ),
//                                     )
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//
//
//                     }
//                     else
//                       {
//                         return Container(
//                           width: 120,
//                           child:   Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding:  EdgeInsets.only(left: 15.0),
//                                 child: Container(
//                                   height:100,
//                                   width: 100,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: Colors.grey.shade200
//                                     ),
//                                     borderRadius: BorderRadius.circular(5),
//                                   ),
//                                   child: Center(child: Icon(Icons.image,color: Colors.grey,)),
//
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//
//
//                   }),
//
//                         Padding(
//                           padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                           child: Text("Photos",style: TextStyle(color: Colors.black,fontSize: 16),),
//
//                         ),
//                         FutureBuilder(
//                         future: BusinessDetailsGet().BusinessDetailsGetData(_eService.id),
//                           builder: (ctx,snapshot)
//                           {
//                             if(snapshot.hasData)
//                               {
//                                 if( snapshot.data['data'] == null|| snapshot.data['data'].length == 0  )
//                                   {
//                                     return  Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding:  EdgeInsets.only(left: 15.0),
//                                           child: Container(
//                                             height:100,
//                                             width: 100,
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               border: Border.all(
//                                                   color: Colors.grey.shade200
//                                               ),
//                                               borderRadius: BorderRadius.circular(5),
//                                             ),
//                                             child: Center(child: Icon(Icons.image,color: Colors.grey,)),
//
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   }
//                                 else
//                                   {
//                                     return  Padding(
//                                       padding:  EdgeInsets.only(left: 15.0),
//                                       child: Container(
//
//                                         padding: EdgeInsets.all(5),
//                                         decoration: BoxDecoration(
//                                           //color: Colors.white,
//                                           border: Border.all(
//                                               color: Colors.grey.shade50
//                                           ),
//                                           borderRadius: BorderRadius.circular(5),
//                                         ),
//                                         // margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 10, bottom: 10),
//                                         child: Row(
//                                           children: [
//                                             ClipRRect(
//                                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                                               child: Container(
//                                                 child: CachedNetworkImage(
//                                                   height: 100,
//                                                   width: 100,
//                                                   fit: BoxFit.fill,
//                                                   imageUrl:snapshot.data['data']['image'].toString(),
//                                                   placeholder: (context, url) => Image.asset(
//                                                     'assets/img/loading.gif',
//                                                     fit: BoxFit.fill,
//                                                     width: 100,
//                                                     height: 100,
//                                                   ),
//                                                   errorWidget: (context, url, error) => Icon(Icons.error_outline),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   }
//
//
//                               }
//                             else
//                               {
//                                 return  Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding:  EdgeInsets.only(left: 15.0),
//                                       child: Container(
//                                         height:100,
//                                         width: 100,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           border: Border.all(
//                                               color: Colors.grey.shade200
//                                           ),
//                                           borderRadius: BorderRadius.circular(5),
//                                         ),
//                                         child: Center(child: Icon(Icons.image,color: Colors.grey,)),
//
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               }
//
//
//                          }),
//                        // buildServiceProvider(_eService),
//                        //  if (_eService.images.isNotEmpty)
//                        //    Padding(
//                        //      padding:  EdgeInsets.only(left: 15.0,top: 10),
//                        //      child: Container(
//                        //        height: 120,
//                        //        child: ListView.builder(
//                        //            primary: false,
//                        //            shrinkWrap: false,
//                        //            scrollDirection: Axis.horizontal,
//                        //            itemCount: _eService.images.length,
//                        //            itemBuilder: (_, index) {
//                        //              var _media = _eService.images.elementAt(index);
//                        //              return InkWell(
//                        //                onTap: () {
//                        //                  Get.toNamed(Routes.GALLERY, arguments: {'media': _eService.images, 'current': _media, 'heroTag': 'e_services_galleries'});
//                        //                },
//                        //                child: Container(
//                        //                  width: 120,
//                        //                  height: 120,
//                        //                  padding: EdgeInsets.all(5),
//                        //                  decoration: BoxDecoration(
//                        //                    color: Colors.white,
//                        //                    border: Border.all(
//                        //                        color: Colors.grey.shade200
//                        //                    ),
//                        //                    borderRadius: BorderRadius.circular(5),
//                        //                  ),
//                        //                  // margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 10, bottom: 10),
//                        //                  child: Stack(
//                        //                    alignment: AlignmentDirectional.topStart,
//                        //                    children: [
//                        //                      Hero(
//                        //                        tag: 'e_services_galleries' + (_media?.id ?? ''),
//                        //                        child: ClipRRect(
//                        //                          borderRadius: BorderRadius.all(Radius.circular(10)),
//                        //                          child: Container(
//                        //                            child: CachedNetworkImage(
//                        //                              height: 100,
//                        //                              width: double.infinity,
//                        //                              fit: BoxFit.fill,
//                        //                              imageUrl: _media.thumb,
//                        //                              placeholder: (context, url) => Image.asset(
//                        //                                'assets/img/loading.gif',
//                        //                                fit: BoxFit.cover,
//                        //                                width: double.infinity,
//                        //                                height: 100,
//                        //                              ),
//                        //                              errorWidget: (context, url, error) => Icon(Icons.error_outline),
//                        //                            ),
//                        //                          ),
//                        //                        ),
//                        //                      ),
//                        //                      // Padding(
//                        //                      //   padding: const EdgeInsetsDirectional.only(start: 12, top: 8),
//                        //                      //   child: Text(
//                        //                      //     _media.name ?? '',
//                        //                      //     maxLines: 2,
//                        //                      //     style: Get.textTheme.bodyText2.merge(TextStyle(
//                        //                      //       color: Get.theme.primaryColor,
//                        //                      //       shadows: <Shadow>[
//                        //                      //         Shadow(
//                        //                      //           offset: Offset(0, 1),
//                        //                      //           blurRadius: 6.0,
//                        //                      //           color: Get.theme.hintColor.withOpacity(0.6),
//                        //                      //         ),
//                        //                      //       ],
//                        //                      //     )),
//                        //                      //   ),
//                        //                      // ),
//                        //                    ],
//                        //                  ),
//                        //                ),
//                        //              );
//                        //            }),
//                        //      ),
//                        //    ),
//                           // EServiceTilWidget(
//                           //   horizontalPadding: 0,
//                           //   title: Text("".tr, style: Get.textTheme.subtitle2).paddingSymmetric(horizontal: 0),
//                           //   content: Container(
//                           //     height: 120,
//                           //     child: ListView.builder(
//                           //         primary: false,
//                           //         shrinkWrap: false,
//                           //         scrollDirection: Axis.horizontal,
//                           //         itemCount: _eService.images.length,
//                           //         itemBuilder: (_, index) {
//                           //           var _media = _eService.images.elementAt(index);
//                           //           return InkWell(
//                           //             onTap: () {
//                           //               Get.toNamed(Routes.GALLERY, arguments: {'media': _eService.images, 'current': _media, 'heroTag': 'e_services_galleries'});
//                           //             },
//                           //             child: Container(
//                           //               width: 120,
//                           //               height: 120,
//                           //               padding: EdgeInsets.all(5),
//                           //               decoration: BoxDecoration(
//                           //                 color: Colors.white,
//                           //                 border: Border.all(
//                           //                   color: Colors.grey.shade200
//                           //                 ),
//                           //                 borderRadius: BorderRadius.circular(5),
//                           //               ),
//                           //               // margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 10, bottom: 10),
//                           //               child: Stack(
//                           //                 alignment: AlignmentDirectional.topStart,
//                           //                 children: [
//                           //                   Hero(
//                           //                     tag: 'e_services_galleries' + (_media?.id ?? ''),
//                           //                     child: ClipRRect(
//                           //                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                           //                       child: Container(
//                           //                         child: CachedNetworkImage(
//                           //                           height: 100,
//                           //                           width: double.infinity,
//                           //                           fit: BoxFit.fill,
//                           //                           imageUrl: _media.thumb,
//                           //                           placeholder: (context, url) => Image.asset(
//                           //                             'assets/img/loading.gif',
//                           //                             fit: BoxFit.cover,
//                           //                             width: double.infinity,
//                           //                             height: 100,
//                           //                           ),
//                           //                           errorWidget: (context, url, error) => Icon(Icons.error_outline),
//                           //                         ),
//                           //                       ),
//                           //                     ),
//                           //                   ),
//                           //                   // Padding(
//                           //                   //   padding: const EdgeInsetsDirectional.only(start: 12, top: 8),
//                           //                   //   child: Text(
//                           //                   //     _media.name ?? '',
//                           //                   //     maxLines: 2,
//                           //                   //     style: Get.textTheme.bodyText2.merge(TextStyle(
//                           //                   //       color: Get.theme.primaryColor,
//                           //                   //       shadows: <Shadow>[
//                           //                   //         Shadow(
//                           //                   //           offset: Offset(0, 1),
//                           //                   //           blurRadius: 6.0,
//                           //                   //           color: Get.theme.hintColor.withOpacity(0.6),
//                           //                   //         ),
//                           //                   //       ],
//                           //                   //     )),
//                           //                   //   ),
//                           //                   // ),
//                           //                 ],
//                           //               ),
//                           //             ),
//                           //           );
//                           //         }),
//                           //   ),
//                           //   actions: [
//                           //     // TODO View all galleries
//                           //   ],
//                           // ),
//                           Padding(
//                           padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
//                           child: Text("Social media links",style: TextStyle(color: Colors.black,fontSize: 18),),
//                         ),
//                           Padding(
//                           padding:  EdgeInsets.only(left: 15.0,right: 15,top: 10,bottom: 40),
//                           child: Container(
//                             //height: 150,
//                             padding: EdgeInsets.all(10),
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//
//                             ),
//                             child:  Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.all(10),
//
//                                        height:40,
//                                        width: 40,
//                                       decoration: BoxDecoration(
//                                         color: Color(0xff3c599f),
//                                         borderRadius: BorderRadius.circular(100),
//                                       ),
//                                       child: Center(child: Icon(FontAwesomeIcons.facebookF,color: Colors.white,)),
//                                     ),
//                                     SizedBox(height: 6,),
//                                     Text("Facebook",style: TextStyle(color: Colors.grey.shade700,fontSize:10),)
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Container(
//                                       height:40,
//                                       width: 40,
//                                       decoration: BoxDecoration(
//                                         color: Color(0xff1da1f2),
//                                         borderRadius: BorderRadius.circular(100),
//                                       ),
//                                       child: Center(child: Icon(FontAwesomeIcons.twitter,color: Colors.white,)),
//                                     ),
//                                     SizedBox(height: 6,),
//                                     Text("Twitter",style: TextStyle(color: Colors.grey.shade700,fontSize:10),)
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Container(
//                                       height:40,
//                                       width: 40,
//                                       decoration: BoxDecoration(
//                                         color: Color(0xff0172b1),
//                                         borderRadius: BorderRadius.circular(100),
//                                       ),
//                                       child: Center(child: Icon(FontAwesomeIcons.linkedinIn,color: Colors.white,)),
//                                     ),
//                                     SizedBox(height: 6,),
//                                     Text("Linkedin",style: TextStyle(color: Colors.grey.shade700,fontSize:10),)
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Container(
//                                       height:40,
//                                       width: 40,
//                                       decoration: BoxDecoration(
//                                         color: Color(0xffdf0043),
//                                         borderRadius: BorderRadius.circular(100),
//                                       ),
//                                       child: Center(child: Icon(FontAwesomeIcons.instagram,color: Colors.white,)),
//                                     ),
//                                     SizedBox(height: 6,),
//                                     Text("Instagram",style: TextStyle(color: Colors.grey.shade700,fontSize:10),)
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Container(
//                                       height:40,
//                                       width: 40,
//                                       decoration: BoxDecoration(
//                                         color: Color(0xff0187b1),
//                                         borderRadius: BorderRadius.circular(100),
//                                       ),
//                                       child: Center(child: Icon(Icons.web,color: Colors.white,)),
//                                     ),
//                                     SizedBox(height: 6,),
//                                     Text("Website",style: TextStyle(color: Colors.grey.shade700,fontSize:10),)
//                                   ],
//                                 )
//
//
//                               ],
//                             ),
//
//                           ),
//                         ),
//                         //   EServiceTilWidget(
//                         //   title: Text("Reviews & Ratings".tr, style: Get.textTheme.subtitle2),
//                         //   content: Column(
//                         //     children: [
//                         //       Text(_eService.rate.toString(), style: Get.textTheme.headline1),
//                         //       Wrap(
//                         //         children: Ui.getStarsList(_eService.rate, size: 32),
//                         //       ),
//                         //       Text(
//                         //         "Reviews (%s)".trArgs([_eService.totalReviews.toString()]),
//                         //         style: Get.textTheme.caption,
//                         //       ).paddingOnly(top: 10),
//                         //       Divider(height: 35, thickness: 1.3),
//                         //       Obx(() {
//                         //         if (controller.reviews.isEmpty) {
//                         //           return CircularLoadingWidget(height: 100);
//                         //         }
//                         //         return ListView.separated(
//                         //           padding: EdgeInsets.all(0),
//                         //           itemBuilder: (context, index) {
//                         //             return ReviewItemWidget(review: controller.reviews.elementAt(index));
//                         //           },
//                         //           separatorBuilder: (context, index) {
//                         //             return Divider(height: 35, thickness: 1.3);
//                         //           },
//                         //           itemCount: controller.reviews.length,
//                         //           primary: false,
//                         //           shrinkWrap: true,
//                         //         );
//                         //       }),
//                         //     ],
//                         //   ),
//                         //   actions: [
//                         //     // TODO view all reviews
//                         //   ],
//                         // ),
//                       ],
//                     ),
//
//                   ],
//                 ),
//               )
//           ),
//         );
//       }
//     });
//   }
//
//   Widget buildOptions(EService _eService) {
//     return Obx(() {
//       if (controller.optionGroups.isEmpty) {
//         return SizedBox();
//       }
//       return EServiceTilWidget(
//         horizontalPadding: 0,
//         title: Text("Options".tr, style: Get.textTheme.subtitle2).paddingSymmetric(horizontal: 20),
//         content: ListView.separated(
//           padding: EdgeInsets.all(0),
//           itemBuilder: (context, index) {
//             return OptionGroupItemWidget(optionGroup: controller.optionGroups.elementAt(index), eService: _eService);
//           },
//           separatorBuilder: (context, index) {
//             return SizedBox(height: 6);
//           },
//           itemCount: controller.optionGroups.length,
//           primary: false,
//           shrinkWrap: true,
//         ),
//       );
//     });
//   }
//
//   Container buildDuration(EService _eService) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       decoration: Ui.getBoxDecoration(),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 Text("Duration".tr, style: Get.textTheme.subtitle2),
//                 Text("This service can take up to ".tr, style: Get.textTheme.bodyText1),
//               ],
//               crossAxisAlignment: CrossAxisAlignment.start,
//             ),
//           ),
//           Text(_eService.duration, style: Get.textTheme.headline6),
//         ],
//       ),
//     );
//   }
//
//   CarouselSlider buildCarouselSlider(EService _eService) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         autoPlay: true,
//         autoPlayInterval: Duration(seconds: 7),
//         height: 250,
//         viewportFraction: 1.0,
//         onPageChanged: (index, reason) {
//           controller.currentSlide.value = index;
//         },
//       ),
//       items: _eService.images.map((Media media) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Hero(
//               tag: controller.heroTag.value + _eService.id,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) ),
//                 child: CachedNetworkImage(
//                   width: double.infinity,
//                   //height: 330,
//                   fit: BoxFit.fill,
//                   imageUrl: media.url,
//                   placeholder: (context, url) => Image.asset(
//                     'assets/img/loading.gif',
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                   ),
//                   errorWidget: (context, url, error) => Icon(Icons.error_outline),
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }
//
//   Container buildCarouselBullets(EService _eService) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: _eService.images.map((Media media) {
//           return Container(
//             width: 20.0,
//             height: 5.0,
//             margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//                 color: controller.currentSlide.value == _eService.images.indexOf(media) ? Get.theme.hintColor : Get.theme.primaryColor.withOpacity(0.4)),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   EServiceTitleBarWidget buildEServiceTitleBarWidget(EService _eService) {
//     return EServiceTitleBarWidget(
//       title: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   _eService.name ?? '',
//                   style: Get.textTheme.headline5.merge(TextStyle(height: 1.1)),
//                   maxLines: 2,
//                   softWrap: true,
//                   overflow: TextOverflow.fade,
//                 ),
//               ),
//               // if (_eService.eProvider == null)
//               //   Container(
//               //     child: Text("  .  .  .  ".tr,
//               //         maxLines: 1,
//               //         style: Get.textTheme.bodyText2.merge(
//               //           TextStyle(color: Colors.grey, height: 1.4, fontSize: 10),
//               //         ),
//               //         softWrap: false,
//               //         textAlign: TextAlign.center,
//               //         overflow: TextOverflow.fade),
//               //     decoration: BoxDecoration(
//               //       color: Colors.grey.withOpacity(0.2),
//               //       borderRadius: BorderRadius.circular(8),
//               //     ),
//               //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//               //     margin: EdgeInsets.symmetric(vertical: 3),
//               //   ),
//               // if (_eService.eProvider != null && _eService.eProvider.available)
//               //   Container(
//               //     child: Text("Available".tr,
//               //         maxLines: 1,
//               //         style: Get.textTheme.bodyText2.merge(
//               //           TextStyle(color: Colors.green, height: 1.4, fontSize: 10),
//               //         ),
//               //         softWrap: false,
//               //         textAlign: TextAlign.center,
//               //         overflow: TextOverflow.fade),
//               //     decoration: BoxDecoration(
//               //       color: Colors.green.withOpacity(0.2),
//               //       borderRadius: BorderRadius.circular(8),
//               //     ),
//               //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//               //     margin: EdgeInsets.symmetric(vertical: 3),
//               //   ),
//               // if (_eService.eProvider != null && !_eService.eProvider.available)
//               //   Container(
//               //     child: Text("Offline".tr,
//               //         maxLines: 1,
//               //         style: Get.textTheme.bodyText2.merge(
//               //           TextStyle(color: Colors.grey, height: 1.4, fontSize: 10),
//               //         ),
//               //         softWrap: false,
//               //         textAlign: TextAlign.center,
//               //         overflow: TextOverflow.fade),
//               //     decoration: BoxDecoration(
//               //       color: Colors.grey.withOpacity(0.2),
//               //       borderRadius: BorderRadius.circular(8),
//               //     ),
//               //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//               //     margin: EdgeInsets.symmetric(vertical: 3),
//               //   ),
//             ],
//           ),
//           // Row(
//           //   crossAxisAlignment: CrossAxisAlignment.end,
//           //   children: [
//           //     Expanded(
//           //       child: Column(
//           //         crossAxisAlignment: CrossAxisAlignment.start,
//           //         children: [
//           //           Wrap(crossAxisAlignment: WrapCrossAlignment.end, children: List.from(Ui.getStarsList(_eService.rate))),
//           //           Text(
//           //             "Reviews (%s)".trArgs([_eService.totalReviews.toString()]),
//           //             style: Get.textTheme.caption,
//           //           ),
//           //         ],
//           //       ),
//           //     ),
//           //     Column(
//           //       crossAxisAlignment: CrossAxisAlignment.end,
//           //       children: [
//           //         if (_eService.getOldPrice > 0)
//           //           Ui.getPrice(
//           //             _eService.getOldPrice,
//           //             style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.focusColor, decoration: TextDecoration.lineThrough)),
//           //             unit: _eService.getUnit,
//           //           ),
//           //         Ui.getPrice(
//           //           _eService.getPrice,
//           //           style: Get.textTheme.headline3.merge(TextStyle(color: Get.theme.colorScheme.secondary)),
//           //           unit: _eService.getUnit,
//           //         ),
//           //       ],
//           //     ),
//           //   ],
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildCategories(EService _eService) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Wrap(
//         alignment: WrapAlignment.start,
//         spacing: 5,
//         runSpacing: 8,
//         children: List.generate(_eService.categories.length, (index) {
//               var _category = _eService.categories.elementAt(index);
//               return Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 child: Text(_category.name, style: Get.textTheme.bodyText1.merge(TextStyle(color: _category.color))),
//                 decoration: BoxDecoration(
//                     color: _category.color.withOpacity(0.2),
//                     border: Border.all(
//                       color: _category.color.withOpacity(0.1),
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(20))),
//               );
//             }) +
//             List.generate(_eService.subCategories.length, (index) {
//               return Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 child: Text(_eService.subCategories.elementAt(index).name, style: Get.textTheme.caption),
//                 decoration: BoxDecoration(
//                     color: Get.theme.primaryColor,
//                     border: Border.all(
//                       color: Get.theme.focusColor.withOpacity(0.2),
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(20))),
//               );
//             }),
//       ),
//     );
//   }
//
//   Widget buildServiceProvider(EService _eService) {
//     if (_eService?.eProvider?.hasData ?? false) {
//       return GestureDetector(
//         onTap: () {
//           Get.toNamed(Routes.E_PROVIDER, arguments: {'eProvider': _eService.eProvider, 'heroTag': 'e_service_details'});
//         },
//         child: EServiceTilWidget(
//           title: Text("Service Provider".tr, style: Get.textTheme.subtitle2),
//           content: EProviderItemWidget(provider: _eService.eProvider),
//           actions: [
//             Text("View More".tr, style: Get.textTheme.subtitle1),
//           ],
//         ),
//       );
//     } else {
//       return EServiceTilWidget(
//         title: Text("Service Provider".tr, style: Get.textTheme.subtitle2),
//         content: SizedBox(
//           height: 60,
//         ),
//         actions: [],
//       );
//     }
//   }
//
//   Widget buildBottomWidget(EService _eService) {
//     if (_eService.enableBooking == null || !_eService.enableBooking)
//       return SizedBox();
//     else
//       return Container(
//         padding: EdgeInsets.symmetric(vertical: 20),
//         decoration: BoxDecoration(
//           color: Get.theme.primaryColor,
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           boxShadow: [
//             BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5)),
//           ],
//         ),
//         child: Row(
//           children: [
//             if (_eService.priceUnit == 'fixed')
//               Container(
//                 decoration: BoxDecoration(
//                   color: Get.theme.colorScheme.secondary.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   textDirection: TextDirection.ltr,
//                   children: [
//                     MaterialButton(
//                       height: 24,
//                       minWidth: 46,
//                       onPressed: controller.decrementQuantity,
//                       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                       color: Get.theme.colorScheme.secondary,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(10))),
//                       child: Icon(Icons.remove, color: Get.theme.primaryColor, size: 28),
//                       elevation: 0,
//                     ),
//                     SizedBox(
//                       width: 38,
//                       child: Obx(() {
//                         return Text(
//                           controller.quantity.toString(),
//                           textAlign: TextAlign.center,
//                           style: Get.textTheme.subtitle2.merge(
//                             TextStyle(color: Get.theme.colorScheme.secondary),
//                           ),
//                         );
//                       }),
//                     ),
//                     MaterialButton(
//                       onPressed: controller.incrementQuantity,
//                       height: 24,
//                       minWidth: 46,
//                       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                       color: Get.theme.colorScheme.secondary,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10))),
//                       child: Icon(Icons.add, color: Get.theme.primaryColor, size: 28),
//                       elevation: 0,
//                     ),
//                   ],
//                 ),
//               ),
//             if (_eService.priceUnit == 'fixed') SizedBox(width: 10),
//             Expanded(
//               child: BlockButtonWidget(
//
//                   text: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: 24,
//                         alignment: Alignment.center,
//                         child: Text(
//                           "BOOK NOW".tr,
//                           textAlign: TextAlign.center,
//                           style: Get.textTheme.headline6.merge(
//                             TextStyle(color: Get.theme.primaryColor),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 8,),
//                       Container(
//                         height: 20,
//                           width: 20,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             border: Border.all(
//                               color: Colors.white
//                             )
//                           ),
//                           child: Icon(FontAwesomeIcons.info,color: Colors.white,size: 10,))
//                     ],
//                   ),
//
//                   color: Get.theme.colorScheme.secondary,
//                   onPressed: () {
//                     Get.toNamed(Routes.BOOK_E_SERVICE, arguments: {'eService': _eService, 'options': controller.getCheckedOptions(), 'quantity': controller.quantity.value});
//                   }),
//             ),
//           ],
//         ).paddingOnly(right: 20, left: 20),
//       );
//   }
// }
//
// class _ControlsOverlay extends StatelessWidget {
//   const _ControlsOverlay({Key key, this.controller})
//       : super(key: key);
//
//   static const List<Duration> _exampleCaptionOffsets = <Duration>[
//     Duration(seconds: -10),
//     Duration(seconds: -3),
//     Duration(seconds: -1, milliseconds: -500),
//     Duration(milliseconds: -250),
//     Duration(milliseconds: 0),
//     Duration(milliseconds: 250),
//     Duration(seconds: 1, milliseconds: 500),
//     Duration(seconds: 3),
//     Duration(seconds: 10),
//   ];
//   static const List<double> _examplePlaybackRates = <double>[
//     0.25,
//     0.5,
//     1.0,
//     1.5,
//     2.0,
//     3.0,
//     5.0,
//     10.0,
//   ];
//
//   final VideoPlayerController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 50),
//           reverseDuration: const Duration(milliseconds: 200),
//           child: controller.value.isPlaying
//               ? const SizedBox.shrink()
//               : Container(
//             color: Colors.black26,
//             child: const Center(
//               child: Icon(
//                 Icons.play_arrow,
//                 color: Colors.white,
//                 size: 100.0,
//                 semanticLabel: 'Play',
//               ),
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             controller.value.isPlaying ? controller.pause() : controller.play();
//           },
//         ),
//         Align(
//           alignment: Alignment.topLeft,
//           child: PopupMenuButton<Duration>(
//             initialValue: controller.value.captionOffset,
//             tooltip: 'Caption Offset',
//             onSelected: (Duration delay) {
//               controller.setCaptionOffset(delay);
//             },
//             itemBuilder: (BuildContext context) {
//               return <PopupMenuItem<Duration>>[
//                 for (final Duration offsetDuration in _exampleCaptionOffsets)
//                   PopupMenuItem<Duration>(
//                     value: offsetDuration,
//                     child: Text('${offsetDuration.inMilliseconds}ms'),
//                   )
//               ];
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 // Using less vertical padding as the text is also longer
//                 // horizontally, so it feels like it would need more spacing
//                 // horizontally (matching the aspect ratio of the video).
//                 vertical: 12,
//                 horizontal: 16,
//               ),
//               child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.topRight,
//           child: PopupMenuButton<double>(
//             initialValue: controller.value.playbackSpeed,
//             tooltip: 'Playback speed',
//             onSelected: (double speed) {
//               controller.setPlaybackSpeed(speed);
//             },
//             itemBuilder: (BuildContext context) {
//               return <PopupMenuItem<double>>[
//                 for (final double speed in _examplePlaybackRates)
//                   PopupMenuItem<double>(
//                     value: speed,
//                     child: Text('${speed}x'),
//                   )
//               ];
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 // Using less vertical padding as the text is also longer
//                 // horizontally, so it feels like it would need more spacing
//                 // horizontally (matching the aspect ratio of the video).
//                 vertical: 12,
//                 horizontal: 16,
//               ),
//               child: Text('${controller.value.playbackSpeed}x'),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
//
//
//

import 'dart:io';

import 'package:bizmart/app/models/business_details_get_api/e_services_get_api.dart';
import 'package:bizmart/app/modules/e_service/views/image_view_page.dart';
import 'package:bizmart/app/modules/e_service/views/video_view.dart';
import 'package:bizmart/app/modules/enquiry_form.dart';
import 'package:bizmart/app/modules/root/controllers/root_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/ui.dart';
import '../../../models/e_service_model.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../controllers/e_service_controller.dart';
import '../widgets/e_provider_item_widget.dart';
import '../widgets/e_service_til_widget.dart';
import '../widgets/e_service_title_bar_widget.dart';
import '../widgets/option_group_item_widget.dart';

class EServiceView extends GetView<EServiceController> {
  var videos;
  var downLoading = false;
  var downLoaded= false;
  var errorDownload = false;
  void initState(EService _eService) {
    videos = EservicesData().EservicesDataLst(_eService.id);
  }

  Widget build(BuildContext context) {
    return Obx(() {
      var _eService = controller.eService.value;
      if (!_eService.hasData) {
        return Scaffold(
          body: CircularLoadingWidget(height: Get.height),
        );
      } else {
        return Scaffold(
          backgroundColor: Colors.white,
          // bottomNavigationBar: buildBottomWidget(_eService),
          body: RefreshIndicator(
              onRefresh: () async {
                Get.find<LaravelApiClient>().forceRefresh();
                // controller.refreshEService(showMessage: true);
                //Get.find<LaravelApiClient>().unForceRefresh();
              },
              child: CustomScrollView(
                primary: true,
                shrinkWrap: false,
                slivers: <Widget>[
                  SliverAppBar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      expandedHeight: 250,
                      elevation: 0,
                      floating: true,
                      iconTheme:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      leading: new IconButton(
                        icon: Container(
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                              color: Get.theme.primaryColor.withOpacity(0.5),
                              blurRadius: 20,
                            ),
                          ]),
                          child: new Icon(Icons.arrow_back_ios,
                              color: Get.theme.hintColor),
                        ),
                        onPressed: () {
                          Navigator.pop(context);

                          // Get.back()
                        },
                      ),
                      // actions: [
                      //   new IconButton(
                      //     icon: Container(
                      //       decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      //         BoxShadow(
                      //           color: Get.theme.primaryColor.withOpacity(0.5),
                      //           blurRadius: 20,
                      //         ),
                      //       ]),
                      //       child: (_eService?.isFavorite ?? false) ? Icon(Icons.favorite, color: Colors.redAccent) : Icon(Icons.favorite_outline, color: Get.theme.hintColor),
                      //     ),
                      //     onPressed: () {
                      //       if (!Get.find<AuthService>().isAuth) {
                      //         Get.toNamed(Routes.LOGIN);
                      //       } else {
                      //         if (_eService?.isFavorite ?? false) {
                      //           controller.removeFromFavorite();
                      //         } else {
                      //           controller.addToFavorite();
                      //         }
                      //       }
                      //     },
                      //   ).marginSymmetric(horizontal: 10),
                      // ],
                      // bottom: buildEServiceTitleBarWidget(_eService),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Obx(() {
                          return Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: <Widget>[
                              buildCarouselSlider(_eService),

                              // Positioned(
                              //      top:150,
                              //      child: buildCarouselBullets(_eService)),
                            ],
                          );
                        }),
                      )),

                  // WelcomeWidget(),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10),
                        buildTitleView(_eService),
                        SizedBox(height: 20),
                        //buildCategories(_eService),
                        EServiceTilWidget(
                          title: Text("Description".tr,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          content: Obx(() {
                            if (controller.eService.value.description == '') {
                              return SizedBox();
                            }
                            return Ui.applyHtml(
                                controller.eService.value.description,
                                style: Get.textTheme.bodyText1);
                          }),
                        ),
                        buildDuration(_eService),
                        buildIconRow(_eService),
                        Divider(
                          height: 5,
                          thickness: 2,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 25.0, right: 20, top: 15),
                          child: Text(
                            "Address",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        buildAddress(_eService),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 25.0, right: 20, top: 15),
                          child: Text(
                            "Business Details",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),

                        buildBusinessDetails(_eService),
                        buildGst(_eService),
                        // Padding(
                        //   padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
                        //   child: Text("Certificate",style: TextStyle(color: Get.theme.colorScheme.secondary,fontSize: 16),),
                        // ),
                        // buildCertificate(_eService),
                        // Padding(
                        //   padding:  EdgeInsets.only(left: 25.0,right: 20,top: 15),
                        //   child: Text("Contact us",style: TextStyle(color: Colors.black,fontSize: 16),),
                        //
                        // ),
                        // buildContactUs(_eService),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 20, top: 10, bottom: 8),
                          child: Text(
                            "Photos",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        buildPhotos(_eService),


                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20, top: 15, bottom: 10),
                          child: Text(
                            "Videos",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        buildVideos(_eService),
                        SizedBox(
                          height: 10,
                        ),

                        Padding(
                          padding:
                          EdgeInsets.only(left: 25.0, right: 20, top: 10),
                          child: Text(
                            "Social media links",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        buildSocialmedia(_eService),
                        SizedBox(
                          height: 15,
                        ),
                        // buildOptions(_eService),
                        //  buildServiceProvider(_eService),
                        //    if (_eService.images.isNotEmpty)
                        //      EServiceTilWidget(
                        //        horizontalPadding: 0,
                        //        title: Text("Galleries".tr, style: Get.textTheme.subtitle2).paddingSymmetric(horizontal: 20),
                        //        content: Container(
                        //          height: 120,
                        //          child: ListView.builder(
                        //              primary: false,
                        //              shrinkWrap: false,
                        //              scrollDirection: Axis.horizontal,
                        //              itemCount: _eService.images.length,
                        //              itemBuilder: (_, index) {
                        //                var _media = _eService.images.elementAt(index);
                        //                return InkWell(
                        //                  onTap: () {
                        //                    Get.toNamed(Routes.GALLERY, arguments: {'media': _eService.images, 'current': _media, 'heroTag': 'e_services_galleries'});
                        //                  },
                        //                  child: Container(
                        //                    width: 100,
                        //                    height: 100,
                        //                    margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 10, bottom: 10),
                        //                    child: Stack(
                        //                      alignment: AlignmentDirectional.topStart,
                        //                      children: [
                        //                        Hero(
                        //                          tag: 'e_services_galleries' + (_media?.id ?? ''),
                        //                          child: ClipRRect(
                        //                            borderRadius: BorderRadius.all(Radius.circular(10)),
                        //                            child: CachedNetworkImage(
                        //                              height: 100,
                        //                              width: double.infinity,
                        //                              fit: BoxFit.cover,
                        //                              imageUrl: _media.thumb,
                        //                              placeholder: (context, url) => Image.asset(
                        //                                'assets/img/loading.gif',
                        //                                fit: BoxFit.cover,
                        //                                width: double.infinity,
                        //                                height: 100,
                        //                              ),
                        //                              errorWidget: (context, url, error) => Icon(Icons.error_outline),
                        //                            ),
                        //                          ),
                        //                        ),
                        //                        Padding(
                        //                          padding: const EdgeInsetsDirectional.only(start: 12, top: 8),
                        //                          child: Text(
                        //                            _media.name ?? '',
                        //                            maxLines: 2,
                        //                            style: Get.textTheme.bodyText2.merge(TextStyle(
                        //                              color: Get.theme.primaryColor,
                        //                              shadows: <Shadow>[
                        //                                Shadow(
                        //                                  offset: Offset(0, 1),
                        //                                  blurRadius: 6.0,
                        //                                  color: Get.theme.hintColor.withOpacity(0.6),
                        //                                ),
                        //                              ],
                        //                            )),
                        //                          ),
                        //                        ),
                        //                      ],
                        //                    ),
                        //                  ),
                        //                );
                        //              }),
                        //        ),
                        //        actions: [
                        //          // TODO View all galleries
                        //        ],
                        //      ),
                        // EServiceTilWidget(
                        //   title: Text("Reviews & Ratings".tr, style: Get.textTheme.subtitle2),
                        //   content: Column(
                        //     children: [
                        //       Text(_eService.rate.toString(), style: Get.textTheme.headline1),
                        //       Wrap(
                        //         children: Ui.getStarsList(_eService.rate, size: 32),
                        //       ),
                        //       Text(
                        //         "Reviews (%s)".trArgs([_eService.totalReviews.toString()]),
                        //         style: Get.textTheme.caption,
                        //       ).paddingOnly(top: 10),
                        //       Divider(height: 35, thickness: 1.3),
                        //       Obx(() {
                        //         if (controller.reviews.isEmpty) {
                        //           return CircularLoadingWidget(height: 100);
                        //         }
                        //         return ListView.separated(
                        //           padding: EdgeInsets.all(0),
                        //           itemBuilder: (context, index) {
                        //             return ReviewItemWidget(review: controller.reviews.elementAt(index));
                        //           },
                        //           separatorBuilder: (context, index) {
                        //             return Divider(height: 35, thickness: 1.3);
                        //           },
                        //           itemCount: controller.reviews.length,
                        //           primary: false,
                        //           shrinkWrap: true,
                        //         );
                        //       }),
                        //     ],
                        //   ),
                        //   actions: [
                        //     // TODO view all reviews
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      }
    });
  }

  Widget buildOptions(EService _eService) {
    return Obx(() {
      if (controller.optionGroups.isEmpty) {
        return SizedBox();
      }
      return EServiceTilWidget(
        horizontalPadding: 0,
        title: Text("Options".tr, style: Get.textTheme.subtitle2)
            .paddingSymmetric(horizontal: 20),
        content: ListView.separated(
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return OptionGroupItemWidget(
                optionGroup: controller.optionGroups.elementAt(index),
                eService: _eService);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 6);
          },
          itemCount: controller.optionGroups.length,
          primary: false,
          shrinkWrap: true,
        ),
      );
    });
  }

  Padding buildDuration(EService _eService) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Duration".tr,
              style: TextStyle(color: Colors.black, fontSize: 15)),
          SizedBox(
            height: 10,
          ),
          Card(
            elevation: 2,
            child: Container(
              //  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              padding: EdgeInsets.all(
                20,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(0)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("This service can take up to ".tr,
                            style: Get.textTheme.bodyText1),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Text(_eService.duration, style: Get.textTheme.headline6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  CarouselSlider buildCarouselSlider(EService _eService) {
    return CarouselSlider(
        options: CarouselOptions(
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 7),
          height: 380,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            controller.currentSlide.value = index;
          },
        ),
        items: [
          Hero(
            tag: controller.heroTag.value + _eService.id,
            child: CachedNetworkImage(
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              imageUrl: _eService.serviceImage,
              placeholder: (context, url) => ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: LinearProgressIndicator(
                  color: Colors.grey.shade200,
                  backgroundColor: Colors.grey.shade50,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/img/no_img_1.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                width: double.infinity,
              ),
              // placeholder: (context, url) => Image.asset(
              //   'assets/img/loading.gif',
              //   fit: BoxFit.fitHeight,
              //   width: double.infinity,
              // ),
              // errorWidget: (context, url, error) => Icon(Icons.image_outlined,color: Colors.grey.shade400,size: 40,),
            ),
          )
        ]);
  }

  // Container buildCarouselBullets(EService _eService) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: _eService.images.map((Media media) {
  //         return Container(
  //           width: 20.0,
  //           height: 5.0,
  //           margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(10),
  //               ),
  //               color: controller.currentSlide.value == _eService.images.indexOf(media) ? Get.theme.hintColor : Get.theme.primaryColor.withOpacity(0.4)),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }
  EServiceTitleBarWidget buildEServiceTitleBarWidget(EService _eService) {
    return EServiceTitleBarWidget(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "All home services  ",
                  // _eService.name ?? '',
                  style: TextStyle(fontSize: 18),
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              // SizedBox(width: 5,),
              Text(
                "₹ " +
                    _eService.getPrice.toString() +
                    "/" +
                    _eService.priceUnit.toString(),
                style: TextStyle(fontSize: 16),
              ),
              // Ui.getPrice(
              //   _eService.getPrice,
              //   style: Get.textTheme.headline3.merge(TextStyle(color: Get.theme.colorScheme.secondary)),
              //   unit: _eService.getUnit,
              // ),
              // if (_eService.eProvider == null)
              //   Container(
              //     child: Text("  .  .  .  ".tr,
              //         maxLines: 1,
              //         style: Get.textTheme.bodyText2.merge(
              //           TextStyle(color: Colors.grey, height: 1.4, fontSize: 10),
              //         ),
              //         softWrap: false,
              //         textAlign: TextAlign.center,
              //         overflow: TextOverflow.fade),
              //     decoration: BoxDecoration(
              //       color: Colors.grey.withOpacity(0.2),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              //     margin: EdgeInsets.symmetric(vertical: 3),
              //   ),
              // if (_eService.eProvider != null && _eService.eProvider.available)
              //   Container(
              //     child: Text("Available".tr,
              //         maxLines: 1,
              //         style: Get.textTheme.bodyText2.merge(
              //           TextStyle(color: Colors.green, height: 1.4, fontSize: 10),
              //         ),
              //         softWrap: false,
              //         textAlign: TextAlign.center,
              //         overflow: TextOverflow.fade),
              //     decoration: BoxDecoration(
              //       color: Colors.green.withOpacity(0.2),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              //     margin: EdgeInsets.symmetric(vertical: 3),
              //   ),
              // if (_eService.eProvider != null && !_eService.eProvider.available)
              //   Container(
              //     child: Text("Offline".tr,
              //         maxLines: 1,
              //         style: Get.textTheme.bodyText2.merge(
              //           TextStyle(color: Colors.grey, height: 1.4, fontSize: 10),
              //         ),
              //         softWrap: false,
              //         textAlign: TextAlign.center,
              //         overflow: TextOverflow.fade),
              //     decoration: BoxDecoration(
              //       color: Colors.grey.withOpacity(0.2),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              //     margin: EdgeInsets.symmetric(vertical: 3),
              //   ),
            ],
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Wrap(crossAxisAlignment: WrapCrossAlignment.end, children: List.from(Ui.getStarsList(_eService.rate))),
          //           Text(
          //             "Reviews (%s)".trArgs([_eService.totalReviews.toString()]),
          //             style: Get.textTheme.caption,
          //           ),
          //         ],
          //       ),
          //     ),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         // if (_eService.getOldPrice > 0)
          //         //   Ui.getPrice(
          //         //     _eService.getOldPrice,
          //         //     style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.focusColor, decoration: TextDecoration.lineThrough)),
          //         //     unit: _eService.getUnit,
          //         //   ),
          //         Ui.getPrice(
          //           _eService.getPrice,
          //           style: Get.textTheme.headline3.merge(TextStyle(color: Get.theme.colorScheme.secondary)),
          //           unit: _eService.getUnit,
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget buildAddress(EService _eService) {
    return FutureBuilder(
        future: EservicesData().EservicesDataLst(_eService.id),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null ||
                snapshot.data['data'].length == 0) {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 0),
                child: Container(
                  height: 200,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: Card(
                  elevation: 2,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(
                          //   color: Colors.grey.shade200,
                          // ),
                          borderRadius: BorderRadius.circular(0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 0, top: 5),
                            child: Row(children: [
                              snapshot.data['data'][0]['company_name'] == null
                                  ? Container()
                                  : Container(
                                      padding: EdgeInsets.all(8.0),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color:
                                              Get.theme.colorScheme.secondary,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                          child: Icon(
                                        Icons.apartment,
                                        color: Colors.white,
                                        size: 25,
                                      )),
                                    ),
                              // Icon(
                              //         Icons.apartment,
                              //         size: 25,
                              //         color: Get.theme.colorScheme.secondary,
                              //       ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Text(
                                snapshot.data['data'][0]['company_name'] == null
                                    ? ""
                                    : snapshot.data['data'][0]['company_name']
                                        .toString(),
                                // Text(controller.eService.value.district.toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0, top: 15),
                            child: Row(
                              children: [
                                snapshot.data['data'][0]['address'] == null
                                    ? Container()
                                    : Container(
                                        padding: EdgeInsets.all(8.0),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color:
                                                Get.theme.colorScheme.secondary,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 25,
                                        )),
                                      ),
                                // Icon(
                                //         Icons.location_on,
                                //         size: 25,
                                //         color: Get.theme.colorScheme.secondary,
                                //       ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                    child: Text(
                                  snapshot.data['data'][0]['address'] == null
                                      ? ""
                                      : snapshot.data['data'][0]['address']
                                              .toString() +
                                          "," +
                                          snapshot.data['data'][0]['district']
                                              .toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                  maxLines: 3,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ))
                              ],
                            ),
                          ),
                          snapshot.data['data'][0]['landmark'] == null
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.only(left: 0, top: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color:
                                                Get.theme.colorScheme.secondary,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Icon(
                                          Icons.map,
                                          color: Colors.white,
                                          size: 25,
                                        )),
                                      ),

                                      // Icon(
                                      //   Icons.map,
                                      //   size: 25,
                                      //   color: Get.theme.colorScheme.secondary,
                                      // ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          snapshot.data['data'][0]
                                                      ['landmark'] ==
                                                  null
                                              ? ""
                                              : snapshot.data['data'][0]
                                                      ['landmark']
                                                  .toString(),
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                ),
                          // snapshot.data['data'][0]['mobile_number'] == null
                          //     ? Container()
                          //     :
                          //     // Row(
                          //     //   children: [
                          //     //     Icon(
                          //     //       Icons.phone,
                          //     //       size: 25,
                          //     //       color:
                          //     //           Get.theme.colorScheme.secondary,
                          //     //     ),
                          //     //     SizedBox(
                          //     //       width: 10,
                          //     //     ),
                          //     //     Text(
                          //     //         snapshot.data['data'][0]
                          //     //                     ['mobile_number'] ==
                          //     //                 null
                          //     //             ? ""
                          //     //             : snapshot.data['data'][0]
                          //     //                     ['mobile_number']
                          //     //                 .toString(),
                          //     //         style:
                          //     //             TextStyle(color: Colors.black)),
                          //     //   ],
                          //     // ),
                          //     Padding(
                          //         padding: EdgeInsets.only(bottom: 5, top: 15),
                          //         child: Row(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.center,
                          //           mainAxisAlignment: MainAxisAlignment.start,
                          //           children: [
                          //             InkWell(
                          //               onTap: () {
                          //                 launch("tel:" +
                          //                     snapshot.data['data'][0]
                          //                             ['mobile_number']
                          //                         .toString());
                          //               },
                          //               child: Container(
                          //                 padding: EdgeInsets.all(8.0),
                          //                 height: 40,
                          //                 width: 40,
                          //                 decoration: BoxDecoration(
                          //                     color: Get
                          //                         .theme.colorScheme.secondary,
                          //                     borderRadius:
                          //                         BorderRadius.circular(5)),
                          //                 child: Center(
                          //                     child: Icon(
                          //                   Icons.phone,
                          //                   color: Colors.white,
                          //                   size: 25,
                          //                 )),
                          //               ),
                          //             ),
                          //             SizedBox(width: 5),
                          //             Text(
                          //                 snapshot.data['data'][0]
                          //                             ['mobile_number'] ==
                          //                         null
                          //                     ? ""
                          //                     : snapshot.data['data'][0]
                          //                             ['mobile_number']
                          //                         .toString(),
                          //                 style:
                          //                     TextStyle(color: Colors.black)),
                          //             // SizedBox(width: 10,),
                          //             // InkWell(
                          //             //   onTap: ()
                          //             //   {
                          //             //     _mailto("thilagavathikarnan@gmail.com");
                          //             //
                          //             //   },
                          //             //   child: Container(
                          //             //     padding:  EdgeInsets.all(8.0),
                          //             //
                          //             //     height: 40,
                          //             //     width: 40,
                          //             //     decoration: BoxDecoration(
                          //             //         color: Colors.red,
                          //             //         borderRadius: BorderRadius.circular(5)
                          //             //     ),
                          //             //     child:Center(child: Icon(Icons.mail,color: Colors.white,size: 25,)),
                          //             //
                          //             //   ),
                          //             // ),
                          //           ],
                          //         ),
                          //       )
                        ],
                      )),
                ),
              );
            }
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
              child: Container(
                height: 200,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
        });
  }
  Widget buildIconRow(EService _eService)
  {

    return FutureBuilder(
        future: EservicesData().EservicesDataLst(_eService.id),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null ||
                snapshot.data['data'].length == 0) {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            } else {
              return Padding(
                padding:
                EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
                child: Container(
                  //height: 150,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          InkWell(
                            onTap: () {
                              launch("tel:" +
                                  snapshot.data['data'][0]['mobile_number']
                                      .toString());
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.phone,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          InkWell(
                            onTap: () {
                              //  launchUrl(snapshot.data['data'][0]['twitter_link'].toString());
                              // controller.launchUrl(snapshot.data['data'][0]
                              // ['twitter_link']
                              //     .toString());
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                               gradient: LinearGradient(
                                 begin: Alignment.topRight,
                                   end: Alignment.bottomLeft,
                                            stops: [0.1,
                                              0.4,
                                              0.6,
                                              0.9,
                                            ],
                                      colors: [
                                       Colors.red.shade200,
                                        Colors.green.shade700,
                                         Colors.green,
                                          Colors.orange,
                                          ],
                                        )
                                         ),
                              child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.map,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Map",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              String service_name = controller.eService.value.name.toString();
                              String ser_id = controller.eService.value.id.toString();
                              Navigator.push(ctx, MaterialPageRoute(builder: (context)=>EnquiryForm(ser_id:ser_id,service_name:service_name)));
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                               gradient: LinearGradient(
                                 begin: Alignment.topRight,
                                   end: Alignment.bottomLeft,
                                            stops: [0.1,
                                              0.4,
                                              0.6,
                                              0.9,
                                            ],
                                      colors: [

                                        Colors.black,
                                        Colors.black,
                                        Colors.black,
                                        Colors.black,

                                          ],
                                        )
                                         ),
                              child: Center(
                                  child: Icon(
                                   Icons.quickreply_rounded,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Enquiry",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          InkWell(
                            onTap: ()
                            async {
                              Get.back();
                              await Get.find<RootController>().changePage(1);

                              //  launchUrl(snapshot.data['data'][0]['twitter_link'].toString());
                              // controller.launchUrl(snapshot.data['data'][0]
                              // ['twitter_link']
                              //     .toString());
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                               gradient: LinearGradient(
                                 begin: Alignment.topRight,
                                   end: Alignment.bottomLeft,
                                            stops: [0.1,
                                              0.4,
                                              0.6,
                                              0.9,
                                            ],
                                      colors: [
                                       Colors.blue.shade700,
                                        Colors.blue.shade700,
                                         Colors.blue.shade500,
                                          Colors.blue.shade200,
                                          ],
                                        )
                                         ),
                              child: Center(
                                  child: Icon(
                                    Icons.dashboard,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Catelogue",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              );
            }
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
              child: Container(
                height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
        });

  }


  Widget buildCertificate(EService _eService) {
    bool isDownload;
    return FutureBuilder(
        future: EservicesData().EservicesDataLst(_eService.id),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null ||
                snapshot.data['data'].length == 0) {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            } else {
              var download;
              return Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
                  child: snapshot.data['data'][0]['add_certificate'] == null
                      ? Padding(
                          padding:
                              EdgeInsets.only(left: 5.0, right: 5, top: 15),
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )
                      : Obx(() {
                          return InkWell(
                              onTap: () async {
                                // FileDownloader.downloadFile(
                                //     url: snapshot.data['data'][0]['add_certificate'].toString(),
                                //     name: "Certificate downloading...",
                                //     onProgress: (String fileName, double progress) {
                                //       controller.isDownloading.value = true;
                                //       print('FILE fileName HAS PROGRESS $progress');
                                //     },
                                //     onDownloadCompleted: (String path) {
                                //       controller.isDownloaded.value = true;
                                //       print('FILE DOWNLOADED TO PATH: $path');
                                //     },
                                //     onDownloadError: (String error) {
                                //       controller.isErrorDownloading.value = true;
                                //       print('DOWNLOAD ERROR: $error');
                                //     });
                                // final List<File> result = await FileDownloader.downloadFiles(
                                //     urls: [
                                //   snapshot.data['data'][0]['add_certificate'].toString()
                                // ], isParallel: false);
                                // print('FILES: ${result.map((e) => e?.path).join(',\n')}');
                                // download = result.map((e) => e?.path.toString());
                                // if(download != null)
                                //   {
                                //     controller.downloaded(download);
                                //
                                //     print("++++++++++++++++++++++++DOWNLOAD+++++++++++++++IF+++++++++++++++++++++++++++++++++");
                                //     print(download);
                                //     isDownload = true;
                                //     print(_eService.isDownload);
                                //
                                //   }
                                // else
                                //   {
                                //     print("++++++++++++++++++++++++DOWNLOAD+++++++++++++++ELSE+++++++++++++++++++++++++++++++++");
                                //     print(download);
                                //     isDownload = false;
                                //     print(isDownload);
                                //     print(_eService.isDownload);
                                //
                                //
                                //   }
                              },
                              child: Container(
                                  height: 90,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.download),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            snapshot.data['data'][0]
                                            ['add_certificate'] ==
                                                null
                                                ? ""
                                                : "Certificate".toString(),
                                            style: TextStyle(
                                                decoration:
                                                TextDecoration.underline,
                                                color: Colors.blueAccent,
                                                fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                        ],
                                      ),
                                      controller.isDownloading.isTrue?
                                      Container(
                                        height: 30,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Get.theme.colorScheme.secondary,
                                            strokeWidth: 1,
                                          ),
                                        ),

                                      ):
                                      controller.isDownloaded.isTrue?
                                      Row(
                                        children: [
                                          Icon(Icons.check,color: Colors.green,),
                                          SizedBox(width: 10,),
                                          Flexible(child: Text("Downloaded".toString(),style: TextStyle(color: Colors.black,fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                        ],
                                      ):Container(),
                                      // _eService.isDownload==true?
                                      //    Row(
                                      //      children: [
                                      //        Icon(Icons.check,color: Colors.green,),
                                      //        SizedBox(width: 10,),
                                      //        Flexible(child: Text("Downloaded".toString(),style: TextStyle(color: Colors.black,fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                      //      ],
                                      //    ):Container(),
                                    ],
                                  )),
                            );
                        }
                      ));
            }
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5, top: 15),
              child: Container(
                height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
        });
  }

  Widget buildTitleView(EService _eService) {
    bool isDownload;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Text(
              controller.eService.value.name.toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
          Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Text(
                "₹ " +
                    controller.eService.value.price.toString() +
                    " / " +
                    controller.eService.value.priceUnit.toString(),
                textAlign: TextAlign.right,
                style: TextStyle(color: Color(0xff16377c)),
              )),
        ],
      ),
    );
    // return  FutureBuilder(
    //     future: EservicesData().EservicesDataLst(_eService.id),
    //     builder: (ctx,snapshot)
    //     {
    //       if(snapshot.hasData)
    //       {
    //         if(snapshot.data['data'] ==  null || snapshot.data['data'].length == 0)
    //         {
    //           return Padding(
    //             padding:  EdgeInsets.only(left: 20.0,right: 20,top: 15),
    //             child: Container(
    //               height: 60,
    //               padding: EdgeInsets.all(10),
    //               decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   border: Border.all(
    //                     color: Colors.grey.shade200,
    //
    //                   ),
    //                   borderRadius: BorderRadius.circular(10)
    //               ),
    //             ),
    //           );
    //         }
    //         else
    //         {
    //           return
    //             Container(
    //               height:130,
    //               padding: EdgeInsets.all(10),
    //               decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   //border: Border.all(color: Colors.grey.shade200,),
    //                   borderRadius: BorderRadius.circular(10)
    //               ),
    //
    //             child:
    //
    //           );
    //
    //
    //         }
    //       }
    //       else
    //       {
    //         return Padding(
    //           padding:  EdgeInsets.only(left: 5.0,right: 5,top: 15),
    //           child: Container(
    //             height: 60,
    //             padding: EdgeInsets.all(10),
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 border: Border.all(
    //                   color: Colors.grey.shade200,
    //
    //                 ),
    //                 borderRadius: BorderRadius.circular(10)
    //             ),
    //           ),
    //         );
    //       }
    //
    //     }
    // );
  }

  Widget buildDescriptionView(EService _eService) {
    bool isDownload;
    return FutureBuilder(
        future: EservicesData().EservicesDataLst(_eService.id),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null ||
                snapshot.data['data'].length == 0) {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            } else {
              return Container(
                height: 130,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    //border: Border.all(color: Colors.grey.shade200,),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data['data'][0]['name']['en'].toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("₹ " +
                        snapshot.data['data'][0]['price'].toString() +
                        " / " +
                        snapshot.data['data'][0]['price_unit'].toString()),
                  ],
                ),
              );
            }
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5, top: 15),
              child: Container(
                height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
        });
  }

  Widget buildBusinessDetails(EService _eService) {
    return FutureBuilder(
        future: EservicesData().EservicesDataLst(_eService.id),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null ||
                snapshot.data['data'].length == 0) {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Container(
                  height: 160,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: Card(
                  elevation: 2,
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10, top: 10, bottom: 10),
                      // padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(
                          //   color: Colors.grey.shade200,
                          // ),
                          borderRadius: BorderRadius.circular(0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          snapshot.data['data'][0]['add_awards'] == null
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Awards:",
                                        style: TextStyle(
                                            color:
                                                Get.theme.colorScheme.secondary,
                                            fontSize: 15)),
                                    SizedBox(width: 5),
                                    Flexible(
                                        child: Text(
                                      snapshot.data['data'][0]['add_awards'] ==
                                              null
                                          ? ""
                                          : snapshot.data['data'][0]
                                                  ['add_awards']
                                              .toString(),
                                      style: TextStyle(color: Colors.black),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ],
                                ),
                          SizedBox(height: 10),
                          snapshot.data['data'][0]['payment_method'] == null
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Payment method:",
                                        style: TextStyle(
                                            color:
                                                Get.theme.colorScheme.secondary,
                                            fontSize: 15)),
                                    SizedBox(width: 5),
                                    Text(
                                        snapshot.data['data'][0]
                                                    ['payment_method'] ==
                                                null
                                            ? ""
                                            : snapshot.data['data'][0]
                                                    ['payment_method']
                                                .toString(),
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                          SizedBox(height: 10),
                          snapshot.data['data'][0]['add_your_establishment'] ==
                                  null
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Establiment:",
                                        style: TextStyle(
                                            color:
                                                Get.theme.colorScheme.secondary,
                                            fontSize: 15)),
                                    SizedBox(width: 5),
                                    Text(
                                        snapshot.data['data'][0][
                                                    'add_your_establishment'] ==
                                                null
                                            ? ""
                                            : snapshot.data['data'][0]
                                                    ['add_your_establishment']
                                                .toString(),
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                          SizedBox(height: 10),
                          // Column(
                          //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //
                          //         children: [
                          //           Text("Establiment:"),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           Text(
                          //               snapshot.data['data'][0]
                          //                           ['add_your_establishment'] ==
                          //                       null
                          //                   ? ""
                          //                   : snapshot.data['data'][0]
                          //                           ['add_your_establishment']
                          //                       .toString(),
                          //               style: TextStyle(
                          //                   color:
                          //                       Get.theme.colorScheme.secondary)),
                          //         ],
                          //       ),
                        ],
                      )),
                ),
              );
            }
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
              child: Container(
                height: 160,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
        });
  }

  Widget buildGst(EService _eService) {
    return FutureBuilder(
        future: EservicesData().EservicesDataLst(_eService.id),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null ||
                snapshot.data['data'].length == 0) {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: Card(
                  elevation: 2,
                  child: Container(
                      height: 60,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(
                          //   color: Colors.grey.shade200,
                          // ),
                          borderRadius: BorderRadius.circular(0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "GST No:",
                                style: TextStyle(
                                    color: Get.theme.colorScheme.secondary,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                snapshot.data['data'][0]
                                            ['gst_no_uin_of_registered'] ==
                                        null
                                    ? ""
                                    : snapshot.data['data'][0]
                                            ['gst_no_uin_of_registered']
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              );
            }
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
              child: Container(
                height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
        });
  }

  Widget buildSocialmedia(EService _eService) {
    return FutureBuilder(
        future: EservicesData().EservicesDataLst(_eService.id),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null ||
                snapshot.data['data'].length == 0) {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            } else {
              return Padding(
                padding:
                    EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
                child: Container(
                  //height: 150,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.launchUrl(snapshot.data['data'][0]
                                      ['facebook_link']
                                  .toString());
                              // controller.launchUrl(_eService.facebook_link.toString());
                              // launchUrl(snapshot.data['data'][0]['facebook_link'].toString());
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xff3c599f),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                  child: Icon(
                                FontAwesomeIcons.facebookF,
                                color: Colors.white,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Facebook",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              //  launchUrl(snapshot.data['data'][0]['twitter_link'].toString());
                              controller.launchUrl(snapshot.data['data'][0]
                                      ['twitter_link']
                                  .toString());
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xff1da1f2),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                  child: Icon(
                                FontAwesomeIcons.twitter,
                                color: Colors.white,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Twitter",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.launchUrl(snapshot.data['data'][0]
                                      ['linkedin_link']
                                  .toString());

                              //launchUrl(snapshot.data['data'][0]['linkedin_link'].toString());
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xff0172b1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                  child: Icon(
                                FontAwesomeIcons.linkedinIn,
                                color: Colors.white,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Linkedin",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              //launchUrl(snapshot.data['data'][0]['instagram_link'].toString());
                              controller.launchUrl(snapshot.data['data'][0]
                                      ['instagram_link']
                                  .toString());
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xffdf0043),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                  child: Icon(
                                FontAwesomeIcons.instagram,
                                color: Colors.white,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Instagram",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // launchUrl(snapshot.data['data'][0]['bussiness_website'].toString());
                              controller.launchUrl(snapshot.data['data'][0]
                                      ['bussiness_website']
                                  .toString());
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(0xff0187b1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                  child: Image.asset('assets/img/w.png')),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Website",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
              child: Container(
                height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
        });
  }

  Widget buildContactUs(EService _eService) {
    // _mailto(String Url) async {
    //   final  url = 'mailto:'+Url+'?subject=Service Inquiry&body=';
    //   print("test url1");
    //   if (await canLaunch(url)) {
    //     print("test url2");
    //     await launch(url);
    //   } else {
    //     print("test url3");
    //     throw 'Could not launch $url';
    //   }
    // }

    return FutureBuilder(
        future: EservicesData().EservicesDataLst(_eService.id),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null ||
                snapshot.data['data'].length == 0) {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(left: 25.0, top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        launch("tel:" +
                            snapshot.data['data'][0]['mobile_number']
                                .toString());
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 25,
                        )),
                      ),
                    ),
                    // SizedBox(width: 10,),
                    // InkWell(
                    //   onTap: ()
                    //   {
                    //     _mailto("thilagavathikarnan@gmail.com");
                    //
                    //   },
                    //   child: Container(
                    //     padding:  EdgeInsets.all(8.0),
                    //
                    //     height: 40,
                    //     width: 40,
                    //     decoration: BoxDecoration(
                    //         color: Colors.red,
                    //         borderRadius: BorderRadius.circular(5)
                    //     ),
                    //     child:Center(child: Icon(Icons.mail,color: Colors.white,size: 25,)),
                    //
                    //   ),
                    // ),
                  ],
                ),
              );
            }
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
              child: Container(
                height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
        });
  }

  Widget buildCategories(EService _eService) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: List.generate(_eService.categories.length, (index) {
                var _category = _eService.categories.elementAt(index);
                return Container(
                  child: Text(_category.name,
                      style: Get.textTheme.bodyText1
                          .merge(TextStyle(color: _category.color))),
                  decoration: BoxDecoration(
                      color: _category.color.withOpacity(0.2),
                      border: Border.all(
                        color: _category.color.withOpacity(0.1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                );
              }) +
              List.generate(_eService.subCategories.length, (index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(_eService.subCategories.elementAt(index).name,
                      style: Get.textTheme.caption),
                  decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      border: Border.all(
                        color: Get.theme.focusColor.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                );
              }),
        ));
  }

  Widget buildPhotos(EService _eService) {
    return FutureBuilder(
        future: EservicesData().EservicesDataLst(_eService.id),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null ||
                snapshot.data['data'].length == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Icon(
                        Icons.image,
                        color: Colors.grey,
                      )),
                    ),
                  ),
                ],
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                  padding: EdgeInsets.all(5),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   border: Border.all(color: Colors.grey.shade50),
                  //   borderRadius: BorderRadius.circular(5),
                  // ),
                  // margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 1.0),
                              child: InkWell(
                                onTap: () {
                                  //  GetPage(page:()=> ImageViewPage());

                                  // Imageviews();
                                  //   Get.toNamed(Routes.GALLERY, arguments: {'media': snapshot.data['data'][0]['image'], 'current': _media, 'heroTag': 'e_services_galleries'});
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // border: Border.all(color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  //  child: Center(child: Icon(Icons.image,color: Colors.grey,)),
                                  child:
                                      snapshot.data['data'][0]['image'] == null
                                          ? Center(
                                              child: Icon(
                                              Icons.image,
                                              color: Colors.grey,
                                            ))
                                          : InkWell(
                                              onTap: () {
                                                String img = snapshot
                                                    .data['data'][0]['image']
                                                    .toString();
                                                if (img != null) {
                                                  Navigator.push(
                                                      ctx,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ImageViewPage(
                                                                  img: img)));
                                                }
                                              },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: CachedNetworkImage(
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                              // imageUrl: _service.firstImageUrl,
                                              imageUrl:snapshot.data['data'][0]['image'].toString(),
                                              placeholder: (context, url) => ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: LinearProgressIndicator(
                                                  color: Colors.grey.shade200,
                                                  backgroundColor: Colors.grey.shade50,
                                                ),
                                              ),
                                              errorWidget: (context, url, error) =>
                                                  Image.asset(
                                                    'assets/img/no_img_1.jpg',
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: 80,
                                                  ),
                                              // placeholder: (context, url) => Image.asset(
                                              //   'assets/img/loading.gif',
                                              //   fit: BoxFit.cover,
                                              //   width: double.infinity,
                                              //   height: 80,
                                              // ),
                                              // errorWidget: (context, url, error) => Icon(
                                              //   Icons.image_outlined,
                                              //   color: Colors.grey,
                                              //   size: 30,
                                              // ),
                                            ),
                                          ),
                                              // child: Image.network(
                                              //     snapshot.data['data'][0]['image'].toString()
                                              // )
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Icon(
                      Icons.image,
                      color: Colors.grey,
                    )),
                  ),
                ),
              ],
            );
          }
        });
  }

  Widget buildVideos(EService _eService) {
    var video;
    return FutureBuilder(
        future: EservicesData().EservicesDataLst(_eService.id),
        // future: videos,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null ||
                snapshot.data['data'].length == 0) {
              return Container(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Icon(
                          Icons.image,
                          color: Colors.grey,
                        )),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              video = snapshot.data['data'][0]['video'];
              _eService.videoPlayerController =
                  VideoPlayerController.network(video);
              _eService.videoPlayerController.initialize();
              _eService.startedPlaying = false;
              _eService.videoPlayerController.pause();
              return Padding(
                padding: EdgeInsets.all(20.0),
                child: video == null
                    ? Container(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.image,
                                  color: Colors.grey,
                                )),
                              ),
                            ),
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          String videoView = video.toString();
                          Navigator.push(
                              ctx,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PlayButton(videoView: videoView)));
                        },
                        child: Container(
                            width: 200,
                            child: Stack(
                             // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.cover,

                                  child: SizedBox(
                                    height: 120,
                                    width: 140,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),

                                      child: AspectRatio(

                                        aspectRatio: 20 / 10,
                                        // aspectRatio: _videoPlayerController.value.aspectRatio,
                                        child: VideoPlayer(
                                            _eService.videoPlayerController),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 45,
                                  left: 50,
                                  child: InkWell(
                                    onTap: ()
                                    {
                                      if(_eService.videoPlayerController.value.isPlaying){
                                        _eService.videoPlayerController.pause();
                                      }else{
                                        _eService.videoPlayerController.play();
                                      }
                                    },
                                    child: Container(
                                      // height: 30,
                                      // width: 30,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                      child:Center(
                                        child: Icon(_eService.videoPlayerController.value.isPlaying?Icons.pause:Icons.play_arrow,color: Colors.white,size: 35,)

                                      )
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
              );
            }
          } else {
            return Container(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Icon(
                        Icons.image,
                        color: Colors.grey,
                      )),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget buildServiceProvider(EService _eService) {
    if (_eService?.eProvider?.hasData ?? false) {
      return GestureDetector(
        onTap: () {
          Get.toNamed(Routes.E_PROVIDER, arguments: {
            'eProvider': _eService.eProvider,
            'heroTag': 'e_service_details'
          });
        },
        child: EServiceTilWidget(
          title: Text("Service Provider".tr, style: Get.textTheme.subtitle2),
          content: EProviderItemWidget(provider: _eService.eProvider),
          actions: [
            Text("View More".tr, style: Get.textTheme.subtitle1),
          ],
        ),
      );
    } else {
      return EServiceTilWidget(
        title: Text("Service Provider".tr, style: Get.textTheme.subtitle2),
        content: SizedBox(
          height: 60,
        ),
        actions: [],
      );
    }
  }

  Widget buildBottomWidget(EService _eService) {
    if (_eService.enableBooking == null || !_eService.enableBooking)
      return SizedBox();
    else
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5)),
          ],
        ),
        child: Row(
          children: [
            // if (_eService.priceUnit == 'fixed')
            //   Container(
            //     decoration: BoxDecoration(
            //       color: Get.theme.colorScheme.secondary.withOpacity(0.2),
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Row(
            //       textDirection: TextDirection.ltr,
            //       children: [
            //         MaterialButton(
            //           height: 24,
            //           minWidth: 46,
            //           onPressed: controller.decrementQuantity,
            //           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            //           color: Get.theme.colorScheme.secondary,
            //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(10))),
            //           child: Icon(Icons.remove, color: Get.theme.primaryColor, size: 28),
            //           elevation: 0,
            //         ),
            //         SizedBox(
            //           width: 38,
            //           child: Obx(() {
            //             return Text(
            //               controller.quantity.toString(),
            //               textAlign: TextAlign.center,
            //               style: Get.textTheme.subtitle2.merge(
            //                 TextStyle(color: Get.theme.colorScheme.secondary),
            //               ),
            //             );
            //           }),
            //         ),
            //         MaterialButton(
            //           onPressed: controller.incrementQuantity,
            //           height: 24,
            //           minWidth: 46,
            //           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            //           color: Get.theme.colorScheme.secondary,
            //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10))),
            //           child: Icon(Icons.add, color: Get.theme.primaryColor, size: 28),
            //           elevation: 0,
            //         ),
            //       ],
            //     ),
            //   ),
            // if (_eService.priceUnit == 'fixed') SizedBox(width: 10),
            Expanded(
              child: BlockButtonWidget(
                  text: Container(
                    height: 24,
                    alignment: Alignment.center,
                    child: Text(
                      "Book This Service".tr,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.headline6.merge(
                        TextStyle(color: Get.theme.primaryColor),
                      ),
                    ),
                  ),
                  color: Get.theme.colorScheme.secondary,
                  onPressed: () {
                    Get.toNamed(Routes.BOOK_E_SERVICE, arguments: {
                      'eService': _eService,
                      'options': controller.getCheckedOptions(),
                      'quantity': controller.quantity.value
                    });
                  }),
            ),
          ],
        ).paddingOnly(right: 20, left: 20),
      );
  }
}
