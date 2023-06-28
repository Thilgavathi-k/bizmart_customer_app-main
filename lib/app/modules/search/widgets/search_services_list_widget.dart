import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/e_service_model.dart';
import '../../category/widgets/services_list_item_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';

class SearchServicesListWidget extends StatelessWidget {
  final List<EService> services;

  SearchServicesListWidget({Key key, List<EService> this.services})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (this.services.isEmpty) {
        return CircularLoadingWidget(height: 300);
      }
      else {
        return GridView.builder(
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.900),
          padding: EdgeInsets.all(10.0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: ((_, index) {
            var _service = services.elementAt(index);
            return ServicesListItemWidget(service: _service);
          }),
        );
        // ListView.builder(
        //   padding: EdgeInsets.only(bottom: 10, top: 10),
        //   primary: false,
        //   shrinkWrap: true,
        //   itemCount: services.length,
        //   itemBuilder: ((_, index) {
        //     var _service = services.elementAt(index);
        //     return ServicesListItemWidget(service: _service);
        //   }),
        // );
      }
    });
  }
}
