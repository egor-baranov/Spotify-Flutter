import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_flutter/globals.dart' as globals;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/enums/repeat_mode_enum.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:spotify_flutter/util/spotify_connection_worker.dart';
import 'package:share/share.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: 32, left: 32, bottom: 32, top: 64),
                  child: Text("Spotify X",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Nunito',
                          fontSize: 36,
                          color: Colors.grey[800])),
                ),
                menuButton("Spotify X+", Icons.add_box_outlined, Colors.green[300]),
                menuButton("Favourite tracks", Icons.favorite_outline, Colors.redAccent[200]),
                menuButton("Favourite Albums", Icons.album_outlined, Colors.blue[400]),
                menuButton("Preferences", Icons.settings, Colors.purple[300]),
                menuButton("About app", Icons.account_circle_rounded, Colors.amber[400]),
              ],
            ),
            padding: EdgeInsets.all(4),
          )),
    );
  }

  Widget menuButton(String text, IconData iconData, Color iconColor) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(minWidth: double.infinity, minHeight: 90),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                )),
            onPressed: () {},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Icon(iconData,
                      size: 28, color: iconColor),
                ),
                Text(text,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        color: Colors.grey[800])),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.grey[800]),
                ),
              ],
            ),
          ),
        ),
      );
}
