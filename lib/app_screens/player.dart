import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_flutter/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  var isPlaying = false;
  var isLoading = false;
  var likedTracks = [];

  @override
  initState() {
    for (var i = 0; i < 10; i++) {
      likedTracks.add(false);
    }
    super.initState();
  }

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
                              top: 256, right: 16, bottom: 16, left: 216),
                          child: RawMaterialButton(
                            elevation: 0,
                            onPressed: () {
                              setState(() {
                                likedTracks[index] = !likedTracks[index];
                              });
                            },
                            fillColor: globals.spotifyGreenColor,
                            shape: CircleBorder(),
                            child: Icon(
                              likedTracks[index]
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
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
            setState(() {
              isPlaying = !isPlaying;
            });
            play();
          },
          fillColor: globals.spotifyGreenColor,
          shape: CircleBorder(),
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 32,
          ),
          padding: EdgeInsets.all(16),
        )
      ],
    ));
  }

  Future<void> play() async {
    await SpotifySdk.play(spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
  }

  Future<void> disconnect() async {
    try {
      setState(() {
        isLoading = true;
      });
      var result = await SpotifySdk.disconnect();
      setState(() {
        isLoading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        isLoading = false;
      });
    } on MissingPluginException {
      setState(() {
        isLoading = false;
      });
    }
  }
}
