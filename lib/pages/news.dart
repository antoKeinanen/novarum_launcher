import 'dart:convert';

import 'package:dart_rss/domain/rss_feed.dart';
import 'package:dart_rss/domain/rss_image.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:flutter/material.dart';

import '../components/widgets/news_headline.dart';
import '../util/rss_fetcher.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<Widget> news = [];

  @override
  void initState() {
    fetchRssFeed("https://www.hs.fi/rss/teasers/etusivu.xml").then(
      (value) {
        setState(() {
          news = buildNewsList(value);
        });
      },
    );

    super.initState();
  }

  List<Widget> buildNewsList(RssFeed newsFeed) {
    List<Widget> newsList = [];
    for (RssItem item in newsFeed.items) {
      if (item.enclosure == null || item.enclosure!.url == null) continue;
      newsList.add(
        Container(
          child: NewsHeadline(
            item.title.toString(),
            item.enclosure!.url.toString(),
            item.link.toString(),
          ),
        ),
      );
    }

    return newsList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 65, left: 30),
      color: Theme.of(context).colorScheme.background.withAlpha(170),
      child: SingleChildScrollView(
        child: Wrap(
          children: news,
        ),
      ),
    );
  }
}
