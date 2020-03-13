import 'package:flutter/material.dart';
import 'package:profile_manager/ui/styles/colors_style.dart';
import 'package:profile_manager/ui/widget/circle_image_view.dart';
import 'package:profile_manager/ui/widget/image_background_animate_view.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //background
          const ImageBackgroundAnimateView('assets/images/bg_1.jpg'),

          //infomation
          Padding(
            padding:
                const EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 10),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: blurColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //avatar
                    Align(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: CircleImageView(
                          image: Image.asset(
                            'assets/images/bg_1.jpg',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
