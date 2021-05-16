import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
                      // getAuthenticationToken();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );
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
    print("Access token is $accessToken");
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Divider(height: 80, color: Colors.transparent),
        Text(
          "Some header text.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: globals.spotifyBlackColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              fontFamily: 'Nunito'),
        ),
        Divider(height: 50, color: Colors.transparent),
        Swiper(
          itemCount: 10,
          itemWidth: 300,
          itemHeight: 450,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 4,
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Track №${index + 1}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: globals.spotifyBlackColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Nunito'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 224, right: 16, bottom: 16, left: 216),
                          child: RawMaterialButton(
                            elevation: 0,
                            onPressed: () {},
                            fillColor: globals.spotifyGreenColor,
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                              size: 32,
                            ),
                            padding: EdgeInsets.all(12),
                          ),
                        )
                      ]),
                ),
              ),
            );
          },
          layout: SwiperLayout.STACK,
          viewportFraction: 2,
          scale: 0.9,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Slider(
            value: 0,
            onChanged: (value) {
              print(value);
            },
            activeColor: globals.spotifyGreenColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 216),
              child: Text(
                "0:00",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: globals.spotifyBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Nunito'),
              ),
            ),
            Text(
              "3:14",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: globals.spotifyBlackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Nunito'),
            )
          ],
        ),
        RawMaterialButton(
          elevation: 8,
          onPressed: () {
            Fluttertoast.showToast(
              msg: "Here should be a pause but I didn't implement it yet.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          },
          fillColor: globals.spotifyGreenColor,
          shape: CircleBorder(),
          child: Icon(
            Icons.pause,
            color: Colors.white,
            size: 32,
          ),
          padding: EdgeInsets.all(16),
        )
      ],
    ));
  }
}
