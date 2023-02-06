import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:on_click/on_click.dart';

import '../../util/device_data.dart';
import '../../util/tunicate.dart';

class NewsHeadline extends StatelessWidget {
  const NewsHeadline(this._headline, this._imgUrl, this._openUrl, {Key? key})
      : super(key: key);

  final String _headline;
  final String _imgUrl;
  final String _openUrl;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.55;

    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.topCenter,
                    image: NetworkImage(
                      _imgUrl,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: c_width,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              tunicate(
                _headline,
                length: 107,
              ),
              maxLines: 5,
              softWrap: true,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        ],
      ).onClick(() {
        DeviceData.openUrl(_openUrl);
      }),
    );
  }
}
