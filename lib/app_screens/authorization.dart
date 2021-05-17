import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_flutter/app_screens/player.dart';
import 'package:spotify_flutter/globals.dart' as globals;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

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
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(28),
                        )),
                    onPressed: () {
                      // getAuthenticationToken();
                      connectToSpotifyRemote();
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

  // void getAuthenticationToken() async {
  //   final result = await FlutterWebAuth.authenticate(
  //     url: "https://accounts.spotify.com/authorize?" +
  //         "client_id=${globals.client_id}&" +
  //         "redirect_uri=${globals.redirect_uri}&" +
  //         "scope=user-read-currently-playing&" +
  //         "response_type=token&" +
  //         "state=123",
  //     callbackUrlScheme: "spotifyflutter",
  //   );
  //
  //   var accessToken = Uri.parse(result).queryParameters['token'];
  //   print("Access token is $accessToken");
  // }
  Future<String> getAuthenticationToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAuthenticationToken(
          clientId: globals.client_id.toString(),
          redirectUrl: globals.redirect_uri.toString(),
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      print('Got a token: $authenticationToken');
      return authenticationToken;
    } on PlatformException catch (e) {
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      print('not implemented');
      return Future.error('not implemented');
    }
  }

  Future<void> connectToSpotifyRemote() async {
    var result = await SpotifySdk.connectToSpotifyRemote(
        clientId: globals.client_id, redirectUrl: globals.redirect_uri);
  }
}
