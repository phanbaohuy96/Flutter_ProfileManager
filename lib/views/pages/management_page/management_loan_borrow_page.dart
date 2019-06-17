import 'package:flutter/material.dart';
import 'package:profile_manager/controller/loan_borrow_controler.dart';
import 'package:profile_manager/models/loan_and_borrow.dart';
import 'package:profile_manager/views/commons/loan_borrow_item_view.dart';

class ManagementLoanAndBorrowPage extends StatefulWidget {
  final bool isCollapsed;
  final Color mainColor;

  ManagementLoanAndBorrowPage({this.isCollapsed, this.mainColor});

  @override
  _ManagementLoanAndBorrowPageState createState() => _ManagementLoanAndBorrowPageState();
}

class _ManagementLoanAndBorrowPageState extends State<ManagementLoanAndBorrowPage> with SingleTickerProviderStateMixin{

  int _selectedField = 0;
  Size _screenSize;

  AnimationController _controller;
  Animation<double> _fadeAnimation;


  @override
  void initState() {
    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          height: 230.0,
          width: _screenSize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight:  Radius.circular(30)),
            color: widget.mainColor
          ),
          padding: EdgeInsets.only(top: 10.0, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Icon(Icons.person, size: 100,)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: _screenSize.width / 2 - 20,
                    height: 100,
                    child: InkWell(
                      onTap: (){
                        if(_selectedField != 0) 
                        setState(() {
                          _selectedField = 0;
                        });
                      },
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        elevation: 10,
                        color: widget.mainColor,
                        shadowColor: _selectedField == 0 ? Colors.blue :  Colors.grey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 10,),
                            Text("Loan", style: TextStyle(fontSize: 18, color: widget.isCollapsed? Colors.black : Colors.white))
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _screenSize.width / 2 - 20,
                    height: 100,
                    child: InkWell(
                      onTap: (){
                        if(_selectedField != 1) 
                        setState(() {
                          _selectedField = 1;
                        });
                      },
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        elevation: 10,
                        color: widget.mainColor,
                        shadowColor: _selectedField == 1 ? Colors.blue :  Colors.grey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 10,),
                            Text("Borrow", style: TextStyle(fontSize: 18, color: widget.isCollapsed? Colors.black : Colors.white))
                          ],
                        )
                      ),
                    )
                  )
                ],
              )
            ],
          ),
        ),

        //list of loan or borrow
        Padding(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_selectedField == 0? "Loanings" : "Borrowings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: widget.isCollapsed? Colors.black : Colors.white),),
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
                    return LoanAndBorrowItem(
                      _getData()[idx], 
                      backgroundColor: widget.mainColor, 
                      onLongPress: (idx){
                        print(idx);
                      },
                    );
                  },
                  itemCount: _getData().length,
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
          ),
        )
      ],
    );
  }

  _getData(){
    if(_selectedField == 0) return LoanAndBorrowController.instance.getLoanings();
    else return LoanAndBorrowController.instance.getBorrowings();
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
          Icons.settings, 
          color: widget.isCollapsed? Colors.black : Colors.white,
        ),
        onPressed: (){
        },
      )
    ];
  }
}