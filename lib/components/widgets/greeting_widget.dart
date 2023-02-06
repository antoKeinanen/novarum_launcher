import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GreetingWidget extends StatefulWidget {
  GreetingWidget({Key? key}) : super(key: key);

  @override
  _GreetingWidgetState createState() => _GreetingWidgetState();
}

class _GreetingWidgetState extends State<GreetingWidget> {
  String _message = "Hei";
  String _month = "";
  int _date = 0;

  final List<String> _moths = [
    "tammikuuta",
    "helmikuuta",
    "maaliskuuta",
    "huhtikuuta",
    "toukokuuta",
    "kesäkuuta",
    "heinäkuuta",
    "elokuuta",
    "syyskuuta",
    "lokakuuta",
    "marraskuuta",
    "joulukuuta"
  ];

  late Timer _timer;

  @override
  void initState() {
    int hours = DateTime.now().hour;
    setState(() {
      _date = DateTime.now().day;
      _month = _moths[DateTime.now().month - 1];
      if (hours >= 4 && hours <= 12) {
        _message = "Hyvää huomenta";
      } else if (hours >= 12 && hours < 17) {
        _message = "Hyvää iltapäivää";
      } else if (hours >= 17 && hours < 21) {
        _message = "Hyvää iltaa";
      } else if (hours >= 21 && hours < 4) {
        _message = "Hyvää yötä";
      }
    });

    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      int hours = DateTime.now().hour;
      _month = _moths[DateTime.now().month - 1];
      setState(() {
        _date = DateTime.now().day;
        if (hours >= 4 && hours <= 12) {
          _message = "Hyvää huomenta";
        } else if (hours >= 12 && hours < 17) {
          _message = "Hyvää iltapäivää";
        } else if (hours >= 17 && hours < 21) {
          _message = "Hyvää iltaa";
        } else if (hours >= 21 && hours < 4) {
          _message = "Hyvää yötä";
        }
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
    return Column(children: [
      Text(
        "${_message} Anto!",
        style: TextStyle(
          fontSize: 25,
          fontFamily: "WorkSans",
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      Text(
        "Tänään on $_date. $_month!",
        style: TextStyle(
          fontSize: 20,
          fontFamily: "WorkSans",
          fontStyle: FontStyle.italic,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    ]);
  }
}
