
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterStockfish {
  static const MethodChannel _channel =
      const MethodChannel('flutter_stockfish');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
