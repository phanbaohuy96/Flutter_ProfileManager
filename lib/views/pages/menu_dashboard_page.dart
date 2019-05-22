import 'package:flutter/material.dart';
import 'package:profile_manager/views/commons/circle_image_view.dart';
import 'package:profile_manager/views/pages/utility_bills_page.dart';
import 'package:profile_manager/views/styles/colors_style.dart';


class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> with SingleTickerProviderStateMixin {

  bool isCollapsed = true;
  int _selectedIdx = 0;
  Size screenSize;
  Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  Animation _colorAnimation;
  Animation _colorDashboardBarItemAnimation;

  @override
  void initState()
  {
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
    _colorAnimation = ColorTween(begin: dashboardColor, end: menuDashboardColor).animate(_controller);
    _colorDashboardBarItemAnimation = ColorTween(begin: colorDashboardBarItem, end: colorDashboardBarItemCollapsed).animate(_controller);
    super.initState();
  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) => Scaffold(
        backgroundColor: _colorAnimation.value,
        body: Stack(
          children: <Widget>[
            menu(context),
            dashboard(context),
          ],
        ),
      ),
    );
  }

  changeSelected(int idx){
    if(idx != _selectedIdx)
    setState(() {      
      _selectedIdx = idx;
      collapseAni();
    });
  }

  collapseAni()
  {
    if(isCollapsed)
    {
      _controller.forward();
    }
    else
    {
      _controller.reverse();
    }
    isCollapsed = !isCollapsed;
  }

  getColorMenuItem(int idx) => _selectedIdx == idx ? Colors.white : Colors.white54;
  getStyleMenuItem(int idx) => _selectedIdx == idx ? TextStyle(color: Colors.white, fontSize: 20) : TextStyle(color: Colors.white54, fontSize: 18);
  

  Widget menu(context)
  {
    List<String> menuChild = ["Dashboard", "Accounts", "Utility Bills", ];
    return SlideTransition(
      position:_slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: EdgeInsets.only(left: 36.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(top: 48.0),
              width: screenSize.width * 2/3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleImageView(image: Image.asset("assets/images/bg_1.jpg", width: screenSize.width * 1/3),),
                  Text("Adminstrator", style: TextStyle(color: Colors.white, fontSize: 24),),
                  Text("HCMC, Vietnamese", style: TextStyle(color: Colors.white54, fontSize: 16),),
                  SizedBox(height: 60,),
                  InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.dashboard, color: getColorMenuItem(0)),
                        SizedBox(width: 10,),
                        Text(menuChild[0], style: getStyleMenuItem(0),),
                      ],
                    ),
                    onTap: () => changeSelected(0),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.account_box, color: getColorMenuItem(1)),
                        SizedBox(width: 10,),
                        Text(menuChild[1], style: getStyleMenuItem(1),),
                      ],
                    ),
                    onTap: () => changeSelected(1),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.payment, color: getColorMenuItem(2)),
                        SizedBox(width: 10,),
                        Text(menuChild[2], style: getStyleMenuItem(2),),
                      ],
                    ),
                    onTap: () => changeSelected(2),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context)
  {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      right: isCollapsed ? 0 : -0.4 * screenSize.width,
      left: isCollapsed ? 0 : 0.66 * screenSize.width,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) =>  Material(
            borderRadius: BorderRadius.all(Radius.circular(isCollapsed ? 0 : 30)),
            elevation: 8,
            color: _colorAnimation.value,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 40.0, right: 16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(isCollapsed? Icons.menu : Icons.arrow_back, color: _colorDashboardBarItemAnimation.value,),
                        onPressed: (){
                          setState(() {
                            collapseAni();
                          });
                        },
                      ),
                      Text("Dashboard", style: TextStyle(fontSize: 20, color: _colorDashboardBarItemAnimation.value),),                    
                      IconButton(
                        icon: Icon(Icons.settings, color: _colorDashboardBarItemAnimation.value),
                        onPressed: (){},
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getMainPage()
  {
    switch(_selectedIdx)
    {
      case 0: break;
      case 0: break;
      case 0: UtilityBills(isCollapsed: isCollapsed,);
    }
  }
}
