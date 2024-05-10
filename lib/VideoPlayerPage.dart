import 'package:flutter/material.dart';

class VideoPlayerPage extends StatelessWidget {
  final String videoId;

  const VideoPlayerPage({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9, // Adjust aspect ratio as needed
              child: Container(

              ),
            ),
            SizedBox(height: 20),
            Text(
              'Recommended Videos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

          ],
        ),
      ),
    );
  }
}
