import 'package:flutter/material.dart';
import '../styles/colors_style.dart';

class SubmitButtonView extends StatefulWidget {
  final Size size;
  final Function onTap;
  final Text text;
  final ButtonStatus status;
  final Function onRoolBackCompleted;

  SubmitButtonView({
    this.size,
    this.onTap,
    this.text,
    this.status,
    this.onRoolBackCompleted,
  }) : super(key: UniqueKey());

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

enum ButtonStatus { original, tranform, rollback }

class _SubmitButtonState extends State<SubmitButtonView>
    with SingleTickerProviderStateMixin {
  Size _buttonSize;

  AnimationController _controller;
  Animation<double> _valueWidth, _rollbackWidthValue, _scaleText;

  @override
  void initState() {
    _buttonSize = widget.size;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        setState(() {
          if (status == AnimationStatus.completed &&
              widget.status == ButtonStatus.rollback &&
              widget.onRoolBackCompleted != null) {
            widget.onRoolBackCompleted();
          }
        });
      });

    _valueWidth = Tween(begin: widget.size.width, end: widget.size.height)
        .animate(_controller);

    _scaleText = Tween<double>(
      begin: widget.status == ButtonStatus.rollback ? 0.3 : 1.0,
      end: widget.status == ButtonStatus.rollback ? 1.0 : 0.3,
    ).animate(_controller);

    _rollbackWidthValue = Tween(
      begin: widget.size.height,
      end: widget.size.width,
    ).animate(_controller);

    super.initState();
    if (widget.status != ButtonStatus.original) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _getWidth() {
    if (widget.status == ButtonStatus.tranform) {
      return _valueWidth.value;
    } else if (widget.status == ButtonStatus.rollback) {
      return _rollbackWidthValue.value;
    }
    return widget.size.width;
  }

  Widget _getChild() {
    if (widget.status == ButtonStatus.tranform &&
        _valueWidth.value == _buttonSize.height) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
    return ScaleTransition(scale: _scaleText, child: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.status == ButtonStatus.original ||
            (_controller.status != AnimationStatus.forward &&
                widget.status == ButtonStatus.rollback)) {
          if (widget.onTap != null) {
            widget.onTap();
          }
        }
      },
      child: Container(
        width: _getWidth(),
        height: _buttonSize.height,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_buttonSize.height * 0.5),
          color: primaryColor,
        ),
        child: Align(
          alignment: Alignment.center,
          child: _getChild(),
        ),
      ),
    );
  }
}
