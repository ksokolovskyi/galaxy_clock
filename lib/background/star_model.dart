import 'dart:math';

import 'package:flutter/material.dart';

class StarModel {
  static final _rnd = Random();

  final double size;

  final int lifeTime;

  final Alignment alignment;

  StarModel()
      : size = _rnd.nextDouble() * 3 + 1,
        lifeTime = (_rnd.nextDouble() * 5 + 3).toInt(),
        alignment = Alignment(
          _rnd.nextDouble() * 2 - 1,
          _rnd.nextDouble() * 2 - 1,
        );
}
