import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'base_router_handler.dart';

class Routes {
  static String root = '/'; // 根目录
  static String loginPage = '/login'; // 登录页面

  static void defineRoutes(FluroRouter router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Text('未找到页面');
    });

    // 创建pageRoute
    router.define(loginPage, handler: loginHandler);
  }
}
