import 'package:flutter/cupertino.dart';

class Track {
  String id;
  String artistName;
  String trackName;
  int duration;
  int progress;
  String imageUrl;

  Track(TrackBuilder builder) {
    this.id = builder.id;
    this.artistName = builder.artistName;
    this.trackName = builder.trackName;
    this.duration = builder.duration;
    this.progress = builder.progress;
    this.imageUrl = builder.imageUrl;
  }
}

class TrackBuilder {
  @protected
  String id;
  @protected
  String artistName;
  @protected
  String trackName;
  @protected
  int duration;
  @protected
  int progress;
  @protected
  String imageUrl;

  TrackBuilder setId(String id) {
    this.id = id;
    return this;
  }

  TrackBuilder setArtistName(String artistName) {
    this.artistName = artistName;
    return this;
  }

  TrackBuilder setTrackName(String trackName) {
    this.trackName = trackName;
    return this;
  }

  TrackBuilder setDuration(int duration) {
    this.duration = duration;
    return this;
  }

  TrackBuilder setProgress(int progress) {
    this.progress = progress;
    return this;
  }

  TrackBuilder setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
    return this;
  }
}
