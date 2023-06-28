import 'package:bizmart/app/models/business_details_get_api/e_services_get_api.dart';
import 'package:bizmart/app/modules/enquiry_form.dart';
import 'package:bizmart/app/routes/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global_widgets/circular_loading_widget.dart';
import '../controllers/category_controller.dart';

class ServicesListWidget extends GetView<CategoryController> {
  ServicesListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // if(controller.eServices.isEmpty)
      // {
      //   return Obx(() {
      //     return
      //       CustomScrollView(
      //         primary: true,
      //         shrinkWrap: false,
      //         slivers:[
      //           SliverToBoxAdapter(
      //             child: Padding(
      //               padding:  EdgeInsets.all(8.0),
      //               child:  Container(
      //                 height: 400,
      //                 child: Center(
      //                     child: Text("")
      //                 ),
      //               ),
      //             ),
      //           ),
      //
      //           ],
      //
      //       );
      //   });
      //
      // }

      if (controller.isServiceLoading.isTrue) {
        print(
            "--------------------SERVICE LENGTH-----------------------------------");
        print(controller.eServices.length);
        print(controller.eServices);
        return CircularLoadingWidget(
          height: 300,
        );
      }
      else {
        if(controller.eServices.length == 0)
          {
            return Container(
              height: 300,
              child: Center(child: Text("Empty")),
            );

          }
        else
          {
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 10, top: 0),
              primary: false,
              shrinkWrap: true,
              //itemCount: controller.eServices.length,
              itemCount: controller.eServices.length,
              itemBuilder: ((_, index) {
                if (index == controller.eServices.length) {
                  return Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Center(
                        child: new Opacity(
                          opacity: controller.isLoading.value ? 1 : 0,
                          child: new CircularProgressIndicator(),
                        ),
                      ),
                    );
                  });
                } else {
                  var _service = controller.eServices.elementAt(index);
                  // return ServicesListItemWidget(service: _service);
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.E_SERVICE, arguments: {
                        'eService': _service,
                        'id': _service.id,
                        'heroTag': 'service_list_item'
                      });
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(left: 15.0,right: 15,top: 18),
                      child:  Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.grey.shade300
                            )
                        ),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: 'service_list_item' + _service.id,
                              child: Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    height: 120,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    // imageUrl: _service.firstImageUrl,
                                    imageUrl: _service.serviceImage.toString(),
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
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),

                                  Container(
                                    width:180,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            _service.name ?? '',
                                            style: TextStyle(fontSize: 16,color: Colors.black),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            // textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),

                                  Container(
                                    height: 30,
                                    width:180,

                                    child: FutureBuilder(
                                        future: controller.EservicesDataLst(_service.id),
                                        builder: (ctx, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data['data'] == null ||
                                                snapshot.data['data'].length == 0) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.0, right: 20, top: 15),
                                                child: Container(
                                                  height: 10,
                                                ),
                                              );
                                            } else {
                                              return Row(
                                                children: [
                                                  Flexible(
                                                    child: Row(
                                                      children: [
                                                        snapshot.data['data'][0]['address'] == null ? Container() : Icon(
                                                          Icons.location_on,
                                                          size: 20,
                                                          color: Get
                                                              .theme
                                                              .colorScheme
                                                              .secondary,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            snapshot.data['data'][0]['city'] == null ? "" : snapshot.data['data'][0]['city'].toString() + " - " + snapshot.data['data'][0]['district'].toString(),
                                                            style: TextStyle(
                                                                color: Colors.black),
                                                            maxLines: 2,
                                                            softWrap: true,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),




                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          } else {
                                            return Container();
                                          }
                                        }),
                                  ),
                                  SizedBox(height: 5),

                                  Container(
                                    height: 20,
                                    width:180,
                                    child: Row(
                                      children: [
                                        Text("4.0",style: TextStyle(color: Colors.black,fontSize: 12),),
                                        Icon(Icons.star,color: Colors.orange.shade700,size: 10,),
                                        Icon(Icons.star,color: Colors.orange.shade700,size: 10,),
                                        Icon(Icons.star_outline_sharp,color: Colors.grey,size: 10,)

                                      ],
                                    ),

                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width:200,

                                    child: FutureBuilder(
                                        future: controller.EservicesDataLst(_service.id),
                                        builder: (ctx, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data['data'] == null ||
                                                snapshot.data['data'].length == 0) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 20, top: 5),
                                                child: Container(),
                                              );
                                            } else {
                                              return Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      launch("tel:" +
                                                          snapshot.data['data']
                                                          [0][
                                                          'mobile_number']
                                                              .toString());
                                                    },
                                                    child: Container(
                                                        padding:
                                                        EdgeInsets.all(5.0),
                                                        // width: 90,
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10)),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  bottom:
                                                                  0.0),
                                                              child: Icon(
                                                                Icons.phone,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "Call now",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                  SizedBox(width: 12,),
                                                  InkWell(
                                                    onTap: () {
                                                      String service_name = _service.name.toString();
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EnquiryForm(service_name:service_name)));
                                                    },
                                                    child: Container(
                                                        padding:
                                                        EdgeInsets.all(5.0),
                                                        // width: 90,
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10)),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  bottom:
                                                                  0.0),
                                                              child: Icon(
                                                                Icons.quickreply_rounded,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "Enquiry",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14),
                                                            )
                                                          ],
                                                        )),
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
                                              );
                                            }
                                          } else {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20.0, right: 20, top: 15),
                                              child: Container(),
                                            );
                                          }
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }),
            );
          }


      }
    });
  }
}
