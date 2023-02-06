import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

const deviceChannel = MethodChannel("device");

class DeviceData {
  static Future<List<Application>> getAppList() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,
        includeAppIcons: true,
        includeSystemApps: true);
    return apps;
  }

  static Image getAppIcon(Application app) {
    return Image.memory((app as ApplicationWithIcon).icon, width: 32);
  }

  static void launchApp(Application app) {
    DeviceApps.openApp(app.packageName);
  }

  static Future<dynamic> getWallpaper() async {
    try {
      var result = await deviceChannel.invokeMethod('getWallpaper');
      return result;
    } on PlatformException catch (e) {
      print("Mehtod channel error ${e.message}");
    } on Exception catch (e) {
      print("Exeption caught at getWallpaper ${e}");
    }
  }

  static Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception("COuld not open url $url");
    }
  }
}
