import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> searchVideos(String query) async {
  final apiKey = 'YOUR API KEY FROM YOUTUBE '; // Replace with your actual API key
  final apiUrl = 'https://www.googleapis.com/youtube/v3/search'
      '?part=snippet'
      '&q=$query'
      '&key=$apiKey';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> videos = data['items'];
    List<Map<String, dynamic>> videoList = [];
    for (var video in videos) {
      String title = video['snippet']['title'];
      String thumbnailUrl = video['snippet']['thumbnails']['default']['url'];
      videoList.add({
        'title': title,
        'thumbnailUrl': thumbnailUrl,
      });
    }
    return videoList;
  } else {
    // Handle error
    print('Failed to fetch videos: ${response.statusCode}');
    return [];
  }
}
