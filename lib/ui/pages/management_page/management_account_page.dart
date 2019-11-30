import 'package:flutter/material.dart';
import 'package:profile_manager/models/account.dart';
import 'package:profile_manager/ui/widget/account_item_view.dart';
import 'package:profile_manager/ui/widget/doc_list_index_view.dart';

class ManagementAccountPage extends StatefulWidget {

  final bool isCollapsed;
  final Color mainColor;

  ManagementAccountPage({this.isCollapsed, this.mainColor});

  @override
  _ManagementAccountPageState createState() => _ManagementAccountPageState();
}

class _ManagementAccountPageState extends State<ManagementAccountPage> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _fadeAnimation;

  Size _screenSize;
  int _selectedIdx = 0;  

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          height: 230.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight:  Radius.circular(30)),
            color: widget.mainColor
          ),
          padding: EdgeInsets.only(top: 10.0, left: 5, right: 5, bottom: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 190,
                child: ListView.builder(
                  
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, idx)
                  {
                    return _buildGroupAccount(idx == 0? null :accountGroups[idx - 1], idx);
                  },
                  itemCount: accountGroups.length + 1,
                ),
              ),
              DocListIndex(numItems: accountGroups.length + 1, selectedIdx: _selectedIdx, normalColor: Colors.grey.withOpacity(0.3),)
            ],
          ),
        ),

        //list of accounts
        Padding(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Accounts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: widget.isCollapsed? Colors.black : Colors.white),),
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

                child: _selectedIdx == 0? ListView(
                  padding: EdgeInsets.zero,
                  children: _buildAllAccountItem(),
                )
                : ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, idx){
                    return AccountItem(account: accountGroups[_selectedIdx - 1].accounts[idx], backgroundColor: widget.mainColor, groupImageAsset: accountGroups[_selectedIdx - 1].imageAsset);
                  },
                  itemCount: accountGroups[_selectedIdx - 1].accounts.length,
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

  Widget _buildGroupAccount(AccountGroup group, int idx) {
    return InkWell(
      onTap: (){
        if(_selectedIdx == idx) return;
        setState(() {
         _selectedIdx = idx; 
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 16.0),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: widget.mainColor,
          elevation: 7,
          shadowColor: _selectedIdx == idx? Colors.blue : Colors.grey,
          child: SizedBox(        
            width: _screenSize.width / 2.5, 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15,),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: idx == 0? Icon(Icons.account_circle, size: 100,color: Colors.black54,)
                    :group.hasImageAsset() ? Image.asset(group.imageAsset) : Align(child: Text(group.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black), overflow: TextOverflow.ellipsis,))
                ),
                SizedBox(height: 5,),
                Text(idx == 0? "All" : "Count: " + group.accounts.length.toString(), style: TextStyle(color: Colors.black, fontSize: 18),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAllAccountItem()
  {
    List<AccountItem> _accounts = [];
    for(int i = 0; i< accountGroups.length; i++)
      for(int j = 0; j < accountGroups[i].accounts.length; j++)
      {
        _accounts.add(AccountItem(account: accountGroups[i].accounts[j], backgroundColor: widget.mainColor, groupImageAsset: accountGroups[i].imageAsset));
      }
    return _accounts;
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