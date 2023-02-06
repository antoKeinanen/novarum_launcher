import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/rendering.dart';
import 'package:material_you_colours/material_you_colours.dart';
import 'package:novarum_launcher/pages/apps.dart';
import 'package:novarum_launcher/pages/home.dart';
import 'package:novarum_launcher/pages/news.dart';
import 'util/device_data.dart';

void main() {
  //showLayoutGuidelines();
  runApp(const MyApp());
}

void showLayoutGuidelines() {
  debugPaintSizeEnabled = true;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Main();
  }
}

class Main extends StatefulWidget {
  const Main({
    Key? key,
  }) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> with TickerProviderStateMixin {
  late dynamic _wallpaper;
  late TabController _tabController;
  late ThemeData? theme;

  @override
  void initState() {
    super.initState();

    DeviceData.getWallpaper().then((wall) {
      setState(() {
        _wallpaper = wall;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> allPages = [News(), Home(), Apps()];

    _tabController = TabController(
      vsync: this,
      length: allPages.length,
      initialIndex: 1,
    );

    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        theme: ThemeData(
          fontFamily: "WorkSans",
          colorScheme: lightColorScheme ??
              ColorScheme.fromSwatch(primarySwatch: Colors.blue),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          fontFamily: "WorkSans",
          colorScheme: darkColorScheme ??
              ColorScheme.fromSwatch(primaryColorDark: Colors.blue),
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: MemoryImage(_wallpaper), fit: BoxFit.cover),
            ),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: TabBarView(
                controller: _tabController,
                children: allPages.map((Widget widget) {
                  return SafeArea(
                    top: false,
                    bottom: false,
                    child: Container(
                      key: ObjectKey(widget),
                      child: widget,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );
    });
  }
}
