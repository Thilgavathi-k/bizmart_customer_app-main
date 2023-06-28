import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/e_service_model.dart';
import '../../../routes/app_routes.dart';

class ServicesCarouselWidget extends StatelessWidget {
  final List<EService> services;

  const ServicesCarouselWidget({Key key, List<EService> this.services})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: 10),
          primary: false,
          shrinkWrap: false,
          scrollDirection: Axis.horizontal,
          itemCount: services.length,
          itemBuilder: (_, index) {
            var _service = services.elementAt(index);
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.E_SERVICE, arguments: {
                  'eService': _service,
                  'heroTag': 'services_carousel'
                });
              },
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  // height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          height: 90,
                          width: 130,
                          fit: BoxFit.cover,
                          imageUrl: _service.firstImageUrl,
                          placeholder: (context, url) => ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: LinearProgressIndicator(
                              color: Colors.grey.shade200,
                              backgroundColor: Colors.grey.shade50,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/img/no_img_1.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 50,
                          ),
                          // placeholder: (context, url) => Image.asset(
                          //   'assets/img/loading.gif',
                          //   fit: BoxFit.cover,
                          //   width: double.infinity,
                          //   height: 50,
                          // ),
                          // errorWidget: (context, url, error) => Container(
                          //     height: 120,
                          //     width: 130,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(5),
                          //       border: Border.all(
                          //         color: Colors.grey.shade200,
                          //
                          //       )
                          //     ),
                          //     child: Icon(Icons.image_outlined,color: Colors.grey,size: 30,)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        _service.name,
                        maxLines: 1,
                        style: Get.textTheme.bodyText2
                            .merge(TextStyle(color: Get.theme.hintColor)),
                      ),
                      // Wrap(
                      //   children: Ui.getStarsList(_service.rate),
                      // ),
                      // SizedBox(height: 10),
                      // Wrap(
                      //   spacing: 5,
                      //   alignment: WrapAlignment.spaceBetween,
                      //   direction: Axis.horizontal,
                      //   crossAxisAlignment: WrapCrossAlignment.end,
                      //   children: [
                      //     Text(
                      //       "Start from".tr,
                      //       style: Get.textTheme.caption,
                      //     ),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.end,
                      //       children: [
                      //         if (_service.getOldPrice > 0)
                      //           Ui.getPrice(
                      //             _service.getOldPrice,
                      //             style: Get.textTheme.bodyText1.merge(TextStyle(color: Get.theme.focusColor, decoration: TextDecoration.lineThrough)),
                      //             unit: _service.getUnit,
                      //           ),
                      //         Ui.getPrice(
                      //           _service.getPrice,
                      //           style: Get.textTheme.bodyText2.merge(TextStyle(color: Get.theme.colorScheme.secondary)),
                      //           unit: _service.getUnit,
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              // child: Container(
              //   width: 150,
              //   margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 20, bottom: 10),
              //   // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //   decoration: BoxDecoration(
              //     //  color: Get.theme.focusColor.withOpacity(0.1),
              //     borderRadius: BorderRadius.all(Radius.circular(10)),
              //    // boxShadow: [BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),],
              //   ),
              //   child: Column(
              //     //alignment: AlignmentDirectional.topStart,
              //     children: [
              //       // Container(
              //       //   height: 100,
              //       //   width: 150,
              //       //   color: Get.theme.primaryColor,
              //       //   child: ClipRRect(
              //       //     borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              //       //     child: CachedNetworkImage(
              //       //       height: 80,
              //       //       width: 80,
              //       //       fit: BoxFit.cover,
              //       //       imageUrl: _service.firstImageUrl,
              //       //       placeholder: (context, url) => Image.asset(
              //       //         'assets/img/loading.gif',
              //       //         fit: BoxFit.cover,
              //       //         width: double.infinity,
              //       //         height: 50,
              //       //       ),
              //       //       errorWidget: (context, url, error) => Icon(Icons.error_outline),
              //       //     ),
              //       //   ),
              //       // ),
              //       Container(
              //         padding:  EdgeInsets.all(8),
              //         height: 180,
              //         width: 150,
              //         decoration: BoxDecoration(
              //           color: Get.theme.primaryColor,
              //           border: Border.all(
              //             color: Colors.grey.shade200,
              //             width: 1
              //           ),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: Column(
              //          // crossAxisAlignment: CrossAxisAlignment.stretch,
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             ClipRRect(
              //               borderRadius: BorderRadius.circular(5),
              //               child: CachedNetworkImage(
              //                 height: 120,
              //                 width: 120,
              //                 fit: BoxFit.fill,
              //                 imageUrl: _service.firstImageUrl,
              //                 placeholder: (context, url) => Image.asset(
              //                   'assets/img/loading.gif',
              //                   fit: BoxFit.cover,
              //                   width: double.infinity,
              //                   height: 50,
              //                 ),
              //                 errorWidget: (context, url, error) => Icon(Icons.error_outline),
              //               ),
              //             ),
              //             Text(
              //               _service.name,
              //               maxLines: 1,
              //               style: Get.textTheme.bodyText2.merge(TextStyle(color: Get.theme.hintColor)),
              //             ),
              //             Wrap(
              //               children: Ui.getStarsList(_service.rate),
              //             ),
              //            // SizedBox(height: 10),
              //             // Wrap(
              //             //   spacing: 5,
              //             //   alignment: WrapAlignment.spaceBetween,
              //             //   direction: Axis.horizontal,
              //             //   crossAxisAlignment: WrapCrossAlignment.end,
              //             //   children: [
              //             //     Text(
              //             //       "Start from".tr,
              //             //       style: Get.textTheme.caption,
              //             //     ),
              //             //     Column(
              //             //       crossAxisAlignment: CrossAxisAlignment.end,
              //             //       children: [
              //             //         if (_service.getOldPrice > 0)
              //             //           Ui.getPrice(
              //             //             _service.getOldPrice,
              //             //             style: Get.textTheme.bodyText1.merge(TextStyle(color: Get.theme.focusColor, decoration: TextDecoration.lineThrough)),
              //             //             unit: _service.getUnit,
              //             //           ),
              //             //         Ui.getPrice(
              //             //           _service.getPrice,
              //             //           style: Get.textTheme.bodyText2.merge(TextStyle(color: Get.theme.colorScheme.secondary)),
              //             //           unit: _service.getUnit,
              //             //         ),
              //             //       ],
              //             //     ),
              //             //   ],
              //             // )
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            );
          }),
    );
  }
}
