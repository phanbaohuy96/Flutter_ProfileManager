import 'package:flutter/material.dart';
import 'package:profile_manager/controller/controller_utils.dart';
import 'package:profile_manager/controller/utility_billing_controller.dart';
import 'package:profile_manager/models/billing_card.dart';
import 'package:profile_manager/views/commons/doc_list_index_view.dart';

class UtilityBills extends StatefulWidget {
  final bool isCollapsed;
  final Color mainColor;

  UtilityBills({this.isCollapsed, this.mainColor = Colors.white});
  @override
  _UtilityBillsState createState() => _UtilityBillsState();
}

class _UtilityBillsState extends State<UtilityBills> with TickerProviderStateMixin {

  Size _viewSize;
  int _firstIdxPage = 1;
  int _selectedIdx = 1;
  bool _isOpenedheader = false;

  


  PageController _pageController;

  //main
  AnimationController _controller;
  Animation<double> _fadeAnimation;

  //header 
  AnimationController _headerController;
  Animation<Offset> _slideHeaderAnimation;
  Animation _colorHearBackgroundAnimation;

  @override
  void initState() {
    //main
    _pageController = PageController(initialPage: _firstIdxPage, viewportFraction: 0.9);
    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    //header
    _headerController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _headerController.addListener(() => setState(() {}) );
    _colorHearBackgroundAnimation = ColorTween(begin: Colors.transparent, end: Colors.black.withOpacity(0.5)).animate(_headerController);
    _slideHeaderAnimation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.0)).animate(_headerController);

    super.initState();
  }

  @override
  void dispose()
  {
    _pageController.dispose();
    _controller.dispose();
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewSize = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Column(      
          children: <Widget>[
            //header holder            
            SizedBox(height: 230,),

            //transaction 
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Transactions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: widget.isCollapsed? Colors.black : Colors.white),),
                  IconButton(
                    icon: Icon(Icons.transform, color: widget.isCollapsed? Colors.black : Colors.white), 
                    onPressed: (){
                      
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, idx){
                        return buildTransaction(idx);
                      },
                      itemCount: billingCards[_selectedIdx].transactions.length,
                    ),
                  ),
                ),
              ),
            ),

            //bottombar holder
            SizedBox(height: 50,)
          ],
        ),

        //Header open background
        AnimatedBuilder(
          animation: _colorHearBackgroundAnimation,
          builder: (context, child) => _isOpenedheader ? 
            Container(color: _colorHearBackgroundAnimation.value,)
            :SizedBox()
        ),
        //header
        Stack(
          children: <Widget>[
            
            SlideTransition(
              position: _slideHeaderAnimation,
              child: Container(
                height: 210, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight:  Radius.circular(30)),
                  color: widget.mainColor
                ),
              ),
            ),
            Container(
              height: 230.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(_isOpenedheader? 0 : 30), bottomRight:  Radius.circular(_isOpenedheader? 0 : 30)),
                color: widget.mainColor
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 210,
                    child: PageView.builder(
                      itemBuilder: (context, idx){
                        return buildListBillingCard(idx);
                      },
                      controller: _pageController,
                      itemCount: billingCards.length,
                      onPageChanged: onPageChanged,
                    ),
                  ),
                  DocListIndex(numItems: billingCards.length, selectedIdx: _selectedIdx, normalColor: Colors.grey.withOpacity(0.3),)
                ],
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Expanded(child: SizedBox(),),
            //bottom bar
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30), bottomLeft: Radius.circular(widget.isCollapsed ? 0 : 30), bottomRight: Radius.circular(widget.isCollapsed ? 0 : 30)),
                  color: widget.mainColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _buildBottomBar(),
                ),
              )
            )
          ],
        )
      ],
    );
  }

  Widget buildListBillingCard(int idx) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child){
        double value = 1;
        if(_pageController.position.haveDimensions){
          value = _pageController.page - idx;
          value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
          return Transform.translate(
            offset: _selectedIdx == idx ? Offset(0, 0) : (idx < _selectedIdx ? Offset(50, 0) : Offset(-50, 0)),
            child: Transform.scale(
              scale: value,
              child: child
            ),
          );
        }
        else{
          return Transform.translate(
            offset: _selectedIdx == idx ? Offset(0, 0) : (idx < _selectedIdx ? Offset(50, 0) : Offset(-50, 0)),
            child: Transform.scale(
              scale: idx == _firstIdxPage? value : value * 0.8,
              child: child
            ),
          );
        }        
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        child: Stack(
          children: <Widget>[
            Align(
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                color: Colors.transparent,
                elevation: 10,
                shadowColor: Colors.blue,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),                  
                  child: Image.asset("assets/images/credit_card.png")
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPageChanged(int value) {
    setState(() {
      _controller.reset();
      _controller.forward();
      _selectedIdx = value;
    });
  }

  String _transactionDate;
  
  Widget buildTransaction(int idx) {
    Transaction temp = billingCards[_selectedIdx].transactions[idx];
    Text dateSoft;
    if(_transactionDate == null || _transactionDate != ControllerUtils.instance.getDateString(temp.date))
    {
      dateSoft = Text(ControllerUtils.instance.getDateString(temp.date), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),);
      _transactionDate = ControllerUtils.instance.getDateString(temp.date);
    }

    var transaction = Container( 
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: widget.mainColor
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 10, left: 10, bottom: 5, top: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 5,),
                Icon(Icons.cloud, color: Colors.grey,),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(temp.action.name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                    SizedBox(height: 3,),
                    Text(temp.actionPlace.name, style: TextStyle(color: Colors.grey, fontSize: 14))
                  ],
                ),
              ],
            ),
            
            Text(UtililyBillingController.instance.getCostTransactionVND(temp), style: TextStyle(color: temp.isSpend? Colors.red : Colors.green, fontSize: 16))
          ],
        ),
      ),
    );

    return dateSoft != null ?  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[      
        SizedBox(height: idx != 0? 10 : 0,),
        Padding( padding: EdgeInsets.only(bottom: 10, left: 10), child: dateSoft,),
        transaction
      ],
    )
    : transaction;
  }

  List<Widget> _buildBottomBar()
  {
    return [
      IconButton(
        icon: Icon(
          Icons.add, 
          color: widget.isCollapsed? Colors.black : Colors.white,
        ),
        onPressed: (){
          if(_isOpenedheader)
            _headerController.reverse();
          else
            _headerController.forward();
          _isOpenedheader = !_isOpenedheader;
        },
      ),
      IconButton(
        icon: Icon(
          Icons.show_chart, 
          color: widget.isCollapsed? Colors.black : Colors.white,
        ),
        onPressed: (){
        },
      ),
      IconButton(
        icon: Icon(
          Icons.settings, 
          color: widget.isCollapsed? Colors.black : Colors.white,
        ),
        onPressed: (){
        },
      )
    ];
  }
}
