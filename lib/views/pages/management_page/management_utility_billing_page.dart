import 'package:flutter/material.dart';
import 'package:profile_manager/models/billing_card.dart';
import 'package:profile_manager/views/commons/doc_list_index_view.dart';

class UtilityBills extends StatefulWidget {
  final bool isCollapsed;
  final Color mainColor;

  UtilityBills({this.isCollapsed, this.mainColor = Colors.white});
  @override
  _UtilityBillsState createState() => _UtilityBillsState();
}

class _UtilityBillsState extends State<UtilityBills> with SingleTickerProviderStateMixin {

  Size _viewSize;
  int _firstIdxPage = 1;
  int _selectedIdx = 1;

  


  PageController _pageController;

  AnimationController _controller;
  Animation<double> _fadeAnimation;

  @override
  void initState() {
    _pageController = PageController(initialPage: _firstIdxPage, viewportFraction: 0.9);
    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose()
  {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewSize = MediaQuery.of(context).size;
    return Column(      
      children: <Widget>[
        Container(
          height: 230.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight:  Radius.circular(30)),
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
                    return buildListTransaction(idx);
                  },
                  itemCount: billingCards[_selectedIdx].transactions.length,
                ),
              ),              
            ),
          ),
        ),
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
  
  Widget buildListTransaction(int idx) {
    Transaction temp = billingCards[_selectedIdx].transactions[idx];
    Text dateSoft;
    if(_transactionDate == null || _transactionDate != temp.getDateStringCurrentWeek())
    {
      dateSoft = Text(temp.getDateStringCurrentWeek(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),);
      _transactionDate = temp.getDateStringCurrentWeek();
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
            
            Text(temp.getCostVND(), style: TextStyle(color: temp.isSpend? Colors.red : Colors.green, fontSize: 16))
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
