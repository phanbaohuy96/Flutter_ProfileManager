import 'package:flutter/material.dart';

class ManagementAccountPage extends StatefulWidget {

  final bool isCollapsed;
  final Color mainColor;

  ManagementAccountPage({this.isCollapsed, this.mainColor});

  @override
  _ManagementAccountPageState createState() => _ManagementAccountPageState();
}

class _ManagementAccountPageState extends State<ManagementAccountPage> {

  Size _screenSize;
  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          height: 230.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight:  Radius.circular(30)),
            color: widget.mainColor
          ),
          padding: EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 30),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemBuilder: (context, idx)
            {
              return buildItemAcountService(idx);
            },
            itemCount: 20,
          ),
        ),

      ],
    );
  }

  Widget buildItemAcountService(int idx) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
        elevation: 5,
        child: Container(        
          width: _screenSize.width / 2.5, 
        ),
      ),
    );
  }
}