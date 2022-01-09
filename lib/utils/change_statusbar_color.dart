import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

void changeSystemColor(Color color){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: color,
      statusBarColor: color,
    statusBarBrightness: Brightness.dark,//status bar brigtness
    statusBarIconBrightness:Brightness.dark , //status barIcon Brightness
    systemNavigationBarDividerColor: color,//Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light,
  ));
}

void changeSystemNavigationBarDividerColor(Color color){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarDividerColor: color,//Navigation bar divider color
  ));
}

changeStatusAndNavBarColor(Color statusBarColor,Color navBarColor, bool setStatusBarToWhite, bool setNavigationBarToWhite) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(statusBarColor, animate: true);
    await FlutterStatusbarcolor.setNavigationBarColor(navBarColor, animate: true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(setStatusBarToWhite);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(setNavigationBarToWhite);
    changeSystemNavigationBarDividerColor(navBarColor);
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }
}

changeNavigationColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setNavigationBarColor(color, animate: true);
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }
}

getStatusBarAndNavigationBar() async{
  // // get statusbar color and navigationbar color
  Color? statusbarColor = await FlutterStatusbarcolor.getStatusBarColor();
  Color? navigationbarColor = await FlutterStatusbarcolor.getNavigationBarColor();
}

