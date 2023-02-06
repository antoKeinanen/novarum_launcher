import 'dart:async';
import 'dart:io';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryWidget extends StatefulWidget {
  BatteryWidget({Key? key, this.corePalette}) : super(key: key);

  dynamic corePalette;

  @override
  _BatteryWidgetState createState() => _BatteryWidgetState(corePalette);
}

class _BatteryWidgetState extends State<BatteryWidget> {
  Battery _battery = Battery();
  int _level = 100;

  dynamic corePalette;

  _BatteryWidgetState(this.corePalette);

  void updateBatteryPercentage() async {
    final level = await _battery.batteryLevel;

    final updated = level != _level;

    if (updated) {
      _level = level;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    updateBatteryPercentage();

    Timer.periodic(const Duration(seconds: 5), (timer) {
      updateBatteryPercentage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                "$_level%",
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: _level.toDouble() / 100,
                strokeWidth: 5,
              ),
            ),
          ],
        ));
  }
}
