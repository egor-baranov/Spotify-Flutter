import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorageWorker {
  static Future<String> get _localPath async =>
      (await getApplicationDocumentsDirectory()).path;

  static Future<File> get _tokenLocalFile async =>
      File("${await _localPath}/token");

  static Future<bool> doesTokenPathExist() async =>
      (await _tokenLocalFile).exists();

  static Future<String> getToken() async =>
      (await _tokenLocalFile).readAsString();

  static Future<void> updateToken(String token) async =>
      (await _tokenLocalFile).writeAsString(token);
}
