import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MyCustomFooter extends StatelessWidget {
  const MyCustomFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          textTheme:
              TextTheme(display1: TextStyle(color: Colors.grey, fontSize: 12))),
      child: Text(""),
    );
  }
}
