import 'package:flutter/material.dart';

import '../components/widgets/battery_widget.dart';
import '../components/widgets/clock_widget.dart';
import '../components/widgets/greeting_widget.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100, bottom: 25),
                child: GreetingWidget(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BatteryWidget(),
                  ClockWidget(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
