
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'player_screen.dart';

class ChannelListScreen extends StatefulWidget {
  final String apiUrl;
  final bool useXtream;
  ChannelListScreen({required this.apiUrl, required this.useXtream});

  @override
  _ChannelListScreenState createState() => _ChannelListScreenState();
}

class _ChannelListScreenState extends State<ChannelListScreen> {
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchChannels();
  }

  void fetchChannels() async {
    if (widget.useXtream) {
      final res = await http.get(Uri.parse(widget.apiUrl));
      final data = json.decode(res.body);
      setState(() => items = data['live_streams']);
    } else {
      // implementar parser M3U se necessário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Canais')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];
          final streamUrl = '\${widget.apiUrl.replaceFirst('player_api.php', 'live/\${item['stream_id']}/\${item['stream_id']}.m3u8')}';
          return ListTile(
            title: Text(item['name']),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => PlayerScreen(url: streamUrl))),
          );
        },
      ),
    );
  }
}
