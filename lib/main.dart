import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      home: MainPage(title: 'Spotify Flutter Custom Client'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Hey.\nThis is a custom Spotify client made using Flutter.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: globals.spotifyBlackColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nunito'),
            ),
            Divider(height: 50, color: Colors.transparent),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(32),
              child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        elevation: 8,
                        shadowColor: globals.spotifyGreenColor,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(28),
                        )),
                    onPressed: () {
                      getAuthenticationToken();
                    },
                    label: Text(
                      'Sign in with Spotify',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    icon: Container(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          "assets/spotify_icon.png",
                        )),
                  )),
            ),
            Divider(height: 200, color: Colors.transparent),
          ],
        ),
      ),
    );
  }

  void getAuthenticationToken() async {
    final result = await FlutterWebAuth.authenticate(
      url: "https://accounts.spotify.com/authorize?" +
          "client_id=${globals.client_id}&" +
          "redirect_uri=${globals.redirect_uri}&" +
          "scope=user-read-currently-playing&" +
          "response_type=token&" +
          "state=123",
      callbackUrlScheme: "spotifyflutter",
    );

    var accessToken = Uri.parse(result).queryParameters['token'];
    print(accessToken);
  }
}
