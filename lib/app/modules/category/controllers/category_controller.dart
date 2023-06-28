import 'dart:convert';

import 'package:bizmart/app/models/const_bse_url.dart';
import 'package:bizmart/app/services/global_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../models/e_service_model.dart';
import '../../../repositories/e_service_repository.dart';
import 'package:http/http.dart' as http;

enum CategoryFilter { ALL, AVAILABILITY, RATING, FEATURED, POPULAR }
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class CategoryController extends GetxController {
  final category = new Category().obs;
  final selected = Rx<CategoryFilter>(CategoryFilter.ALL);
  final eServices = <EService>[].obs;
  final page = 0.obs;
  final isLoading = true.obs;
  final isServiceLoading = true.obs;
  final isDone = false.obs;
  EServiceRepository _eServiceRepository;
  ScrollController scrollController = ScrollController();

  CategoryController() {
    _eServiceRepository = new EServiceRepository();
  }

  @override
  Future<void> onInit() async {
    category.value = Get.arguments as Category;
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        loadEServicesOfCategory(category.value.id, filter: selected.value);
      }
    });
    await refreshEServices();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshEServices({bool showMessage}) async {
    await loadEServicesOfCategory(category.value.id, filter: selected.value);
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "List of services refreshed successfully".tr));
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
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++e_services api call++++++++++++++++++++++++++++++++++++++++++++++++');
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
  bool isSelected(CategoryFilter filter) => selected == filter;

  void toggleSelected(CategoryFilter filter) {
    this.eServices.clear();
    this.page.value = 0;
    if (isSelected(filter)) {
      selected.value = CategoryFilter.ALL;
    } else {
      selected.value = filter;
    }
  }



  Future loadEServicesOfCategory(String categoryId, {CategoryFilter filter}) async {
    try {
      isLoading.value = true;
      isServiceLoading.value = true;
      isDone.value = false;
      this.page.value++;
      List<EService> _eServices = [];
      print("SELCTSELEFILETVALUE");
      print(filter);
      switch (filter) {
        case CategoryFilter.ALL:
          _eServices = await _eServiceRepository.getAllWithPagination(categoryId, page: this.page.value);
          break;
        case CategoryFilter.FEATURED:
          _eServices = await _eServiceRepository.getFeatured(categoryId, page: this.page.value);
          break;
        case CategoryFilter.POPULAR:
          _eServices = await _eServiceRepository.getPopular(categoryId, page: this.page.value);
          break;
        case CategoryFilter.RATING:
          _eServices = await _eServiceRepository.getMostRated(categoryId, page: this.page.value);
          break;
        case CategoryFilter.AVAILABILITY:
          _eServices = await _eServiceRepository.getAvailable(categoryId, page: this.page.value);
          break;
        default:
          _eServices = await _eServiceRepository.getAllWithPagination(categoryId, page: this.page.value);
      }
      if (_eServices.isNotEmpty) {
        this.eServices.addAll(_eServices);
      } else {
        isDone.value = true;
      }
    } catch (e) {
      this.isDone.value = true;
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
      isServiceLoading.value = false;
    }
  }

}
