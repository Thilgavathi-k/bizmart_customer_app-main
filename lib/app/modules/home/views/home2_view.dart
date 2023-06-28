import 'package:bizmart/app/modules/global_widgets/filter_bottom_sheet_widget.dart';
import 'package:bizmart/app/modules/root/controllers/root_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/slide_model.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/address_widget.dart';
import '../../global_widgets/home_search_bar_widget.dart';
import '../../global_widgets/notifications_button_widget.dart';
import '../controllers/home_controller.dart';
import '../widgets/categories_carousel_widget.dart';
import '../widgets/featured_categories_widget.dart';
import '../widgets/recommended_carousel_widget.dart';
import '../widgets/slide_item_widget.dart';

class Home2View extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit an App?'),
          actions:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child:Text('No'),
                ),

                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child:Text('Yes'),
                ),
              ],
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        // appBar:PreferredSize(
        //   preferredSize: Size.fromHeight(300),
        //   child:
        // ),
        // appBar: AppBar(
        //   elevation: 0.0,
        //   backgroundColor: Colors.white,
        //
        //   //   physics: NeverScrollableScrollPhysics(),
        //
        //   iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        //   // title: Text(
        //   //   Get.find<SettingsService>().setting.value.appName,
        //   //   style: Get.textTheme.headline6,
        //   // ),
        //   title:  Image.asset('assets/img/bizLogo.png',height: 120,width: 120,),
        //   centerTitle: true,
        //   automaticallyImplyLeading: false,
        //   leading: new IconButton(icon:  Image.asset('assets/img/menu.png',height: 25,width: 25,), onPressed: () => {Scaffold.of(context).openDrawer()},),
        //   // actions: [NotificationsButtonWidget()],
        // // bottom: HomeSearchBarWidget(),
        //  actions: [ HomeSearchBarWidget(),],
        // ),
        body: RefreshIndicator(
            onRefresh: () async {
              Get.find<LaravelApiClient>().forceRefresh();
            //  await controller.refreshHome(showMessage: true);
              Get.find<LaravelApiClient>().unForceRefresh();
            },
            // child: SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       CustomScrollView(
            //         slivers: [
            //           SliverAppBar(
            //             pinned: true,
            //             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            //             expandedHeight: 300,
            //             elevation: 0.0,
            //             floating: true,
            //             //   physics: NeverScrollableScrollPhysics(),
            //
            //             iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            //             // title: Text(
            //             //   Get.find<SettingsService>().setting.value.appName,
            //             //   style: Get.textTheme.headline6,
            //             // ),
            //             title:  Image.asset('assets/img/bizLogo.png',height: 120,width: 120,),
            //             centerTitle: true,
            //             automaticallyImplyLeading: false,
            //             leading: new IconButton(icon:  Image.asset('assets/img/menu.png',height: 25,width: 25,), onPressed: () => {Scaffold.of(context).openDrawer()},),
            //             // actions: [NotificationsButtonWidget()],
            //             actions: [HomeSearchBarWidget()],
            //             // bottom: HomeSearchBarWidget(),
            //             flexibleSpace: FlexibleSpaceBar(
            //               collapseMode: CollapseMode.parallax,
            //               background: Obx(() {
            //                 return Stack(
            //                   alignment: controller.slider.isEmpty
            //                       ? AlignmentDirectional.center
            //                       : Ui.getAlignmentDirectional(controller.slider.elementAt(controller.currentSlide.value).textPosition),
            //                   children: <Widget>[
            //                     CarouselSlider(
            //                       options: CarouselOptions(
            //                         autoPlay: true,
            //                         autoPlayInterval: Duration(seconds: 7),
            //                         height: 200,
            //                         viewportFraction: 1.0,
            //                         onPageChanged: (index, reason) {
            //                           controller.currentSlide.value = index;
            //                         },
            //                       ),
            //                       items: controller.slider.map((Slide slide) {
            //                         return SlideItemWidget(slide: slide);
            //                       }).toList(),
            //                     ),
            //                     Container(
            //                       margin: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
            //                       child: Row(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         // mainAxisSize: MainAxisSize.min,
            //
            //                         children: controller.slider.map((Slide slide) {
            //                           return Container(
            //                             width: 5.0,
            //                             height: 5.0,
            //                             margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            //                             decoration: BoxDecoration(
            //                                 borderRadius: BorderRadius.all(
            //                                   Radius.circular(100),
            //                                 ),
            //                                 color: controller.currentSlide.value == controller.slider.indexOf(slide) ? slide.indicatorColor : slide.indicatorColor.withOpacity(0.4)),
            //                           );
            //                         }).toList(),
            //                       ),
            //                     ),
            //                   ],
            //                 );
            //               }),
            //             ).marginOnly(bottom: 42),
            //           ),
            //           Padding(
            //             padding:  EdgeInsets.all(15.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Row(
            //                   children: [
            //                     Image.asset('assets/img/menu.png',height: 25,width: 25,),
            //                     SizedBox(width: 10,),
            //                     Text("Categories".tr, style: Get.textTheme.headline5),
            //
            //                   ],
            //                 ),
            //                 InkWell(
            //                   onTap: () {
            //                     Get.toNamed(Routes.CATEGORIES);
            //                   },
            //                   // shape: StadiumBorder(),
            //                   // color: Get.theme.colorScheme.secondary.withOpacity(0.1),
            //                   child: Text("View All".tr, style: Get.textTheme.subtitle1),
            //
            //                 ),
            //               ],
            //             ),
            //           ),
            //           CategoriesCarouselWidget(),
            //           Container(
            //             color: Get.theme.primaryColor,
            //             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            //             child: Row(
            //               children: [
            //                 Expanded(child: Text("Recommended for you".tr, style: Get.textTheme.headline5)),
            //                 MaterialButton(
            //                   onPressed: () {
            //                     Get.toNamed(Routes.CATEGORIES);
            //                   },
            //                   shape: StadiumBorder(),
            //                   color: Get.theme.colorScheme.secondary.withOpacity(0.1),
            //                   child: Text("View All".tr, style: Get.textTheme.subtitle1),
            //                   elevation: 0,
            //                 ),
            //               ],
            //             ),
            //           ),
            //           RecommendedCarouselWidget(),
            //           FeaturedCategoriesWidget(),
            //         ],
            //       ),
            //       // Obx(() {
            //       //   return Stack(
            //       //    // alignment: controller.slider.isEmpty ? AlignmentDirectional.bottomCenter : Ui.getAlignmentDirectional(controller.slider.elementAt(controller.currentSlide.value).textPosition),
            //       //     alignment:  AlignmentDirectional.bottomStart ,
            //       //     children: <Widget>[
            //       //       CarouselSlider(
            //       //         options: CarouselOptions(
            //       //           autoPlay: true,
            //       //           autoPlayInterval: Duration(seconds: 7),
            //       //           height: 200,
            //       //           viewportFraction: 1.0,
            //       //           onPageChanged: (index, reason) {
            //       //             controller.currentSlide.value = index;
            //       //           },
            //       //         ),
            //       //         items: controller.slider.map((Slide slide) {
            //       //           return SlideItemWidget(slide: slide);
            //       //         }).toList(),
            //       //       ),
            //       //       Container(
            //       //         margin: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
            //       //         child: Row(
            //       //           mainAxisAlignment: MainAxisAlignment.start,
            //       //           crossAxisAlignment: CrossAxisAlignment.start,
            //       //          // mainAxisSize: MainAxisSize.min,
            //       //
            //       //           children: controller.slider.map((Slide slide) {
            //       //             return Container(
            //       //               width: 5.0,
            //       //               height: 5.0,
            //       //               margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            //       //               decoration: BoxDecoration(
            //       //                   borderRadius: BorderRadius.all(
            //       //                     Radius.circular(100),
            //       //                   ),
            //       //                   color: controller.currentSlide.value == controller.slider.indexOf(slide) ? slide.indicatorColor : slide.indicatorColor.withOpacity(0.4)),
            //       //             );
            //       //           }).toList(),
            //       //         ),
            //       //       ),
            //       //     ],
            //       //   );
            //       // }),
            //
            //     ],
            //   ),
            // ),
            child: CustomScrollView(
              primary: false,
              shrinkWrap: true,
              slivers: <Widget>[
                SliverAppBar(
                    pinned: true,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    expandedHeight: 280,
                    elevation: 0.0,
                    floating: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                    // title: Text(
                    //   Get.find<SettingsService>().setting.value.appName,
                    //   style: Get.textTheme.headline6,
                    // ),
                    title:  Image.asset('assets/img/bizLogo.png',height: 120,width: 120,),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    leading: new IconButton(
                      icon: new Icon(Icons.sort,
                          size: 30,
                          color: Get.theme.colorScheme.secondary),
                      onPressed: () => {Scaffold.of(context).openDrawer()},
                    ),

                    // leading: new IconButton(icon:
                    // Image.asset('assets/img/menu.png',height: 25,width: 25,),
                    //   onPressed: () => {Scaffold.of(context).openDrawer()},),
                    // actions: [NotificationsButtonWidget()],
                    actions: [HomeSearchBarWidget()],
                    // bottom: HomeSearchBarWidget(),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Obx(() {
                        return Stack(
                          alignment: controller.slider.isEmpty
                              ? AlignmentDirectional.center
                              : Ui.getAlignmentDirectional(controller.slider.elementAt(controller.currentSlide.value).textPosition),
                          children: <Widget>[
                            CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 7),
                                height: 280,
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  controller.currentSlide.value = index;
                                },
                              ),
                              items: controller.slider.map((Slide slide) {
                                return SlideItemWidget(slide: slide);
                              }).toList(),
                            ),
                            Positioned(
                              top:240,
                              left:20,
                              child: Container(
                                //   margin: EdgeInsets.symmetric(vertical: 190, horizontal: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: controller.slider.map((Slide slide) {
                                    return Container(
                                      width: 5.0,
                                      height: 5.0,
                                      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          color: controller.currentSlide.value == controller.slider.indexOf(slide) ? slide.indicatorColor : slide.indicatorColor.withOpacity(0.4)),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    )
                ),
                SliverToBoxAdapter(
                  child: Wrap(
                    children: [
                      // AddressWidget(),
                      Padding(
                        padding:  EdgeInsets.only(left: 18.0,right: 18,top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // Image.asset('assets/img/menu.png',height: 25,width: 25,),
                                // SizedBox(width: 10,),
                                Text("Categories", style: TextStyle(color:Colors.deepPurple.shade700,fontSize: 18 )),

                              ],
                            ),
                            InkWell(
                              onTap: ()
                              async {
                              Get.back();
                              await Get.find<RootController>().changePage(1);
                            },

                              // onTap: () {
                              //   //Get.toNamed(Routes.CATEGORIES);
                              // },
                              // shape: StadiumBorder(),
                              // color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                              child: Text("View All".tr, style: Get.textTheme.subtitle1),

                            ),
                          ],
                        ),
                      ),
                      CategoriesCarouselWidget(),
                      Padding(
                        padding:  EdgeInsets.only(left: 18.0,right: 18),
                        child: Container(

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('assets/img/banner.png',
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   color: Get.theme.primaryColor,
                      //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      //   child: Row(
                      //     children: [
                      //       Expanded(child: Text("Recommended for you".tr, style: Get.textTheme.headline5)),
                      //       MaterialButton(
                      //         onPressed: () {
                      //           Get.toNamed(Routes.CATEGORIES);
                      //         },
                      //         shape: StadiumBorder(),
                      //         color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                      //         child: Text("View All".tr, style: Get.textTheme.subtitle1),
                      //         elevation: 0,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // RecommendedCarouselWidget(),
                      // Padding(
                      //   padding:  EdgeInsets.only(left: 18.0,right: 18),
                      //   child: Container(
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(15),
                      //       child: Image.asset('assets/img/banners.png',
                      //         width: MediaQuery.of(context).size.width,
                      //         height: 100,
                      //         fit: BoxFit.fill,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      FeaturedCategoriesWidget(),
                    ],
                  ),
                ),
              ],
            )


        ),
      ),
    );
  }
}
