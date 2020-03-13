import 'package:flutter/material.dart';
import 'package:profile_manager/controller/loan_borrow_controler.dart';
import 'package:profile_manager/models/loan_and_borrow.dart';

class LoanAndBorrowItem extends StatefulWidget {
  final LoanAndBorrow loanAndBorrow;
  final Color backgroundColor;
  final Function(int) onLongPress;

  LoanAndBorrowItem(
    this.loanAndBorrow, {
    this.backgroundColor = Colors.white,
    this.onLongPress,
  }) : super(key: UniqueKey());

  @override
  _LoanAndBorrowItemState createState() => _LoanAndBorrowItemState();
}

class _LoanAndBorrowItemState extends State<LoanAndBorrowItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    )..addListener(() => setState(() {}));
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
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: widget.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            setState(() {
              if (!_isExpanded) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
              _isExpanded = !_isExpanded;
            });
          },
          onLongPress: () {
            if (widget.onLongPress != null) {
              widget.onLongPress(0);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget.loanAndBorrow.isBorrow
                    ? Icons.monetization_on
                    : Icons.money_off,
                color: Colors.grey,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.loanAndBorrow.transactionPerson,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            LoanAndBorrowController.instance
                                .getCostLABVND(widget.loanAndBorrow),
                            style: TextStyle(
                              color: widget.loanAndBorrow.isBorrow
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      _isExpanded && widget.loanAndBorrow.hasDescription()
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                widget.loanAndBorrow.description,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : const SizedBox()
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
