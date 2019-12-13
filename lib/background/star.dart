import 'package:flutter/material.dart';
import 'package:galaxy_clock/background/star_model.dart';

class Star extends StatefulWidget {
  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> with TickerProviderStateMixin {
  AnimationController _controller;

  StarModel _model;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _model = StarModel();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _model.lifeTime),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller?.dispose();
        setState(() => _init());
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _model.alignment,
      child: AnimatedBuilder(
        animation: _controller,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          height: _model.size,
          width: _model.size,
        ),
        builder: (context, child) {
          return Opacity(
            opacity: _controller.value,
            child: child,
          );
        },
      ),
    );
  }
}
