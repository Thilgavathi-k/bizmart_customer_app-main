/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../bookings/widgets/booking_row_widget.dart';

class PaymentDetailsWidget extends StatefulWidget {
   PaymentDetailsWidget({Key key})  :super(key: key);

  @override
  State<PaymentDetailsWidget> createState() => _PaymentDetailsWidgetState();
}

class _PaymentDetailsWidgetState extends State<PaymentDetailsWidget> {
//  final Booking _booking;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          BookingRowWidget(
            description: "payment",

            hasDivider: true,
          ),
          Column(
            children: List.generate(1, (index) {
             // var _option = _booking.options.elementAt(index);
              return BookingRowWidget(
                  description: "Payment",
              );
                 // child: Align(
                   // alignment: Alignment.centerRight,
                  //  child: Ui.getPrice(_option.price, style: Get.textTheme.bodyText1),
                 // ),
                //  hasDivider: (_booking.options.length - 1) == index);
            }),
          ),
          BookingRowWidget(
                description: "Quantity".tr,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("Payment",

                    style: Get.textTheme.bodyText2,
                  ),
                ),
                hasDivider: true),
          Column(
            children: List.generate(1, (index) {
             // var _tax = _booking.taxes.elementAt(index);
              return BookingRowWidget(
                  description: "Payment",

                  hasDivider: (10 - 1) == index);
            }),
          ),
          BookingRowWidget(
            description: "Tax Amount".tr,
            child: Align(
              alignment: Alignment.centerRight,
            //  child: Ui.getPrice(_booking.getTaxesValue(), style: Get.textTheme.subtitle2),
            ),
            hasDivider: false,
          ),
          BookingRowWidget(
              description: "Subtotal".tr,
              child: Align(
                alignment: Alignment.centerRight,
             //   child: Ui.getPrice(_booking.getSubtotal(), style: Get.textTheme.subtitle2),
              ),
              hasDivider: true),
            BookingRowWidget(
                description: "Coupon".tr,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    children: [
                      Text(' - ', style: Get.textTheme.bodyText1),
                    //  Ui.getPrice(_booking.coupon.discount, style: Get.textTheme.bodyText1, unit: _booking.coupon.discountType == 'percent' ? "%" : null),
                    ],
                  ),
                ),
                hasDivider: true),
          BookingRowWidget(
            description: "Total Amount".tr,
            child: Align(
              alignment: Alignment.centerRight,
            //  child: Ui.getPrice(_booking.getTotal(), style: Get.textTheme.headline6),
            ),
          ),
        ],
      ),
    );
  }
}
