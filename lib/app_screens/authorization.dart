import 'package:flutter/material.dart';

import 'package:spotify_flutter/app_screens/player.dart';
import 'package:spotify_flutter/globals.dart' as globals;
import 'package:spotify_flutter/util/spotify_connection_worker.dart';

class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  AuthorizationPageState createState() => AuthorizationPageState();
}

class AuthorizationPageState extends State<AuthorizationPage> {
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        )),
                    onPressed: () async {
                      await SpotifyConnectionWorker.getAuthenticationToken();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlayerPage()),
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
}
