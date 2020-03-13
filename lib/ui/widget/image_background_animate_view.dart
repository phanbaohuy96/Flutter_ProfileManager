import 'package:flutter/material.dart';

class ImageBackgroundAnimateView extends StatefulWidget {
  final Duration duration;
  final String imagePath;

  const ImageBackgroundAnimateView(this.imagePath,
      {Key key, this.duration = const Duration(seconds: 5)})
      : super(key: key);

  @override
  _ImageBackgroundAnimateStateView createState() =>
      _ImageBackgroundAnimateStateView();
}

class _ImageBackgroundAnimateStateView extends State<ImageBackgroundAnimateView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleOut, _scaleIn;
  bool _isOut = true;

  @override
  void initState() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleOut = Tween<double>(begin: 1, end: 1.1).animate(_controller);
    _scaleIn = Tween<double>(begin: 1.1, end: 1).animate(_controller);

    _controller
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller
            ..reset()
            ..forward();
          _isOut = !_isOut;
        }
      });
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _isOut ? _scaleOut.value : _scaleIn.value,
      child: Image.asset(
        widget.imagePath,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
