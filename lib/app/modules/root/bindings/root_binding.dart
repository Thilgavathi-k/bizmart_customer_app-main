import 'package:bizmart/app/modules/global_widgets/notifications_button_widget.dart';
import 'package:bizmart/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:bizmart/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../account/controllers/account_controller.dart';
import '../../bookings/controllers/booking_controller.dart';
import '../../bookings/controllers/bookings_controller.dart';
import '../../category/controllers/categories_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../messages/controllers/messages_controller.dart';
import '../../search/controllers/search_controller.dart';
import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  bool home_val = true;
  void dependencies() {
    Get.lazyPut<RootController>(
      () => RootController(),
    );
    Get.put(HomeController(), permanent: true);
   //Get.put(CategoriesController(), permanent: true);

    Get.lazyPut<CategoriesController>(
      () => CategoriesController(),
    );
    Get.lazyPut<SearchController>(() => SearchController(),);
    // Get.lazyPut<NotificationsController>(
    //   () => NotificationsController(),
    // );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    // Get.lazyPut<SearchController>(
    //   () => SearchController(),
    // );
  }
}
