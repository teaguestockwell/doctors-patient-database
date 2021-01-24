import 'package:flutter/material.dart';
import '../constant.dart';

typedef void OnPress();

class But extends StatelessWidget {
  final String text;
  final OnPress onpress;
  But({this.text = '',this.onpress}):super(key:UniqueKey());

  @override
  Widget build(BuildContext context) {
    return 
    Padding(padding: EdgeInsets.only(top: Butz.paddT),
    child:
    Container(
        height: Butz.y,
        width: Butz.x,
        decoration: BoxDecoration(
            color: Butz.fill, borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FlatButton(
            onPressed: onpress ?? () {},
            child: Text(
              text,
              style: Butz.ts,
            ),
          ),
        )
    ));
  }
}