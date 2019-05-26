import 'package:flutter/material.dart';
import 'package:profile_manager/views/pages/login_page.dart';
import 'package:profile_manager/views/pages/menu_dashboard_page.dart';
import 'package:profile_manager/views/pages/profile_info_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuDashboardPage(),
    );
  }
}