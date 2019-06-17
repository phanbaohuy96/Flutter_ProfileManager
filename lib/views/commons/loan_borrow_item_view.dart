import 'package:flutter/material.dart';
import 'package:profile_manager/controller/loan_borrow_controler.dart';
import 'package:profile_manager/models/loan_and_borrow.dart';

class LoanAndBorrowItem extends StatefulWidget {

  final LoanAndBorrow loanAndBorrow;
  final Color backgroundColor;
  final Function(int) onLongPress;

  LoanAndBorrowItem(this.loanAndBorrow, {this.backgroundColor = Colors.white, this.onLongPress}) : super(key: UniqueKey());

  @override
  _LoanAndBorrowItemState createState() => _LoanAndBorrowItemState();
}

class _LoanAndBorrowItemState extends State<LoanAndBorrowItem> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<double> _scaleImageAnim;
  Animation<Offset> _slideAnimation;
  double _imageSizeOriginal = 30;
  double _imageSizeExpanded = 100;
  bool _isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleImageAnim = Tween<double>(
      begin: _imageSizeOriginal, 
      end: _imageSizeExpanded
    ).animate(
      _controller
    );
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(100, 0)).animate(_controller);
    _controller.addListener(() => setState(() {}) );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container( 
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: widget.backgroundColor
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
        child: InkWell(
          onTap: (){
            setState(() {
              if(!_isExpanded) _controller.forward(); else _controller.reverse(); 
              _isExpanded = !_isExpanded;       
            });
          },
          onLongPress: (){
            if(widget.onLongPress != null) widget.onLongPress(0);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[              
              Icon(widget.loanAndBorrow.isBorrow? Icons.monetization_on : Icons.money_off, color: Colors.grey,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[                          
                          Text(widget.loanAndBorrow.transactionPerson, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                          SizedBox(height: 3,),
                          Text(LoanAndBorrowController.instance.getCostLABVND(widget.loanAndBorrow), style: TextStyle(color: widget.loanAndBorrow.isBorrow? Colors.green : Colors.red, fontSize: 16)),
                        ],
                      ),
                      _isExpanded && widget.loanAndBorrow.hasDescription() ? 
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child:Text(widget.loanAndBorrow.description, style: TextStyle(color: Colors.grey, fontSize: 14))
                        ) 
                        : SizedBox()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}