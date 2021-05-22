import 'package:flutter/material.dart';
import 'package:spotify_flutter/app_screens/authorization.dart';
import 'globals.dart' as globals;

void main() {
  runApp(SpotifyApp());
}

class SpotifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Demo Build',
      theme: ThemeData(
        fontFamily: 'Nunito',
        primarySwatch: globals.spotifyGreenColor,
      ),
      home: AuthorizationPage(title: 'Spotify Flutter Custom Client'),
      debugShowCheckedModeBanner: false,
    );
  }
}
