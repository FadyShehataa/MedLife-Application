import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../constants.dart';

class SocketConnection {
  SocketConnection._();

  static final SocketConnection _obj = SocketConnection._();

  static SocketConnection getObj() {
    return _obj;
  }

  IO.Socket getSocket() {
    return socket;
  }

  late IO.Socket socket;


  Future<void> initSocket() async {
    String senderId = '';

    if(appMode?.userType == 'patient') {
      senderId = mainPatient!.id!;
    } else if (appMode?.userType == 'pharmacist') {
      senderId = mainPharmacist!.pharmacyId!;
    }

    // Connect to the socket server
    await dotenv.load(fileName: './assets/.env');
    socket = IO.io(
        dotenv.env['URL'],
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    // Connect to the socket server
    socket.connect();
    socket.emit('join_room', senderId);
  }



  void disconnect() {
    // Disconnect from the socket server
    socket.disconnect();
  }

  Map<String, String> sendMessage(
      String text, String senderId, String receiverId) {
    // Send the message to the server
    var messageJson = {
      "message": text,
      "sentBy": senderId,
      "receiverID": receiverId,
    };

    socket.emit('message', jsonEncode(messageJson));
    return messageJson;
  }
}
