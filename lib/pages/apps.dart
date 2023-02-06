
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fuzzysearch/fuzzysearch.dart';
import 'package:on_click/on_click.dart';

import '../components/widgets/app_label.dart';
import '../util/device_data.dart';

class Apps extends StatefulWidget {
  const Apps({Key? key}) : super(key: key);

  @override
  _AppsState createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  Map<String, String> _packageNameToAppNameMap = new Map();
  Map<String, Application> _packageNameToApplicationMap = new Map();
  List<Widget> apps = [];

  final searchController = TextEditingController();

  @override
  void initState() {
    apps = buildAppsList();

    DeviceData.getAppList().then((apps) {
      setState(() {
        apps.forEach((app) {
          _packageNameToAppNameMap[app.packageName] = app.appName;
          _packageNameToApplicationMap[app.packageName] = app;
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  Future<void> search(String search) async {
    final fuse = Fuzzy(
      _packageNameToAppNameMap.values.toList(),
      options: FuzzyOptions(
        findAllMatches: true,
        tokenize: true,
        isCaseSensitive: false,
        threshold: 0.5,
        shouldSort: true,
      ),
    );

    final result = await fuse.search(search);

    List<String> filter = result.map((res) => res.item).toList();

    print(filter);

    setState(() {
      apps = buildAppsList(filter);
    });
  }

  List<Widget> buildAppsList([List<String>? filter]) {
    List<Widget> appsList = [];
    _packageNameToAppNameMap.forEach((packageName, appName) {
      if (filter != null && filter.isNotEmpty && !filter.contains(appName)) {
        return;
      }
      appsList.add(AppLabel(
          _packageNameToApplicationMap[packageName]!, packageName, appName));
    });

    return appsList;
  }

  @override
  Widget build(BuildContext context) {
    if (apps.isEmpty) {
      setState(() {
        apps = buildAppsList();
      });
    }

    return Container(
      color: Theme.of(context).colorScheme.background.withAlpha(170),
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Container(
        margin: const EdgeInsets.only(top: 75),
        child: Align(
          alignment: Alignment.topCenter,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                flexibleSpace: Center(
                  child: TextField(
                    onSubmitted: (value) => search(value),
                    controller: searchController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        labelText: "Hae Sovelluksia",
                        suffixIcon: const Icon(FeatherIcons.search).onClick(() {
                          search(searchController.text);
                        }),
                        labelStyle: const TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
              ),
              SliverGrid.count(
                childAspectRatio: 8 / 3,
                crossAxisCount: 2,
                children: apps,
              )
            ],
          ),
        ),
      ),
    );
  }
}
