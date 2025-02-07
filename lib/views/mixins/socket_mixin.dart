import 'package:flutter/material.dart';
import 'package:duowa/server/api/constants.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

mixin SocketIoMixin<T extends StatefulWidget> {
  late IO.Socket socket;

  void sayGoodBye() {
    if (socket.active) {
      socket.close();
    }
  }

  void startSocketConnection(
      String ticketId,
      Function(dynamic) messageHandler,
      Function onDisconnect,
      Function(dynamic) onError,
      Function(dynamic) onReconnect) {
    socket = IO.io(AppConstants.kWsUrl, <String, dynamic>{
      'transports': ['websocket'], // Important: Specify websocket transport
      'autoConnect': true,
    });

    socket.onConnect((_) {
      socket.emit(
          'verify_client', {'client_id': ticketId}); // Send initial message
    });

    socket.on('connection_verified', (data) {
      // var currentClientId = data.client_id;
    });

    socket.on('connection_error', (data) => {socket.disconnect()});

    socket.on('streaming_received', (data) {
      var message = data['message'];
      messageHandler(message);
    });

    socket.onDisconnect((_) {
      onDisconnect();
    });

    socket.on('error', (error) => onError(error));
    socket.onReconnect(onReconnect);
  }
}
