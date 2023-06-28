import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../controllers/home_controller.dart';
// class CategoriesCarouselWidget extends StatefulWidget {
//   const CategoriesCarouselWidget({Key key}) : super(key: key);
//
//   @override
//   State<CategoriesCarouselWidget> createState() => _CategoriesCarouselWidgetState();
// }
//
// class _CategoriesCarouselWidgetState extends State<CategoriesCarouselWidget> {
//   @override
//   //SliderRepository _sliderRepo;
//   CategoryRepository _categoryRepository;
//  // EServiceRepository _eServiceRepository;
//
//  // final addresses = <Address>[].obs;
//  // final slider = <Slide>[].obs;
//   //final currentSlide = 0.obs;
//
//   //final eServices = <EService>[].obs;
//   final categories = <Category>[].obs;
//   final featured = <Category>[].obs;
//
//   HomeController() {
//   //  _sliderRepo = new SliderRepository();
//     _categoryRepository = new CategoryRepository();
//    // _eServiceRepository = new EServiceRepository();
//   }
//
//   bool showmore = false;
//   var length;
//   var category = [];
//   Future getCategories() async {
//     try {
//       categories.assignAll(await _categoryRepository.getAllParents());
//       print("++++++++++++++++++++++++++CATEGORY+++++++++++++++++++++++++++++++++++++");
//    //   print(controller.categories);
//       print(categories.length);
//     } catch (e) {
//       Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
//     }
//   }
//
//   void initState()
//   {
//     super.initState();
//    // getCategories();
//
//     CategoriesData().CategoryData().then((val)
//         {
//           setState(() {
//             length = val['data'].length;
//             category = val['data'];
//             print("++++++++++++++++++++++++++CATEGORY2+++++++++++++++++++++++++++++++++++++");
//             print(val['data']);
//             print(val['data'].length);
//             print(length);
//             print("++++++++++++++++++++++++++\\CATEGORY//+++++++++++++++++++++++++++++++++++++");
//             print(category);
//
//
//           });
//         }
//     );
//   }
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:  EdgeInsets.all(20.0),
//       child: showmore == true ?
//       Column(
//       children: [
//         Container(
//             height: 300,
//             margin: EdgeInsets.only(bottom: 15),
//             child:  GridView.builder(
//               // primary: false,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 // scrollDirection: Axis.horizontal,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     childAspectRatio: 0.800,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     crossAxisCount: 4
//                 ),
//                 itemCount:category.length,
//                 itemBuilder: (_, index) {
//                   var _category = category.elementAt(index);
//                   var categories= category[index]['media'][0].elementAt(index);
//                   return InkWell(
//                     onTap: () {
//                       Get.toNamed(Routes.CATEGORY, arguments: categories);
//                     },
//                     child: Padding(
//                       padding:  EdgeInsets.all(1.0),
//                       child: Container(
//                         width: 250,
//                         // color: Colors.blue,
//
//                         //  color: Colors.green,
//                         // height: 100,
//                         // margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0),
//                         // padding: EdgeInsets.symmetric(vertical: 10),
//                         // decoration: new BoxDecoration(
//                         //   gradient: new LinearGradient(
//                         //       colors: [_category.color.withOpacity(1), _category.color.withOpacity(0.1)],
//                         //       begin: AlignmentDirectional.topStart,
//                         //       //const FractionalOffset(1, 0),
//                         //       end: AlignmentDirectional.bottomEnd,
//                         //       stops: [0.1, 0.9],
//                         //       tileMode: TileMode.clamp),
//                         //   borderRadius: BorderRadius.all(Radius.circular(10)),
//                         // ),
//                         child: Column(
//                           //  alignment: AlignmentDirectional.topStart,
//                           children: [
//                             // Text(category[index]['media'][0]['name'].toString())
//                             ClipRRect(
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               child: (category[index]['media'][0]['thumb'].toLowerCase().endsWith('.svg')
//                                   ? SvgPicture.network(
//                                 category[index]['media'][0]['thumb'].toString(),
//                                 height: 40,
//                                 width: 40,
//                                 color: categories.color,
//                               )
//                                   : CachedNetworkImage(
//                                 fit: BoxFit.cover,
//                                 imageUrl: category[index]['media'][0]['thumb'],
//                                 height: 40,
//                                 width: 40,
//                                 placeholder: (context, url) => Image.asset(
//                                   'assets/img/loading.gif',
//                                   fit: BoxFit.cover,
//                                 ),
//                                 errorWidget: (context, url, error) => Icon(Icons.error_outline),
//                               )),
//                             ),
//                             SizedBox(height: 5,),
//                             Container(
//                               width: 300,
//                               alignment: Alignment.center,
//                               child: Text(
//                                 category[index]['media'][0]['name'],
//                                 maxLines: 1,
//                                 //style: Get.textTheme.bodyText2.merge(TextStyle(color: Colors.black)),
//                                 style: TextStyle(fontSize: 10,color: Colors.black,
//                                     overflow: TextOverflow.ellipsis
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                     ),
//                   );
//                 })
//         ),
//         SizedBox(height: 10,),
//         InkWell(
//           onTap: ()
//           {
//             setState(() {
//               showmore = false;
//             });
//           },
//             child: Icon(Icons.arrow_back_ios_rounded)
//
//
//         )
//       ],
//       ):
//       Container(
//        // height: 300,
//         margin: EdgeInsets.only(bottom: 15),
//         child: GridView.builder(
//           // primary: false,
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             // scrollDirection: Axis.horizontal,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 childAspectRatio: 0.700,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 crossAxisCount: 4
//             ),
//             itemCount:category.length,
//             itemBuilder: (BuildContext, index) {
//               return InkWell(
//                 onTap: () {
//                   var _category = category.elementAt(index);
//
//                   print("+++++++++++++++++++++++++++++PRESS++++++++++++++++++");
//                   print(_category);
//                  Get.toNamed(Routes.CATEGORY, arguments: _category);
//                 },
//                 child: index == 11?
//                 GestureDetector(
//                   onTap: ()
//                   {
//                     setState(()
//                     {
//                       print("++++++++++++++++++++++++++++++++++SHOW MORE+++++++++++++++++++++++++");
//                       showmore = true;
//                       print(showmore);
//                     });
//                   },
//                   child: Container(
//                     width: 250,
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                               color: Colors.blue.shade100,
//                               borderRadius: BorderRadius.circular(100)
//                           ),
//                           child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: Colors.blue,)),
//
//                         ),
//                         SizedBox(height: 5,),
//                         Text("Show more",style: TextStyle(color: Colors.black,fontSize: 10),)
//                       ],
//                     ),
//                   ),
//                 ):
//                 Padding(
//                   padding:  EdgeInsets.all(1.0),
//                   child: Container(
//                     width: 250,
//                     //  color: Colors.green,
//                     // height: 100,
//                     // margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0),
//                     // padding: EdgeInsets.symmetric(vertical: 10),
//                     // decoration: new BoxDecoration(
//                     //   gradient: new LinearGradient(
//                     //       colors: [_category.color.withOpacity(1), _category.color.withOpacity(0.1)],
//                     //       begin: AlignmentDirectional.topStart,
//                     //       //const FractionalOffset(1, 0),
//                     //       end: AlignmentDirectional.bottomEnd,
//                     //       stops: [0.1, 0.9],
//                     //       tileMode: TileMode.clamp),
//                     //   borderRadius: BorderRadius.all(Radius.circular(10)),
//                     // ),
//                     child: Column(
//                       //  alignment: AlignmentDirectional.topStart,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           child: (category[index]['media'][0]['thumb'].toLowerCase().endsWith('.svg')
//                               ? SvgPicture.network(
//                             category[index]['media'][0]['thumb'].toString(),
//                             height: 40,
//                             width: 40,
//                            // color: _category.color,
//                           )
//                               : CachedNetworkImage(
//                             fit: BoxFit.cover,
//                             imageUrl: category[index]['media'][0]['thumb'],
//                             height: 40,
//                             width: 40,
//                             placeholder: (context, url) => Image.asset(
//                               'assets/img/loading.gif',
//                               fit: BoxFit.cover,
//                             ),
//                             errorWidget: (context, url, error) => Icon(Icons.error_outline),
//                           )),
//                         ),
//                         SizedBox(height: 5,),
//                         Container(
//                           width: 300,
//                           alignment: Alignment.center,
//                           child: Text(
//                             category[index]['media'][0]['name'].toString(),
//                             maxLines: 1,
//                             //style: Get.textTheme.bodyText2.merge(TextStyle(color: Colors.black)),
//                             style: TextStyle(fontSize: 10,color: Colors.black,
//                                 overflow: TextOverflow.ellipsis
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//
//                 ,
//               );
//             }),
//         // child: Obx(() {
//         //   return GridView.builder(
//         //     // primary: false,
//         //       shrinkWrap: true,
//         //       physics: NeverScrollableScrollPhysics(),
//         //       // scrollDirection: Axis.horizontal,
//         //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         //           childAspectRatio: 0.700,
//         //           crossAxisSpacing: 10,
//         //           mainAxisSpacing: 10,
//         //           crossAxisCount: 4
//         //       ),
//         //       itemCount:category.length,
//         //       itemBuilder: (BuildContext, index) {
//         //         var _category =category.elementAt(index);
//         //         return InkWell(
//         //           onTap: () {
//         //             Get.toNamed(Routes.CATEGORY, arguments: _category);
//         //           },
//         //           child: index == 11?
//         //           GestureDetector(
//         //             onTap: ()
//         //             {
//         //               setState(()
//         //               {
//         //                 print("++++++++++++++++++++++++++++++++++SHOW MORE+++++++++++++++++++++++++");
//         //                 showmore = true;
//         //                 print(showmore);
//         //               });
//         //               },
//         //             child: Container(
//         //               width: 250,
//         //               child: Column(
//         //                 children: [
//         //                   Container(
//         //                     height: 40,
//         //                     width: 40,
//         //                     decoration: BoxDecoration(
//         //                         color: Colors.blue.shade100,
//         //                         borderRadius: BorderRadius.circular(100)
//         //                     ),
//         //                     child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: Colors.blue,)),
//         //
//         //                   ),
//         //                   SizedBox(height: 5,),
//         //                   Text("Show more",style: TextStyle(color: Colors.black,fontSize: 10),)
//         //                 ],
//         //               ),
//         //             ),
//         //           ):
//         //           Padding(
//         //             padding:  EdgeInsets.all(1.0),
//         //             child: Container(
//         //               width: 250,
//         //               //  color: Colors.green,
//         //               // height: 100,
//         //               // margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0),
//         //               // padding: EdgeInsets.symmetric(vertical: 10),
//         //               // decoration: new BoxDecoration(
//         //               //   gradient: new LinearGradient(
//         //               //       colors: [_category.color.withOpacity(1), _category.color.withOpacity(0.1)],
//         //               //       begin: AlignmentDirectional.topStart,
//         //               //       //const FractionalOffset(1, 0),
//         //               //       end: AlignmentDirectional.bottomEnd,
//         //               //       stops: [0.1, 0.9],
//         //               //       tileMode: TileMode.clamp),
//         //               //   borderRadius: BorderRadius.all(Radius.circular(10)),
//         //               // ),
//         //               child: Column(
//         //                 //  alignment: AlignmentDirectional.topStart,
//         //                 children: [
//         //                   ClipRRect(
//         //                     borderRadius: BorderRadius.all(Radius.circular(10)),
//         //                     child: (category[index]['media'][0]['thumb'].toLowerCase().endsWith('.svg')
//         //                         ? SvgPicture.network(
//         //                       category[index]['media'][0]['thumb'].toString(),
//         //                       height: 40,
//         //                       width: 40,
//         //                       color: _category.color,
//         //                     )
//         //                         : CachedNetworkImage(
//         //                       fit: BoxFit.cover,
//         //                       imageUrl: category[index]['media'][0]['thumb'],
//         //                       height: 40,
//         //                       width: 40,
//         //                       placeholder: (context, url) => Image.asset(
//         //                         'assets/img/loading.gif',
//         //                         fit: BoxFit.cover,
//         //                       ),
//         //                       errorWidget: (context, url, error) => Icon(Icons.error_outline),
//         //                     )),
//         //                   ),
//         //                   SizedBox(height: 5,),
//         //                   Container(
//         //                     width: 300,
//         //                     alignment: Alignment.center,
//         //                     child: Text(
//         //                       category[index]['media'][0]['name'].toString(),
//         //                       maxLines: 1,
//         //                       //style: Get.textTheme.bodyText2.merge(TextStyle(color: Colors.black)),
//         //                       style: TextStyle(fontSize: 10,color: Colors.black,
//         //                           overflow: TextOverflow.ellipsis
//         //                       ),
//         //                     ),
//         //                   ),
//         //                 ],
//         //               ),
//         //             ),
//         //           )
//         //
//         //           ,
//         //         );
//         //       });
//         // }),
//       ),
//     );  }
// }

class CategoriesCarouselWidget extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    bool showmore = false;
    int length = 15;
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20),
      child: showmore == true
          ? Container(
              //  margin: EdgeInsets.only(bottom: 15),
              child: Obx(() {
                return GridView.builder(
                    // primary: false,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.700,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 4),
                    itemCount: controller.categories.length,
                    itemBuilder: (_, index) {
                      print("CAskdlkdlkslkl");
                      print("CATGORY ${index}");
                      print(controller.categories[index].featured);
                      if(controller.categories[index].featured == true)
                        {
                          var _category = controller.categories.elementAt(index);
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.CATEGORY, arguments: _category);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Container(
                                width: 250,
                                //  color: Colors.green,
                                // height: 100,
                                // margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0),
                                // padding: EdgeInsets.symmetric(vertical: 10),
                                // decoration: new BoxDecoration(
                                //   gradient: new LinearGradient(
                                //       colors: [_category.color.withOpacity(1), _category.color.withOpacity(0.1)],
                                //       begin: AlignmentDirectional.topStart,
                                //       //const FractionalOffset(1, 0),
                                //       end: AlignmentDirectional.bottomEnd,
                                //       stops: [0.1, 0.9],
                                //       tileMode: TileMode.clamp),
                                //   borderRadius: BorderRadius.all(Radius.circular(10)),
                                // ),
                                child: Column(
                                  //  alignment: AlignmentDirectional.topStart,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      child: (_category.image.url
                                          .toLowerCase()
                                          .endsWith('.svg')
                                          ? SvgPicture.network(
                                        _category.image.url,
                                        height: 40,
                                        width: 40,
                                        color: _category.color,
                                      )
                                          : CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: _category.image.url,
                                        height: 40,
                                        width: 40,
                                        placeholder: (context, url) =>
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              child: LinearProgressIndicator(
                                                color: Colors.grey.shade200,
                                                backgroundColor:
                                                Colors.grey.shade50,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                              'assets/img/no_img_1.jpg',
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                              width: double.infinity,
                                              height: 40,
                                            ),
                                        // placeholder: (context, url) => Image.asset(
                                        //   'assets/img/loading.gif',
                                        //   fit: BoxFit.cover,
                                        // ),
                                        // errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                      )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 300,
                                      alignment: Alignment.center,
                                      child: Text(
                                        _category.name,
                                        maxLines: 1,
                                        //style: Get.textTheme.bodyText2.merge(TextStyle(color: Colors.black)),
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      else
                        {
                          return Container();
                        }

                    });
              }),
            )
          : Container(
              // height: 350,
              margin: EdgeInsets.only(bottom: 15),
              child: Obx(() {
                // return GridView.builder(
                //     // primary: false,
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     // scrollDirection: Axis.horizontal,
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         childAspectRatio: 0.700,
                //         crossAxisSpacing: 10,
                //         mainAxisSpacing: 10,
                //         crossAxisCount: 4),
                //     itemCount: controller.categories.length,
                //     itemBuilder: (BuildContext, index) {
                //       if(controller.categories[index].featured == true)
                //         {
                //           var _category = controller.categories.elementAt(index);
                //           return InkWell(
                //             onTap: () {
                //               showmore = true;
                //
                //               Get.toNamed(Routes.CATEGORY, arguments: _category);
                //             },
                //             child: Padding(
                //               padding: EdgeInsets.all(1.0),
                //               child: Container(
                //                 width: 300,
                //
                //                 //  color: Colors.green,
                //                 // height: 100,
                //                 // margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0),
                //                 // padding: EdgeInsets.symmetric(vertical: 10),
                //                 // decoration: new BoxDecoration(
                //                 //   gradient: new LinearGradient(
                //                 //       colors: [_category.color.withOpacity(1), _category.color.withOpacity(0.1)],
                //                 //       begin: AlignmentDirectional.topStart,
                //                 //       //const FractionalOffset(1, 0),
                //                 //       end: AlignmentDirectional.bottomEnd,
                //                 //       stops: [0.1, 0.9],
                //                 //       tileMode: TileMode.clamp),
                //                 //   borderRadius: BorderRadius.all(Radius.circular(10)),
                //                 // ),
                //                 child: Column(
                //                   //  alignment: AlignmentDirectional.topStart,
                //                   children: [
                //                     Container(
                //                       padding: EdgeInsets.all(4),
                //                       height: 60,
                //                       width: 60,
                //                       decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           border: Border.all(
                //                               color: Colors.grey.shade200,
                //                               width: 1),
                //                           borderRadius: BorderRadius.circular(100)),
                //                       child: ClipRRect(
                //                         borderRadius:
                //                         BorderRadius.all(Radius.circular(10)),
                //                         child: (_category.image.url
                //                             .toLowerCase()
                //                             .endsWith('.svg')
                //                             ? SvgPicture.network(
                //                           _category.image.url,
                //                           height: 45,
                //                           width: 45,
                //                           color: _category.color,
                //                         )
                //                             : CachedNetworkImage(
                //                           fit: BoxFit.cover,
                //                           imageUrl: _category.image.url,
                //                           height: 45,
                //                           width: 45,
                //                           placeholder: (context, url) =>
                //                               Image.asset(
                //                                 'assets/img/loading.gif',
                //                                 fit: BoxFit.cover,
                //                               ),
                //                           errorWidget:
                //                               (context, url, error) => Icon(
                //                             Icons.image_outlined,
                //                             color: Colors.grey,
                //                           ),
                //                         )),
                //                       ),
                //                     ),
                //                     SizedBox(
                //                       height: 5,
                //                     ),
                //                     Container(
                //                       width: 300,
                //                       alignment: Alignment.center,
                //                       child: Text(
                //                         _category.name,
                //                         maxLines: 1,
                //                         //style: Get.textTheme.bodyText2.merge(TextStyle(color: Colors.black)),
                //                         style: TextStyle(
                //                             fontSize: 10,
                //                             color: Colors.black,
                //                             overflow: TextOverflow.ellipsis),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           );
                //         }
                //       else
                //         {
                //           return Container();
                //         }
                //
                //     });
                return GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.700,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 4),
                    physics: NeverScrollableScrollPhysics(),
                    children:[
                      for(int i = 0; i< controller.categories.length; i++)
                        if(controller.categories[i].featured == true)
                          InkWell(
                            onTap: () {
                              showmore = true;

                              Get.toNamed(Routes.CATEGORY, arguments: controller.categories[i]);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Container(
                                width: 300,

                                //  color: Colors.green,
                                // height: 100,
                                // margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0),
                                // padding: EdgeInsets.symmetric(vertical: 10),
                                // decoration: new BoxDecoration(
                                //   gradient: new LinearGradient(
                                //       colors: [_category.color.withOpacity(1), _category.color.withOpacity(0.1)],
                                //       begin: AlignmentDirectional.topStart,
                                //       //const FractionalOffset(1, 0),
                                //       end: AlignmentDirectional.bottomEnd,
                                //       stops: [0.1, 0.9],
                                //       tileMode: TileMode.clamp),
                                //   borderRadius: BorderRadius.all(Radius.circular(10)),
                                // ),
                                child: Column(
                                  //  alignment: AlignmentDirectional.topStart,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey.shade200,
                                              width: 1),
                                          borderRadius: BorderRadius.circular(100)),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                        child: (controller.categories[i].image.url
                                            .toLowerCase()
                                            .endsWith('.svg')
                                            ? SvgPicture.network(
                                          controller.categories[i].image.url,
                                          height: 45,
                                          width: 45,
                                          color: controller.categories[i].color,
                                        )
                                            : CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: controller.categories[i].image.url,
                                          height: 45,
                                          width: 45,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                'assets/img/loading.gif',
                                                fit: BoxFit.cover,
                                              ),
                                          errorWidget:
                                              (context, url, error) => Icon(
                                            Icons.image_outlined,
                                            color: Colors.grey,
                                          ),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 300,
                                      alignment: Alignment.center,
                                      child: Text(
                                        controller.categories[i].name,
                                        maxLines: 1,
                                        //style: Get.textTheme.bodyText2.merge(TextStyle(color: Colors.black)),
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )



                    ]
                );

              }),
            ),
    );
  }
}
