import 'package:flutter/material.dart';
import 'package:profile_manager/models/account.dart';

class AccountItem extends StatefulWidget {

  final Account account;
  final String groupImageAsset;
  final Color backgroundColor;
  final Function onDoubleTap;

  AccountItem({this.backgroundColor = Colors.white, this.account = const Account("", ""), this.groupImageAsset = "", this.onDoubleTap}) : super(key: UniqueKey());

  @override
  _AccountItemState createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem> with SingleTickerProviderStateMixin{

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
    
    return InkWell(
      onTap: (){
        setState(() {
          if(!_isExpanded) _controller.forward(); else _controller.reverse(); 
          _isExpanded = !_isExpanded;       
        });
      },
      onDoubleTap: (){
        if(widget.onDoubleTap != null) widget.onDoubleTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, bottom: 5, top: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: widget.backgroundColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[            
              Transform.translate(
                offset: _slideAnimation.value,
                //position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: _scaleImageAnim.value,
                    height: _scaleImageAnim.value,
                    child: Image.asset( widget.account.avatarAsset == ""? widget.groupImageAsset : widget.account.avatarAsset),
                  ),
                ),
              ),
              Flexible(child: Text(widget.account.userName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16), overflow: TextOverflow.ellipsis,))
            ],
          ),
        ),
      ),
    );
  }
}