import 'package:dart_rss/domain/rss_feed.dart';
import "package:http/http.dart" as http;

Future<RssFeed> fetchRssFeed(String url) async {
  Uri uri = Uri.parse(url);
  var response = await http.get(uri);
  RssFeed rssFeed = RssFeed.parse(response.body);

  return rssFeed;
}
