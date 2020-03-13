import 'package:flutter/material.dart';
import 'package:profile_manager/ui/styles/colors_style.dart';
import 'package:profile_manager/ui/widget/circle_image_view.dart';

import 'management_page/management_account_page.dart';
import 'management_page/management_loan_borrow_page.dart';
import 'management_page/management_spending_page.dart';
import 'management_page/management_utility_billing_page.dart';

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
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

  //page
  // UtilityBills _utilityBills;
  // ManagementAccountPage _accountManagerPage;
  // ManagementSpendingPage _managementSpendingPage;

  //props
  List<String> menuChild = [
    'Utility Bills',
    'Accounts',
    'Spendings',
    'Loan and borrow',
    'Setting'
  ];

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(_controller);
    _colorAnimation = ColorTween(begin: dashboardColor, end: menuDashboardColor)
        .animate(_controller);
    _colorDashboardBarItemAnimation = ColorTween(
            begin: colorDashboardBarItem, end: colorDashboardBarItemCollapsed)
        .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
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
      ),
    );
  }

  void changeSelected(int idx) {
    setState(() {
      _selectedIdx = idx;
      collapseAni();
    });
  }

  void collapseAni() {
    if (isCollapsed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    isCollapsed = !isCollapsed;
  }

  Color getColorMenuItem(int idx) =>
      _selectedIdx == idx ? Colors.white : Colors.white54;
  TextStyle getStyleMenuItem(int idx) => _selectedIdx == idx
      ? const TextStyle(color: Colors.white, fontSize: 20)
      : const TextStyle(color: Colors.white54, fontSize: 18);

  Widget menu(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 36.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.only(top: 48.0),
              width: screenSize.width * 2 / 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleImageView(
                    image: Image.asset('assets/images/bg_1.jpg',
                        width: screenSize.width * 1 / 3),
                  ),
                  const Text(
                    'Adminstrator',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const Text(
                    'HCMC, Vietnamese',
                    style: TextStyle(color: Colors.white54, fontSize: 16),
                  ),
                  const SizedBox(height: 60),
                  InkWell(
                    onTap: () => changeSelected(0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.payment, color: getColorMenuItem(0)),
                        const SizedBox(width: 10),
                        Text(
                          menuChild[0],
                          style: getStyleMenuItem(0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => changeSelected(1),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.account_box, color: getColorMenuItem(1)),
                        const SizedBox(width: 10),
                        Text(
                          menuChild[1],
                          style: getStyleMenuItem(1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => changeSelected(2),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.monetization_on, color: getColorMenuItem(2)),
                        const SizedBox(width: 10),
                        Text(
                          menuChild[2],
                          style: getStyleMenuItem(2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => changeSelected(3),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.assignment_return,
                            color: getColorMenuItem(3)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          menuChild[3],
                          style: getStyleMenuItem(3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => changeSelected(4),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.settings, color: getColorMenuItem(4)),
                        const SizedBox(width: 10),
                        Text(
                          menuChild[4],
                          style: getStyleMenuItem(4),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: const Text('v0.0.1 - beta'),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      right: isCollapsed ? 0 : -0.6 * screenSize.width,
      left: isCollapsed ? 0 : 0.6 * screenSize.width,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) => Material(
            borderRadius:
                BorderRadius.all(Radius.circular(isCollapsed ? 0 : 30)),
            elevation: 8,
            color: _colorAnimation.value,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 24,
                  width: 320,
                ),

                //appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        isCollapsed ? Icons.menu : Icons.arrow_back,
                        color: _colorDashboardBarItemAnimation.value,
                      ),
                      onPressed: () => setState(collapseAni),
                    ),
                    Text(
                      menuChild[_selectedIdx],
                      style: TextStyle(
                        fontSize: 20,
                        color: _colorDashboardBarItemAnimation.value,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: _colorDashboardBarItemAnimation.value,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),

                //main page
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(isCollapsed ? 0 : 30),
                          bottomRight: Radius.circular(isCollapsed ? 0 : 30)),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: getMainPage(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getMainPage() {
    switch (_selectedIdx) {
      case 0:
        {
          return UtilityBills(
            isCollapsed: isCollapsed,
            mainColor: _colorAnimation.value,
          );
        }
      case 1:
        {
          return ManagementAccountPage(
            isCollapsed: isCollapsed,
            mainColor: _colorAnimation.value,
          );
        }
      case 2:
        {
          return ManagementSpendingPage(
            isCollapsed: isCollapsed,
            mainColor: _colorAnimation.value,
          );
        }
      case 3:
        {
          return ManagementLoanAndBorrowPage(
            isCollapsed: isCollapsed,
            mainColor: _colorAnimation.value,
          );
        }
      default:
        return UtilityBills(
          isCollapsed: isCollapsed,
          mainColor: _colorAnimation.value,
        );
    }
  }
}
