import 'package:flutter/services.dart';

class TiktokLogin {
  static const MethodChannel _channel = MethodChannel('tiktok_login_flutter');

  static Future<bool> initializeTiktokLogin(String clientKey) async {
    return await _channel.invokeMethod('initializeTiktokLogin', clientKey);
  }

  static Future<String> authorize(String scope) async {
    return await _channel.invokeMethod('authorize', {"scope": scope});
  }
}
