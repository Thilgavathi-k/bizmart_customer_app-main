import 'package:bizmart/app/modules/global_widgets/home_search_bar_widget.dart';
import 'package:bizmart/app/modules/root/controllers/root_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../providers/laravel_provider.dart';
import '../controllers/category_controller.dart';
import '../widgets/services_list_widget.dart';

class CategoryView extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0.0,
        primary: true,
        iconTheme: IconThemeData(color: Get.theme.primaryColor),
        title: Text(
          controller.category.value.name,
          style: Get.textTheme.headline6.merge(TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
            // Get.back()
          },
        ),
      //  bottom: HomeSearchBarWidget(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding:  EdgeInsets.only(left: 18.0,right: 18,),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey.shade300
                ),


              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
               onTap: ()
               async {
                Get.back();
                  await Get.find<RootController>().changePage(2);
                   },
                    child: Container(
                        height: 20,width: 20,
                        child: Image.asset('assets/img/search.png',height: 25,width: 25,color: Colors.grey.shade400,)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<LaravelApiClient>().forceRefresh();
          controller.refreshEServices(showMessage: true);
          Get.find<LaravelApiClient>().unForceRefresh();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              ServicesListWidget(),

            ],
          ),
        ),
        // child: CustomScrollView(
        //   controller: controller.scrollController,
        //   shrinkWrap: false,
        //   slivers: <Widget>[
        //     SliverAppBar(
        //       backgroundColor: Get.theme.scaffoldBackgroundColor,
        //       expandedHeight: 60,
        //       elevation: 0.5,
        //       primary: true,
        //       // pinned: true,
        //       floating: true,
        //       iconTheme: IconThemeData(color: Get.theme.primaryColor),
        //       title: Text(
        //         controller.category.value.name,
        //         style: Get.textTheme.headline6.merge(TextStyle(color: Colors.black)),
        //       ),
        //       centerTitle: true,
        //       automaticallyImplyLeading: false,
        //       leading: new IconButton(
        //         icon: new Icon(Icons.arrow_left,
        //             size: 40,
        //             color: Colors.black),
        //         onPressed: () {
        //           Navigator.pop(context);
        //           // Get.back()
        //         },
        //       ),
        //         bottom: HomeSearchBarWidget(),
        //       // flexibleSpace: FlexibleSpaceBar(
        //       //     collapseMode: CollapseMode.parallax,
        //       //     background: Stack(
        //       //       alignment: AlignmentDirectional.bottomCenter,
        //       //       children: [
        //       //         Container(
        //       //           width: double.infinity,
        //       //           padding: EdgeInsets.only(top: 75, bottom: 115),
        //       //           decoration: new BoxDecoration(
        //       //             gradient: new LinearGradient(
        //       //                 colors: [
        //       //                   controller.category.value.color.withOpacity(1),
        //       //                   controller.category.value.color.withOpacity(0.2)
        //       //                 ],
        //       //                 begin: AlignmentDirectional.topStart,
        //       //                 //const FractionalOffset(1, 0),
        //       //                 end: AlignmentDirectional.bottomEnd,
        //       //                 stops: [0.1, 0.9],
        //       //                 tileMode: TileMode.clamp),
        //       //             borderRadius: BorderRadius.only(
        //       //                 topLeft: Radius.circular(5),
        //       //                 topRight: Radius.circular(5)),
        //       //           ),
        //       //           child: (controller.category.value.image.url
        //       //                   .toLowerCase()
        //       //                   .endsWith('.svg')
        //       //               ? SvgPicture.network(
        //       //                   controller.category.value.image.url,
        //       //                   color: controller.category.value.color,
        //       //                 )
        //       //               : CachedNetworkImage(
        //       //                   fit: BoxFit.fitHeight,
        //       //                   imageUrl: controller.category.value.image.url,
        //       //                   placeholder: (context, url) => Image.asset(
        //       //                     'assets/img/loading.gif',
        //       //                     fit: BoxFit.fitHeight,
        //       //                   ),
        //       //                   errorWidget: (context, url, error) =>
        //       //                       Icon(Icons.error_outline),
        //       //                 )),
        //       //         ),
        //       //         //AddressWidget().paddingOnly(bottom: 75),
        //       //       ],
        //       //     )).marginOnly(bottom: 20),
        //     ),
        //     SliverToBoxAdapter(
        //       child: Wrap(
        //         children: [
        //           // Container(
        //           //   height: 60,
        //           //   child: ListView(
        //           //       primary: false,
        //           //       shrinkWrap: true,
        //           //       scrollDirection: Axis.horizontal,
        //           //     //  CategoryFilter.values.length
        //           //       children: List.generate(1, (index) {
        //           //         var _filter = CategoryFilter.values.elementAt(index);
        //           //         return Obx(() {
        //           //
        //           //           return Padding(
        //           //             padding:  EdgeInsetsDirectional.only(start: 0),
        //           //             child: RawChip(
        //           //               elevation: 0,
        //           //               label: Text(''.toString().tr),
        //           //               labelStyle: TextStyle(color: Colors.black,fontSize:18),
        //           //              // labelStyle: controller.isSelected(_filter) ? Get.textTheme.bodyText2.merge(TextStyle(color: Get.theme.primaryColor)) : Get.textTheme.bodyText2,
        //           //               padding: EdgeInsets.all(5),
        //           //             //  backgroundColor: Theme.of(context).focusColor.withOpacity(0.1),
        //           //               backgroundColor: Colors.white,
        //           //              // selectedColor: controller.category.value.color,
        //           //               selectedColor: Colors.white,
        //           //               selected: controller.isSelected(_filter),
        //           //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //           //               showCheckmark: true,
        //           //               checkmarkColor: Get.theme.primaryColor,
        //           //               onSelected: (bool value) {
        //           //                 controller.toggleSelected(_filter);
        //           //                 controller.loadEServicesOfCategory(controller.category.value.id, filter: controller.selected.value);
        //           //               },
        //           //             ),
        //           //           );
        //           //         });
        //           //       })),
        //           // ),
        //
        //           // controller.eServices.isEmpty ?
        //           //     Container(
        //           //       height: 300,
        //           //         child: Center(child: Text("No data found"))):
        //           ServicesListWidget(),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
