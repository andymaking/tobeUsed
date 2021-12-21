//
// import 'package:dhoro_mobile/data/core/table_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
//
// class HiveUtils{
//   var biometric;
// void updateBiometricStatus() async{
//   biometric = await Hive.openBox<bool>(DbTable.IS_BIOMETRIC_ENABLED);
//   biometric.add(true);
//   print("Print Biometric status $biometric");
// }
//
// Future<Widget> pageToLaunch() async {
//   final box = await Hive.openBox<bool>(DbTable.ONBOARDING_TABLE_NAME);
//   if (box.values.isEmpty) {
//     return SplashScreen();
//   }else if (box.values.first == false) {
//     return SplashScreen();
//   } else {
//     return SplashScreen();
//   }
// }
// }