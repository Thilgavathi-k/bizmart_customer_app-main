import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/custom_bottom_nav_bar.dart';
import '../../global_widgets/main_drawer_widget.dart';
import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
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

    return Obx(() {
      return WillPopScope(
        onWillPop: showExitPopup, //call function on back button press

        child: Scaffold(
          drawer: Drawer(
            child: MainDrawerWidget(),
            elevation: 0,
          ),
          body: controller.currentPage,
          bottomNavigationBar: CustomBottomNavigationBar(
           // backgroundColor: context.theme.scaffoldBackgroundColor,
            backgroundColor:Color(0xff0c3469),
            itemColor: context.theme.colorScheme.secondary,
            currentIndex: controller.currentIndex.value,
            onChange: (index) {
              controller.changePage(index);
            },
            children: [
              CustomBottomNavigationItem(
               // icon: Icons.home_outlined,
                icon: Image.asset('assets/img/Footer Home.png',height: 20,width: 20,),
                label: "Home".tr,
              ),
              CustomBottomNavigationItem(
                icon: Image.asset('assets/img/footer cate.png',height: 20,width: 20,),
                label: "Category".tr,
              ),
              CustomBottomNavigationItem(
                //icon: Icons.chat_outlined,
                icon: Image.asset('assets/img/searchs.png',height: 20,width: 20,),
                label: "Search".tr,
              ),
              CustomBottomNavigationItem(
                icon: Image.asset('assets/img/footer profile.png',height: 20,width: 20,),
                // icon: Icons.person_outline,
                label: "Account".tr,
              ),
            ],
          ),
        ),
      );
    });
  }
}
