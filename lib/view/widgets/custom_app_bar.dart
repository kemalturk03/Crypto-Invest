import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customAppBar(BuildContext context, Widget? rowChild) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height / 9.5,
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: size.width / 18.75,
              bottom: size.width / 24,
              top: size.width / 30),
          height: size.height / 5 - 20,
          decoration: BoxDecoration(
              color: Color(0xFF12171A),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36))),
          child: rowChild,
        ),
      ],
    ),
  );
}
