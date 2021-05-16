import 'dart:ui';

import 'package:flutter/material.dart';

const client_id = "9d2635f02f6f4975bfb722d594cbaa27";
const redirect_uri = "spotifyflutter:/";

Map<int, Color> spotifyGreenColorMap = {
  50: Color.fromRGBO(30, 215, 96, .1),
  100: Color.fromRGBO(30, 215, 96, .2),
  200: Color.fromRGBO(30, 215, 96, .3),
  300: Color.fromRGBO(30, 215, 96, .4),
  400: Color.fromRGBO(30, 215, 96, .5),
  500: Color.fromRGBO(30, 215, 96, .6),
  600: Color.fromRGBO(30, 215, 96, .7),
  700: Color.fromRGBO(30, 215, 96, .8),
  800: Color.fromRGBO(30, 215, 96, .9),
  900: Color.fromRGBO(30, 215, 96, 1),
};

MaterialColor spotifyGreenColor =
    MaterialColor(0xFF1DB954, spotifyGreenColorMap);

Map<int, Color> spotifyBlackColorMap = {
  50: Color.fromRGBO(25, 20, 20, .1),
  100: Color.fromRGBO(25, 20, 20, .2),
  200: Color.fromRGBO(25, 20, 20, .3),
  300: Color.fromRGBO(25, 20, 20, .4),
  400: Color.fromRGBO(25, 20, 20, .5),
  500: Color.fromRGBO(25, 20, 20, .6),
  600: Color.fromRGBO(25, 20, 20, .7),
  700: Color.fromRGBO(25, 20, 20, .8),
  800: Color.fromRGBO(25, 20, 20, .9),
  900: Color.fromRGBO(25, 20, 20, 1),
};

MaterialColor spotifyBlackColor =
    MaterialColor(0xFF191414, spotifyBlackColorMap);
