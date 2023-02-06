import 'dart:async';

import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({Key? key}) : super(key: key);

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  String _hours = "00";
  String _minutes = "00";
  String _seconds = "00";

  late Timer _timer;

  @override
  void initState() {
    setState(() {
      _hours = DateTime.now().hour > 9
          ? "${DateTime.now().hour}"
          : "0${DateTime.now().hour}";
      _minutes = DateTime.now().minute > 9
          ? "${DateTime.now().minute}"
          : "0${DateTime.now().minute}";
      _seconds = DateTime.now().second > 9
          ? "${DateTime.now().second}"
          : "0${DateTime.now().second}";
    });

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _hours = DateTime.now().hour > 9
            ? "${DateTime.now().hour}"
            : "0${DateTime.now().hour}";
        _minutes = DateTime.now().minute > 9
            ? "${DateTime.now().minute}"
            : "0${DateTime.now().minute}";
        _seconds = DateTime.now().second > 9
            ? "${DateTime.now().second}"
            : "0${DateTime.now().second}";
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(
          Radius.circular(32.5),
        ),
      ),
      child: Center(
        child: Text(
          "$_hours:$_minutes:$_seconds",
          softWrap: false,
          overflow: TextOverflow.visible,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
