import 'package:flutter/foundation.dart';



class ManagePageProvider with ChangeNotifier {
  bool loading = true;



  ManagePageProvider() {
    /// 首页数据加载
    initData();
  }
  Future initData({bool refresh = false}) async {


    notifyListeners();
  }

  /// 上拉加载
  Future loadData({bool refresh = false}) async {

    loading = false;

    notifyListeners();
  }
}
