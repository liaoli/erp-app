import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'base_router_application.dart';

class BaseNavigation {
  // 设置一次 context 方便后面
  static BuildContext ctx;
  /*
   * push 新页面
   * pageRouterStr：页面路径，需先去router_handle中添加路径
   * 传参id=，例：跳商品详情页 BaseNavigation('detail?id=1')
   */
  static Future<T> push<T extends Object>(final pageRouterStr,
      {BuildContext context, TransitionType transition}) {
    final _ctx = context ?? ctx;
    final _trans = transition ?? TransitionType.native;
    FocusScope.of(_ctx).requestFocus(FocusNode());
    return ApplicationRouter.router
        .navigateTo(_ctx, pageRouterStr, transition: _trans);
  }

  /*
   * push 新页面,不记录返回上一层
   * pageRouterStr：页面路径，需先去router_handle中添加路径
   * 传参id=，例：跳商品详情页 BaseNavigation('detail?id=1')
   */
  static Future<T> onePush<T extends Object>(final pageRouterStr,
      {BuildContext context, TransitionType transition}) {
    final _ctx = context ?? ctx;
    final _trans = transition ?? TransitionType.native;
    return ApplicationRouter.router
        .navigateTo(_ctx, pageRouterStr, transition: _trans, replace: true);
  }

  // pop 返回
  static pop<T extends Object>({BuildContext context, T data}) {
    final _ctx = context ?? ctx;
    return Navigator.pop(_ctx, data);
  }

  /// 返回根页面
  static void popToRoot({BuildContext context}) {
    final _ctx = context ?? ctx;
    Navigator.popUntil(_ctx, (predicate) {
      return predicate.isFirst;
    });
  }

  /// 返回首页
  static void popToHome({BuildContext context}) {
    // final _ctx = context ?? ctx;
    // final mainProvder = Provider.of<MainProvider>(_ctx, listen: false);
    // mainProvder.setTabbarSelectedIndex = 0;
    // Navigator.popUntil(_ctx, (predicate) {
    //   return predicate.isFirst;
    // });
  }

  /// 返回并删除页面
  static void pushAndRemove(Widget page,
      {int removeCount = 1, BuildContext context}) {
    var index = 0;
    final _ctx = context ?? ctx;
    Navigator.of(_ctx).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (route) {
        index++;
        return index > removeCount ? true : false;
      },
    );
  }

  // iOS 从底部向上出来的页面
  static present(final pageRouterStr, {BuildContext context}) {
    final _ctx = context ?? ctx;
    return ApplicationRouter.router.navigateTo(_ctx, pageRouterStr,
        transition: TransitionType.inFromBottom);
  }
}
