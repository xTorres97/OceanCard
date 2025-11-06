import 'dart:io';
import 'package:flutter/foundation.dart';

class AppConfig {
  static final bool isWeb = kIsWeb;
  static final bool isAndroid = !kIsWeb && Platform.isAndroid;
}
