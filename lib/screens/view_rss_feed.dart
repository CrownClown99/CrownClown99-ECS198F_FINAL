import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ionicons/ionicons.dart';

class ViewRssScreen extends StatefulWidget {
  final rssFeed;
  const ViewRssScreen({Key? key, required this.rssFeed}) : super(key: key);

  @override
  State<ViewRssScreen> createState() => _ViewRssScreenState();
}

class _ViewRssScreenState extends State<ViewRssScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(widget.rssFeed['imageUrl']),
              ),
              const SizedBox(height: 8),
              Text(
                widget.rssFeed['title'],
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Ionicons.time_sharp),
                  const SizedBox(width: 4),
                  Text(DateFormat('MMM dd').format(
                      DateTime.parse(widget.rssFeed['pubDate'].toString()))),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.rssFeed['description'],
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  onPressed: () => launchUrl(Uri.parse(widget.rssFeed['link'])),
                  icon: const Icon(Ionicons.link),
                  label: const Text('Visit Website For Full Article'))
            ],
          ),
        ));
  }
}
