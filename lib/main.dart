import 'package:flutter/material.dart';
import 'screens/rss_feed.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RSS NEWS FEED',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  HomeView createState() => HomeView();
}

class HomeView extends State<MyHomePage> {
  static List<String> topics = [
    'Health',
    'UN Affairs',
    'Law and Crime Prevention',
    'Human Rights',
    'Humanitarian Aid',
    'Climate Change',
    'Culture and Education',
    'Economic Development',
    'Women',
    'Peace and Security',
    'Migrants and Refugees',
    'SDGs'
  ];

  static List<String> urls = [
    'https://news.un.org/feed/subscribe/en/news/topic/health/feed/rss.xml',
    'https://news.un.org/feed/subscribe/en/news/topic/un-affairs/feed/rss.xml',
    'https://news.un.org/feed/subscribe/en/news/topic/law-and-crime-prevention/feed/rss.xml',
    'https://news.un.org/feed/subscribe/en/news/topic/human-rights/feed/rss.xml',
    'https://news.un.org/feed/subscribe/en/news/topic/humanitarian-aid/feed/rss.xml',
    'https://news.un.org/feed/subscribe/en/news/topic/climate-change/feed/rss.xml',
    'https://news.un.org/feed/subscribe/en/news/topic/culture-and-education/feed/rss.xml',
    'https://news.un.org/feed/subscribe/en/news/topic/economic-development/feed/rss.xml',
    'https://news.un.org/feed/subscribe/en/news/topic/women/feed/rss.xml',
    'https://news.un.org/feed/subscribe/en/news/topic/peace-and-security/feed/rss.xml',
    'https://news.un.org/feed/subscribe/en/news/topic/migrants-and-refugees/feed/rss.xml',
    'https://news.un.org/feed/subscribe/en/news/topic/sdgs/feed/rss.xml'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOPICS'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(topics[index]),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RssFeedScreen(
                      title: topics[index],
                      feedUrl: urls[index],
                    )));
              },
            ),
          );
        },
      ),
    );
  }
}
