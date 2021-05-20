import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_flutter/globals.dart' as globals;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:spotify_flutter/util/spotify_connection_worker.dart';
import 'package:share/share.dart';

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  var trackName = "Track name is loading..";
  var trackImageUrl = "";
  var isPlaying = false;
  var isLoading = false;
  var likedTracks = [];
  var trackLink = "...";
  var authorName = "...";

  var progress = 0;
  var duration = 0;

  var colorList = [
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent
  ];

  @override
  initState() {
    for (var i = 0; i < 10; i++) {
      likedTracks.add(false);
    }
    setTrackData();
    play('spotify:track:3KLHSYHSmny4sJo2finqy9');
    Timer.periodic(const Duration(seconds: 1), (Timer t) => setTrackData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectionStatus>(
      stream: SpotifySdk.subscribeConnectionStatus(),
      builder: (context, snapshot) {
        return Scaffold(
            body: Column(
          children: [
            Divider(height: 128, color: Colors.transparent),
            Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  trackName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: globals.spotifyBlackColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Nunito'),
                )),
            Text(
              authorName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito'),
            ),
            Divider(height: 20, color: Colors.transparent),
            Swiper(
              itemCount: 10,
              itemWidth: 300,
              itemHeight: 350,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: SuperellipseShape(
                      borderRadius: BorderRadius.circular(64),
                    ),
                    elevation: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(trackImageUrl)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 120, bottom: 16),
                        child: IntrinsicWidth(
                          child: Row(children: [
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: RawMaterialButton(
                                  elevation: 0,
                                  onPressed: () {
                                    setState(() {
                                      Share.share(trackLink);
                                    });
                                  },
                                  fillColor: globals.spotifyGreenColor,
                                  shape: CircleBorder(),
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  padding: EdgeInsets.all(12),
                                )),
                            Container(
                                padding: EdgeInsets.only(left: 116),
                                alignment: Alignment.bottomRight,
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
                                ))
                          ]),
                        ),
                      ),
                    ),
                  ),
                );
              },
              layout: SwiperLayout.STACK,
              viewportFraction: 2,
              scale: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Slider(
                value: progress / 1000,
                min: 0,
                max: duration / 1000,
                onChanged: (value) {
                  SpotifySdk.seekTo(
                      positionedMilliseconds: (value * 1000).toInt());
                  setState(() {
                    progress = (value * 1000).toInt();
                  });
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
                    "${Duration(milliseconds: progress).inMinutes}:" +
                        "${(Duration(milliseconds: progress).inSeconds % 60).toString().padLeft(2, '0')}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: globals.spotifyBlackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito'),
                  ),
                ),
                Text(
                  "${Duration(milliseconds: duration).inMinutes}:" +
                      "${(Duration(milliseconds: duration).inSeconds % 60).toString().padLeft(2, '0')}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: globals.spotifyBlackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito'),
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                icon: Icon(Icons.shuffle),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  setState(() {
                    skipPrevious();
                    isPlaying = true;
                  });
                },
              ),
              RawMaterialButton(
                elevation: 8,
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                    if (isPlaying) {
                      resume();
                    } else {
                      pause();
                    }
                  });
                },
                fillColor: globals.spotifyGreenColor,
                shape: CircleBorder(),
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
                padding: EdgeInsets.all(16),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  setState(() {
                    skipNext();
                    isPlaying = true;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.repeat),
                onPressed: () {},
              ),
            ]),
          ],
        ));
      },
    );
  }

  Future<void> setTrackData() async {
    var trackData = await SpotifyConnectionWorker.getCurrentlyPLayingTrack();
    setState(() {
      progress = trackData.progress;
      duration = trackData.duration;
      isPlaying = trackData.isPlaying;
      trackName = trackData.trackName;
      trackImageUrl = trackData.imageUrl;
      trackLink = trackData.link;
      authorName = trackData.artistName;
    });
  }

  Future<void> play(String spotifyUri) async {
    try {
      await SpotifySdk.play(spotifyUri: spotifyUri);
    } on PlatformException catch (e) {
      print(e.message);
    } on MissingPluginException {
      print('not implemented');
    }
  }

  Future<void> resume() async {
    await SpotifySdk.resume();
  }

  Future<void> pause() async {
    await SpotifySdk.pause();
  }

  Future<void> skipNext() async {
    await SpotifySdk.skipNext();
    setTrackData();
  }

  Future<void> skipPrevious() async {
    await SpotifySdk.skipPrevious();
    setTrackData();
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
