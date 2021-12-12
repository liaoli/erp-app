import 'package:erp_app/components/base_scaffold.dart';
import 'package:erp_app/components/home_grid_view.dart';
import 'package:erp_app/components/my_app_bar.dart';
import 'package:flutter/material.dart';

class StockWarehouseMainPage extends StatefulWidget {
  const StockWarehouseMainPage({Key key}) : super(key: key);

  @override
  _StockWarehouseMainPageState createState() => _StockWarehouseMainPageState();
}

class _StockWarehouseMainPageState extends State<StockWarehouseMainPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: '囤货仓工作台',
      leadType: AppBarBackType.None,
      centerTitle: true,
      body: HomeGridView(),
    );
  }
}
