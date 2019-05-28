import 'package:flutter/material.dart';
import 'package:profile_manager/views/commons/doc_list_index_view.dart';
import 'package:profile_manager/views/styles/colors_style.dart';

class UtilityBills extends StatefulWidget {
  final bool isCollapsed;
  final Color mainColor;

  UtilityBills({this.isCollapsed, this.mainColor = Colors.white});
  @override
  _UtilityBillsState createState() => _UtilityBillsState();
}

class _UtilityBillsState extends State<UtilityBills> {

  Size _viewSize;
  int _firstIdxPage = 1;
  int _selectedIdx = 1;


  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _firstIdxPage, viewportFraction: 0.9);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _viewSize = MediaQuery.of(context).size;
    print(_viewSize);
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
                  itemCount: 3,
                  onPageChanged: onPageChanged,
                ),
              ),
              DocListIndex(numItems: 3, selectedIdx: _selectedIdx, normalColor: Colors.grey.withOpacity(0.3),)
            ],
          ),
        ),

        //transaction 
        Padding(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Transaction", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: widget.isCollapsed? Colors.black : Colors.white),),
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
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, idx){
                  return buildListTransaction(idx);
                },
                itemCount: 10,
              ),              
            ),
          ),
        ),
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
      _selectedIdx = value;
    });
  }
  
  Widget buildListTransaction(int idx) {
    return Container( 
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white
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
                Icon(Icons.cloud, color: Colors.black,),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Macbook Pro 15", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                    Text("Apple", style: TextStyle(color: Colors.grey, fontSize: 14))
                  ],
                ),
              ],
            ),
            
            Text("-2499 \$", style: TextStyle(color: Colors.red, fontSize: 16))
          ],
        ),
      ),
    );
  }
}
