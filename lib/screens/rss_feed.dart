import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart';
import 'package:ionicons/ionicons.dart';
import 'view_rss_feed.dart';

class RssFeedScreen extends StatefulWidget {
  const RssFeedScreen({Key? key, required this.title, required this.feedUrl})
      : super(key: key);
  final String title;
  final String feedUrl;

  @override
  State<RssFeedScreen> createState() => RssFeedScreenState();
}

class RssFeedScreenState extends State<RssFeedScreen> {
  bool isLoading = false;
  late RssFeed rss = RssFeed();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await get(Uri.parse(widget.feedUrl));
      var channel = RssFeed.parse(response.body);
      setState(() {
        rss = channel;
        isLoading = false;
      });
    } catch (err) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => loadData(),
                child: Row(
                  children: const [
                    Icon(Ionicons.refresh_circle),
                    Text('Refresh')
                  ],
                ))
          ],
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                    itemCount: rss.items!.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = rss.items![index];
                      final feedItem = {
                        'title': item.title,
                        'description': item.description,
                        'imageUrl': item.enclosure!.url,
                        'link': item.link,
                        'pubDate': item.pubDate,
                      };
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewRssScreen(
                                    rssFeed: feedItem,
                                  )));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(item.enclosure!.url!)),
                              const SizedBox(height: 8),
                              Text(
                                item.title!,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    })));
  }
}
