import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:galaxy_clock/background/background.dart';
import 'package:galaxy_clock/clock/circle.dart';
import 'package:galaxy_clock/clock/theme.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

final radiansPerMinute = radians(360 / 60);
final radiansPerHour = radians(360 / 12);

class GalaxyClock extends StatefulWidget {
  const GalaxyClock(this.model);

  final ClockModel model;

  @override
  _GalaxyClockState createState() => _GalaxyClockState();
}

class _GalaxyClockState extends State<GalaxyClock> {
  DateTime _now = DateTime.now();

  WeatherCondition _weather;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(GalaxyClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() => _weather = widget.model.weatherCondition);
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.Hms().format(DateTime.now());
    final theme = _getClockTheme();

    return LayoutBuilder(
      builder: (context, constraints) {
        final minutesDiameter = constraints.maxHeight - 40;
        final minutesWidth = 0.1 * minutesDiameter;
        final hoursDiameter = minutesDiameter - minutesWidth * 2 + 0.5;
        final hoursWidth = 0.2 * minutesDiameter + 0.5;
        final centerDiameter = 0.4 * minutesDiameter + 0.5;

        return Semantics.fromProperties(
          properties: SemanticsProperties(
            label: 'Galaxy clock with time $time',
            value: time,
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Background(),
                ClockCircle(
                  diameter: minutesDiameter,
                  strokeWidht: minutesWidth,
                  theme: theme,
                  angleRadians: (_now.minute * radiansPerMinute) +
                      (_now.second / 60) * radiansPerMinute,
                ),
                ClockCircle(
                  diameter: hoursDiameter,
                  strokeWidht: hoursWidth,
                  theme: theme,
                  angleRadians: (_now.hour * radiansPerHour) +
                      (_now.minute / 60) * radiansPerHour,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  height: centerDiameter,
                  width: centerDiameter,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ClockTheme _getClockTheme() {
    switch (_weather) {
      case WeatherCondition.sunny:
        return ClockTheme.orange;
      case WeatherCondition.rainy:
        return ClockTheme.blue;
      case WeatherCondition.snowy:
        return ClockTheme.white;
      case WeatherCondition.foggy:
      case WeatherCondition.cloudy:
        return ClockTheme.grey;
      case WeatherCondition.thunderstorm:
      case WeatherCondition.windy:
      default:
        return ClockTheme.purple;
    }
  }
}
