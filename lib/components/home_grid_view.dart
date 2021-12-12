import 'package:erp_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

typedef HomeGridViewItemCallBack = void Function(int index);

class HomeGridView extends StatelessWidget {
  final HomeGridViewItemCallBack onTapCallback;
  const HomeGridView({Key key, this.onTapCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14, 10, 14, 0),
      color: AppColors.primaryBackground,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemCount: 10,
        itemBuilder: (context, index) {
          return SelfItemWidget(
            index: index,
            item: "---",
            onTapCallback: this.onTapCallback,
          );
        },
        staggeredTileBuilder: (int index) {
          if (index == 0 || index == 6) {
            return new StaggeredTile.count(6, 0.5);
          } else {
            return new StaggeredTile.count(1, 2);
          }
        },
      ),
    );
  }
}

class SelfItemWidget extends StatefulWidget {
  final String item;
  final int index;
  final HomeGridViewItemCallBack onTapCallback;
  const SelfItemWidget({Key key, this.item, this.index, this.onTapCallback})
      : super(key: key);
  @override
  _SelfItemWidgetState createState() => _SelfItemWidgetState();
}

class _SelfItemWidgetState extends State<SelfItemWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.index == 0 || widget.index == 6) {
      return Container(
        color: Colors.green,
        child: Text(
          "分组标题",
          style: TextStyle(color: AppColors.primaryText),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          widget.onTapCallback(widget.index);
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.red,
                width: 80,
                height: 80,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(13, 10, 0, 0),
                width: double.infinity,
                child: Text(
                  '小标题',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
