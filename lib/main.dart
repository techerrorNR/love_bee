import 'package:flutter/material.dart';
import 'code_generator.dart'; // Import the code generator
import 'enter_code_screen.dart'; // Import the Enter Code screen
import 'music_screen.dart'; // Import the Music screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Love Bee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MusicOptionsScreen(),
        '/generate_code': (context) => GenerateCodeScreen(),
        '/enter_code': (context) => EnterCodeScreen(),
        '/music': (context) => MusicScreen(), // New route for Music screen
      },
    );
  }
}

class MusicOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Love Bee'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/generate_code');
              },
              child: Text('Generate Unique Code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/enter_code');
              },
              child: Text('Enter Code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/music');
              },
              child: Text('Play Alone'),
            ),
          ],
        ),
      ),
    );
  }
}

class GenerateCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uniqueCode = generateUniqueCode(); // Generate unique code
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Unique Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Unique Code:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              uniqueCode,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
