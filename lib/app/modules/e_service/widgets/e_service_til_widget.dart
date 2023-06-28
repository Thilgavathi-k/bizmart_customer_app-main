/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';

class EServiceTilWidget extends StatelessWidget {
  final Widget title;
  final Widget content;
  final List<Widget> actions;
  final double horizontalPadding;

  const EServiceTilWidget(
      {Key key, this.title, this.content, this.actions, this.horizontalPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.only(left: 20),
      //  decoration: Ui.getBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: title),
              if (actions != null)
                Wrap(
                  children: actions,
                )
            ],
          ),

          // Divider(
          //   height: 5,
          //   thickness:0,
          // ),
          content,
        ],
      ),
    );
  }
}
