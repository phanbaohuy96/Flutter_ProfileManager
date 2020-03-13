import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldNumbericPassword extends StatefulWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final String hint;
  final String text;
  final int passLength;
  final Function onTextChanged;
  final Function onTextReachedLimit;

  const TextfieldNumbericPassword({
    Key key,
    this.width = 100.0,
    this.height = 50.0,
    this.backgroundColor = Colors.white,
    this.hint = '',
    this.text = '',
    this.passLength = 6,
    this.onTextChanged,
    this.onTextReachedLimit,
  }) : super(key: key);

  static _TextfieldNumbericPasswordState textfieldState;
  @override
  _TextfieldNumbericPasswordState createState() {
    //ignore: join_return_with_assignment
    textfieldState = _TextfieldNumbericPasswordState();
    return textfieldState;
  }
}

class _TextfieldNumbericPasswordState extends State<TextfieldNumbericPassword> {
  TextEditingController _textController;
  bool isShowProgressPassword = false;
  int maxPassLength = 0;
  int curPassLength = 0;
  FocusNode _focusNode;

  @override
  void initState() {
    maxPassLength = widget.passLength;
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _textController.text = widget.text;
    onTextChanged(widget.text);
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void onTextChanged(String text) {
    final int length = text.length;
    if (length == curPassLength) {
      return;
    }
    curPassLength = length;
    if (widget.onTextChanged != null) {
      widget.onTextChanged(text);
    }
    setState(() {
      isShowProgressPassword = text.isNotEmpty;
    });
    if (curPassLength == maxPassLength && widget.onTextReachedLimit != null) {
      widget.onTextReachedLimit(text);
    }
  }

  void notifyTextChange(String text) {
    _textController.text = text;
    onTextChanged(text);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      Align(
        alignment: Alignment.center,
        child: TextField(
          onChanged: onTextChanged,
          controller: _textController,
          textAlign: TextAlign.center,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: widget.hint),
          obscureText: true,
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxPassLength),
          ],
          keyboardType: TextInputType.number,
          focusNode: _focusNode,
        ),
      )
    ];

    if (isShowProgressPassword) {
      items.add(InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(_focusNode);
          _textController.clear();
          onTextChanged('');
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.height * 0.5)),
              color: widget.backgroundColor),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildItem(),
          ),
        ),
      ));
    }
    items.add(
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Icon(
            Icons.lock,
            color: Colors.black,
          ),
        ),
      ),
    );
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.height * 0.5)),
          color: widget.backgroundColor),
      child: Stack(
        children: items,
      ),
    );
  }

  List<Widget> buildItem() {
    final List<Widget> items = List(maxPassLength);
    for (int i = 0; i < maxPassLength; i++) {
      items[i] = Container(
        height: widget.height * 0.25,
        width: widget.height * 0.25,
        margin: EdgeInsets.all(widget.height / 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: i < curPassLength ? Colors.black87 : Colors.grey,
        ),
      );
    }
    return items;
  }
}
