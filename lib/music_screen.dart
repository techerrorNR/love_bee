import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  List<Map<String, dynamic>> musicList = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    fetchMusic();
  }

  Future<void> fetchMusic() async {
    final apiKey = 'YOUR API KEY FROM YOUTUBE '; // Replace with your actual API key
    final apiUrl = 'https://www.googleapis.com/youtube/v3/search'
        '?part=snippet'
        '&q=$searchText' // Use searchText for searching
        '&maxResults=50' // Adjust the number of results as needed
        '&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> items = data['items'];
      setState(() {
        musicList = items.map((item) => item['snippet'] as Map<String, dynamic>).toList();
      });
    } else {
      print('Failed to fetch music: ${response.statusCode}');
    }
  }

  Future<void> searchMusic(String query) async {
    setState(() {
      searchText = query;
    });
    await fetchMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Love Bee'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String? result = await showSearch<String>(
                context: context,
                delegate: MusicSearchDelegate(),
              );
              if (result != null) {
                searchMusic(result);
              }
            },
          ),
        ],
      ),
      body: musicList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          final music = musicList[index];
          return ListTile(
            leading: Image.network(
                music['thumbnails']['default']['url']), // Fix here
            title: Text(music['title']),
            onTap: () {
              if (music['videoId'] != null) {
                // Play the selected video
                String videoId = music['videoId']; // Adjust the key based on your YouTube API response
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerPage(videoId: videoId),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class MusicSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Searching...'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Suggestion 1'),
          onTap: () {
            close(context, 'Suggestion 1');
          },
        ),
        ListTile(
          title: Text('Suggestion 2'),
          onTap: () {
            close(context, 'Suggestion 2');
          },
        ),
        // Add more suggestions here
      ],
    );
  }
}

class VideoPlayerPage extends StatelessWidget {
  final String videoId;

  const VideoPlayerPage({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Column(
        children: [
          // You can use any video player widget here
          Text('Video Player for $videoId'),
          // Below, you can display recommended videos based on the selected video
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MusicScreen(),
  ));
}
