import 'package:flutter/material.dart';
import 'package:galaxy_clock/background/star.dart';

class Background extends StatelessWidget {
  final int starsCount;

  Background({this.starsCount = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: List.generate(
          starsCount,
          (i) => Star(),
        ),
      ),
    );
  }
}
