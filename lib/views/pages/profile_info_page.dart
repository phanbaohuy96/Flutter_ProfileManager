import 'package:flutter/material.dart';
import 'package:profile_manager/views/commons/app_background.dart';


class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(),
    );
  }
}