import 'package:flutter/material.dart';

class DocListIndex extends StatelessWidget {
  final int selectedIdx;
  final int numItems;
  final double height;
  final Color selectedColor;
  final Color normalColor;

  const DocListIndex({
    Key key,
    this.selectedIdx,
    this.numItems,
    this.height = 7,
    this.selectedColor = Colors.blue,
    this.normalColor = Colors.grey,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buildItem(),
    );
  }

  List<Widget> buildItem() {
    final List<Widget> items = List(numItems);
    for (int i = 0; i < numItems; i++) {
      items[i] = Container(
        height: height,
        width: height,
        margin: EdgeInsets.all(height / 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: i == selectedIdx ? selectedColor : normalColor,
        ),
      );
    }
    return items;
  }
}
