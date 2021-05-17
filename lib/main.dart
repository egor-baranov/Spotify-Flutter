import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
      debugShowCheckedModeBanner: false
    );
  }
}
