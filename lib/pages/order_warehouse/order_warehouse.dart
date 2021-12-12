import 'package:erp_app/components/base_scaffold.dart';
import 'package:erp_app/components/home_grid_view.dart';
import 'package:erp_app/components/my_app_bar.dart';
import 'package:flutter/material.dart';

class OrderWarehouse extends StatefulWidget {
  const OrderWarehouse({Key key}) : super(key: key);

  @override
  _OrderWarehouseState createState() => _OrderWarehouseState();
}

class _OrderWarehouseState extends State<OrderWarehouse> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: '订单仓工作台',
      leadType: AppBarBackType.None,
      centerTitle: true,
      body: HomeGridView(
        onTapCallback: (index) {
          print(index);
        },
      ),
    );
  }
}
