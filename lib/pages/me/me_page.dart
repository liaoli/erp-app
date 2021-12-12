import 'package:erp_app/components/base_scaffold.dart';
import 'package:erp_app/components/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MePage extends StatefulWidget {
  const MePage({Key key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leadType: AppBarBackType.None,
      actions: <Widget>[
        GestureDetector(
          child: Icon(Icons.account_balance_rounded,size: 30.w,),
          onTap: () {},
        )
      ],
      body: Container(
        child: Center(
          child: Text('forth'),
        ),
      ),
    );
  }
}
