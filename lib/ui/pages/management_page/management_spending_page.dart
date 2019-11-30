import 'package:flutter/material.dart';

class ManagementSpendingPage extends StatefulWidget {
  final bool isCollapsed;
  final Color mainColor;

  ManagementSpendingPage({this.isCollapsed, this.mainColor});

  @override
  _ManagementSpendingPageState createState() => _ManagementSpendingPageState();
}

class _ManagementSpendingPageState extends State<ManagementSpendingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent
    );
  }
}