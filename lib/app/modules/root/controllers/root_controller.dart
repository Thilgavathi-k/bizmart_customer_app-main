/*
 * Copyright (c) 2020 .
 */

import 'package:bizmart/app/modules/category/controllers/categories_controller.dart';
import 'package:bizmart/app/modules/category/controllers/category_controller.dart';
import 'package:bizmart/app/modules/category/views/categories_view.dart';
import 'package:bizmart/app/modules/category/views/category_view.dart';
import 'package:bizmart/app/modules/global_widgets/notifications_button_widget.dart';
import 'package:bizmart/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:bizmart/app/modules/notifications/views/notifications_view.dart';
import 'package:bizmart/app/modules/search/controllers/search_controller.dart';
import 'package:bizmart/app/modules/search/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../models/custom_page_model.dart';
import '../../../repositories/custom_page_repository.dart';
import '../../../repositories/notification_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../account/views/account_view.dart';
import '../../bookings/controllers/bookings_controller.dart';
import '../../bookings/views/bookings_view.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home2_view.dart';
import '../../messages/controllers/messages_controller.dart';
import '../../messages/views/messages_view.dart';
import '../../profile/views/profile_view.dart';

class RootController extends GetxController {
  final currentIndex = 0.obs;
  final notificationsCount = 0.obs;
  final customPages = <CustomPage>[].obs;
  NotificationRepository _notificationRepository;
  CustomPageRepository _customPageRepository;

  RootController() {
    _notificationRepository = new NotificationRepository();
    _customPageRepository = new CustomPageRepository();
  }

  @override
  void onInit() async {
    super.onInit();
    await getCustomPages();
  }

  List<Widget> pages = [
    Home2View(),
    CategoriesView(),
   // BookingsView(),
    SearchView(), // MessagesView(),
  //  AccountView(),
    ProfileView()
  ];

  Widget get currentPage => pages[currentIndex.value];

  /**
   * change page in route
   * */
  Future<void> changePageInRoot(int _index) async {
    if (!Get.find<AuthService>().isAuth && _index > 0) {
     // await Get.toNamed(Routes.LOGIN);
      Fluttertoast.showToast(
          msg:"Need to login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor:Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0
      );
    } else {
      currentIndex.value = _index;
      await refreshPage(_index);
    }
  }

  Future<void> changePageOutRoot(int _index) async {
    if (!Get.find<AuthService>().isAuth && _index > 0) {
      //await Get.toNamed(Routes.LOGIN);
      Fluttertoast.showToast(
          msg:"Need to login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor:Get.theme.colorScheme.secondary,
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
    currentIndex.value = _index;
    await refreshPage(_index);
    await Get.offNamedUntil(Routes.ROOT, (Route route) {
      if (route.settings.name == Routes.ROOT) {
        return true;
      }
      return false;
    }, arguments: _index);
  }

  Future<void> changePage(int _index) async {
    if (Get.currentRoute == Routes.ROOT) {
      await changePageInRoot(_index);
    } else {
      await changePageOutRoot(_index);
    }
  }

  Future<void> refreshPage(int _index) async {
    switch (_index) {
      case 0:
        {
          await Get.find<HomeController>().refreshHome();
          break;
        }
      case 1:
        {

          await Get.put(CategoriesController(),permanent: true);
          //  await Get.find<CategoriesController>().refreshCategories();
          break;
        }
      case 2:
        {
          // if (Get.find<AuthService>().isAuth == true) {
          //   await  Get.toNamed(Routes.NOTIFICATIONS);
          // }
          // else {
          //   await  Get.toNamed(Routes.LOGIN);
          // }
         // await Get.find<MessagesController>().refreshMessages();
         await Get.put(SearchController(),permanent: true);
         //   await     NotificationsButtonWidget();
          break;
        }
    }
  }

  void getNotificationsCount() async {
    notificationsCount.value = await _notificationRepository.getCount();
  }

  Future<void> getCustomPages() async {
    customPages.assignAll(await _customPageRepository.all());
  }
}
