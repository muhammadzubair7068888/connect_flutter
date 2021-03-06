import 'dart:io';

import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:laravel_echo/laravel_echo.dart';

Map<String, String> requestHeaders(String token) {
  return {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
}

/*Had to use localhost (10.0.3.2 for Genymotion, 10.0.2.2 for official emulator) 
  because websocket port 6001 cannot be setup on expose or ngrok. 
*/
Echo echoSetup(token, pusherClient) {
  return Echo({
    'broadcaster': 'pusher',
    'client': pusherClient,
    "wsHost": '192.168.1.30',
    "httpHost": '192.168.1.30',
    "wsPort": 6001,
    'auth': {
      "headers": {'Authorization': 'Bearer $token'}
    },
    'authEndpoint':
        'http://192.168.1.30/connect_laravel/public/api/broadcasting/auth',
    "disableStats": true,
    "forceTLS": false,
    "enabledTransports": 'ws',
  });
}

FlutterPusher getPusherClient(String token) {
  PusherOptions options = PusherOptions(
      encrypted: false,
      host: '192.168.1.30',
      cluster: 'mt1',
      port: 6001,
      auth: PusherAuth(
          'http://192.168.1.30/connect_laravel/public/api/broadcasting/auth',
          headers: {'Authorization': 'Bearer $token'}));
  return FlutterPusher(
    'connect_123',
    options,
    enableLogging: true,
    lazyConnect: true,
  );
}

void onConnectionStateChange(ConnectionStateChange event) {
  print(event.currentState);
  if (event.currentState == 'CONNECTED') {
    print('connected');
  } else if (event.currentState == 'DISCONNECTED') {
    print('disconnected');
  }
}
