/*
 * Copyright (c) 2022 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneFieldWidget extends StatelessWidget {
  const PhoneFieldWidget(
      {Key key,
      this.onSaved,
      this.onChanged,
      this.initialValue,
      this.hintText,
      this.errorText,
      this.labelText,
      this.obscureText,
      this.suffixIcon,
      this.isFirst,
      this.isLast,
      this.style,
      this.textAlign,
      this.suffix,
      this.initialCountryCode,
      this.countries})
      : super(key: key);

  final FormFieldSetter<PhoneNumber> onSaved;
  final ValueChanged<PhoneNumber> onChanged;
  final String initialValue;
  final String hintText;
  final String errorText;
  final TextAlign textAlign;
  final String labelText;
  final TextStyle style;
  final bool obscureText;
  final String initialCountryCode;
  final List<String> countries;
  final bool isFirst;
  final bool isLast;
  final Widget suffixIcon;
  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0
          // top: topMargin,
          // bottom: bottomMargin
          ),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: buildBorderRadius,
          // boxShadow: [
          //   BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
          // ],
          border: Border.all(color: Colors.grey.shade200, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Text(
          //   labelText ?? "",
          //   style: Get.textTheme.bodyText1,
          //   textAlign: textAlign ?? TextAlign.start,
          // ),
          IntlPhoneField(
              key: key,
              onSaved: onSaved,
              onChanged: onChanged,
              initialValue: initialValue ?? '',
              initialCountryCode: initialCountryCode ?? 'DE',
              showDropdownIcon: false,
              pickerDialogStyle:
                  PickerDialogStyle(countryNameStyle: Get.textTheme.bodyText2),
              style: style ?? Get.textTheme.bodyText2,
              textAlign: textAlign ?? TextAlign.start,
              disableLengthCheck: true,
              autovalidateMode: AutovalidateMode.disabled,
              decoration: InputDecoration(
                hintText: hintText ?? '',
                hintStyle: Get.textTheme.caption,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.all(0),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                suffixIcon: suffixIcon,
                suffix: suffix,
                errorText: errorText,
              )),
        ],
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst) {
      return BorderRadius.vertical(top: Radius.circular(0));
    }
    if (isLast != null && isLast) {
      return BorderRadius.vertical(bottom: Radius.circular(0));
    }
    if (isFirst != null && !isFirst && isLast != null && !isLast) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(0));
  }

  double get topMargin {
    if ((isFirst != null && isFirst)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}
