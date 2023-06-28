import 'dart:convert';
import 'dart:io';
import 'package:bizmart/app/models/const_bse_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../../../common/ui.dart';
import '../../../models/e_service_model.dart';
import '../../../models/favorite_model.dart';
import '../../../models/option_group_model.dart';
import '../../../models/option_model.dart';
import '../../../models/review_model.dart';
import '../../../repositories/e_service_repository.dart';
import '../../../services/auth_service.dart';
import '../../../services/global_service.dart';
import '../../favorites/controllers/favorites_controller.dart';
import 'package:http/http.dart' as http;
class EServiceController extends GetxController {
  final eService = EService().obs;
  final eServices = EService().obs;
  final reviews = <Review>[].obs;
  final optionGroups = <OptionGroup>[].obs;
  final currentSlide = 0.obs;
  final quantity = 1.obs;
  final heroTag = ''.obs;
  final isDownloading = false.obs;
  final isDownloaded = false.obs;
  final isErrorDownloading = false.obs;
  String video;
  QRViewController qrcontroller;
  EServiceRepository _eServiceRepository;

  EServiceController() {_eServiceRepository = new EServiceRepository();}
  final assets = 'assets/img/sample_video.mp4';

  @override
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void onInit() async {

    var arguments = Get.arguments as Map<String, dynamic>;
    eService.value = arguments['eService'] as EService;
    heroTag.value = arguments['heroTag'] as String;
    // eService.value.videoPlayerController = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    //   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    // );
    // await eService.value.videoPlayerController.initialize();
   // started();
    print("++++++++++++++++++++++DATA HERE+++++++++++++++++++++++++++++++++");
    print(assets);
    print( eService.value.videoPlayerController);
    super.onInit();
    // await eService.value.videoPlayerController.play();
    // eService.value.startedPlaying = true;
  }

 void launchUrl(String Url) async {
    final url = Url;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<dynamic> downloaded(dynamic val) async {
     if(val != null)
       {
         eService.value.isDownload =true;
        return eService.value.isDownload;
       }
     else
       {
         eService.value.isDownload =false;

         return eService.value.isDownload;

       }


  }
Future<bool> started() async {
    eService.value.videoPlayerController= VideoPlayerController.asset(assets);
    await eService.value.videoPlayerController.initialize();
    await eService.value.videoPlayerController.pause();
    eService.value.startedPlaying = false;
    print("++++++++++++++++++++++DATA HERE+++++++++++++++++++++++++++++++++");
    print(assets);
    print(eService.value.videoPlayerController.toString());
    print("++++++++++++++++++++++DATA END+++++++++++++++++++++++++++++++++");
    return true;

   }

  @override
  void onReady() async {
    await refreshEService();
    super.onReady();
    print('sssssssssssssssssss');
  }

  Future refreshEService({bool showMessage = false}) async {
    await getEService();
    await getReviews();
    await getOptionGroups();

    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: eService.value.name + " " + "page refreshed successfully".tr));
    }
  }

  Future getEService() async {
    try {
      eService.value = await _eServiceRepository.get(eService.value.id);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
  Future  EservicesDataLst(id) async{
    final prefs = await _prefs;
    var  service_id = await prefs.getString('service_id');
    var  userId = await prefs.getString('userId');

    var postData = {};

    var body = json.encode(postData);
    try
    {
      // var url = Uri.parse(Get.find<GlobalService>().baseUrl + 'e_services/'+id+"?with=eProvider%3BeProvider.taxes%3Bcategories&api_token=5h6Aw5wchs1d0FxsU2Al9HGWlNDZpBfOzGyFPzFLHv9MDzi3YZjopvJpraNJ");
      var url = Uri.parse(Get.find<GlobalService>().baseUrl + 'e_services/'+id);
      var response = await http.get(url);
      print(url);
      print(body);
      print(response);
      print(response.statusCode);
      if(response.statusCode == 200 || response.statusCode == 201)
      {
        var data = response.body;
        print(data);
        var resource = json.decode(data);
        print("hjjhkjoiuiouopiopi[pop[opuiouioy");
        print(resource);
        return resource;
      }
      else
      {
        print("ERROR");

      }
    }
    catch(e)
    {
      print('error');
    }


  }

  Future getReviews() async {
    try {
      reviews.assignAll(await _eServiceRepository.getReviews(eService.value.id,eService.value.videoPlayerController));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getOptionGroups() async {
    try {
    //  var _optionGroups = await _eServiceRepository.getOptionGroups(eService.value.id,eService.value.videoPlayerController);
      var _optionGroups = await _eServiceRepository.getOptionGroups(eService.value.id,eService.value.videoPlayerController);
      optionGroups.assignAll(_optionGroups.map((element) {
        element.options.removeWhere((option) => option.eServiceId != eService.value.id);
        return element;
      }));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future addToFavorite() async {
    try {
      Favorite _favorite = new Favorite(
        eService: this.eService.value,
        userId: Get.find<AuthService>().user.value.id,
        options: getCheckedOptions(),
      );
      await _eServiceRepository.addFavorite(_favorite);
      eService.update((val) {
        val.isFavorite = true;
      });
      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>().refreshFavorites();
      }
      Get.showSnackbar(Ui.SuccessSnackBar(message: this.eService.value.name + " Added to favorite list".tr));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future removeFromFavorite() async {
    try {
      Favorite _favorite = new Favorite(
        eService: this.eService.value,
        userId: Get.find<AuthService>().user.value.id,
      );
      await _eServiceRepository.removeFavorite(_favorite);
      eService.update((val) {
        val.isFavorite = false;
      });
      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>().refreshFavorites();
      }
      Get.showSnackbar(Ui.SuccessSnackBar(message: this.eService.value.name + " Removed from favorite list".tr));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  void selectOption(OptionGroup optionGroup, Option option) {
    optionGroup.options.forEach((e) {
      if (!optionGroup.allowMultiple && option != e) {
        e.checked.value = false;
      }
    });
    option.checked.value = !option.checked.value;
  }

  List<Option> getCheckedOptions() {
    if (optionGroups.isNotEmpty) {
      return optionGroups.map((element) => element.options).expand((element) => element).toList().where((option) => option.checked.value).toList();
    }
    return [];
  }

  TextStyle getTitleTheme(Option option) {
    if (option.checked.value) {
      return Get.textTheme.bodyText2.merge(TextStyle(color: Get.theme.colorScheme.secondary));
    }
    return Get.textTheme.bodyText2;
  }

  TextStyle getSubTitleTheme(Option option) {
    if (option.checked.value) {
      return Get.textTheme.caption.merge(TextStyle(color: Get.theme.colorScheme.secondary));
    }
    return Get.textTheme.caption;
  }

  Color getColor(Option option) {
    if (option.checked.value) {
      return Get.theme.colorScheme.secondary.withOpacity(0.1);
    }
    return null;
  }

  void incrementQuantity() {
    quantity.value < 1000 ? quantity.value++ : null;
  }

  void decrementQuantity() {
    quantity.value > 1 ? quantity.value-- : null;
  }
}
