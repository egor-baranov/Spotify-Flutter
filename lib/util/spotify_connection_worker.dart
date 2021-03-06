import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:spotify_flutter/globals.dart' as globals;
import 'package:spotify_flutter/model/track.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'local_storage_worker.dart';

class SpotifyConnectionWorker {
  static Future<void> performAuthorizedConnection() async {
    if (await LocalStorageWorker.doesTokenPathExist()) {
      connectToSpotifyRemote();
    } else {
      LocalStorageWorker.updateToken(await getAuthenticationToken());
    }
    print("token is ${await LocalStorageWorker.getToken()}");
  }

  static Future<String> getAuthenticationToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAuthenticationToken(
        clientId: globals.client_id.toString(),
        redirectUrl: globals.redirect_uri.toString(),
        scope: 'app-remote-control, '
            'user-library-read, '
            'user-read-private, '
            'user-read-recently-played, '
            'user-modify-playback-state, '
            'playlist-read-private, '
            'user-library-modify, '
            'playlist-modify-public,user-read-currently-playing',
      );
      LocalStorageWorker.updateToken(authenticationToken);
      connectToSpotifyRemote();
      return authenticationToken;
    } on PlatformException catch (e) {
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      print('Error occurred: type=MissingPluginException');
      return Future.error('Error occurred: type=MissingPluginException');
    }
  }

  static Future<void> connectToSpotifyRemote() async {
    var result = await SpotifySdk.connectToSpotifyRemote(
      clientId: globals.client_id,
      redirectUrl: globals.redirect_uri,
    );
  }

  static Future<List<Track>> getRecentlyPlayedTracks() async {
    var response = await http.get(
      Uri.https('api.spotify.com', 'v1/me/player/recently-played',
          {'scope': 'playlist-modify-public,user-read-currently-playing'}),
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${await LocalStorageWorker.getToken()}',
      },
    );
    return [];
    // log("recently played tracks: ${response.body}");
  }

  static Future<Track> getCurrentlyPlayingTrack() async {
    var response = await http.get(
      Uri.https(
        'api.spotify.com',
        'v1/me/player/currently-playing',
        {'market': 'ES'},
      ),
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${await LocalStorageWorker.getToken()}',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
    );

    var map = json.decode(response.body) as Map<String, dynamic>;
    return Track(TrackBuilder()
      ..setArtistName(map['item']['album']['artists'][0]['name'])
      ..setDuration(map['item']['duration_ms'])
      ..setId(map['item']['id'])
      ..setImageUrl(map['item']['album']['images'][0]['url'])
      ..setProgress(map['progress_ms'])
      ..setTrackName(map['item']['name'])
      ..setIsPlaying(map['is_playing'])
      ..setLink(map['item']['external_urls']['spotify']));
  }

  static Future<List<Track>> getSavedTracks() async {
    var response = await http.post(
      Uri.https(
        'api.spotify.com',
        'v1/me/tracks',
        {'market': 'ES'},
      ),
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${await LocalStorageWorker.getToken()}',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
    );

    return [];
  }
}
