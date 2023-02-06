import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:on_click/extensions/click_extension.dart';

import '../../util/device_data.dart';
import '../../util/tunicate.dart';

class AppLabel extends StatelessWidget {
  const AppLabel(this._app, this._packageName, this._appName, {Key? key})
      : super(key: key);

  final Application _app;
  final String _packageName;
  final String _appName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: DeviceData.getAppIcon(_app),
        ),
        const SizedBox(width: 20),
        Text(
          tunicate(_appName),
          style: const TextStyle(fontSize: 20),
        ),
      ],
    ).onClick(
      () {
        DeviceApps.openApp(_packageName);
      },
    );
  }
}
