import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

// 示例不传值
Handler loginHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  // return LoginPage();
});

// 示例传值
// Handler setReceivingHandler =
//     Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
//   if (params.containsKey('shipAdressModel')) {
//     String adressStr = params['shipAdressModel'].first;
//     ShipAdressModel adressData =
//         ShipAdressModel.fromJson(json.decode(adressStr));
//     return SetReceivingPage(receivingData: adressData);
//   }
//   return SetReceivingPage();
// });
