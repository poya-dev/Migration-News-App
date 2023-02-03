import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../utils/constant.dart';

class BadgeBloc {
  int _newsBadgeCount = 0;

  int _consultingBadgeCount = 0;

  final StreamController<int> _newsStreamController =
      StreamController<int>.broadcast();

  final StreamController<int> _consultingStreamController =
      StreamController<int>.broadcast();

  Stream<int> get newsBadge => _newsStreamController.stream;

  Stream<int> get consultingBadge => _consultingStreamController.stream;

  void get resetNewsBadgeCount =>
      _newsStreamController.sink.add(_newsBadgeCount = 0);

  void get resetConsultingBadgeCount =>
      _consultingStreamController.sink.add(_consultingBadgeCount = 0);

  late IO.Socket _socket;

  BadgeBloc() {
    final Map<String, dynamic> socketConfig = <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    };
    _socket = IO.io(ApiEndpoints.root, socketConfig);

    _socket.connect();

    _socket.on('newPost', (data) {
      _newsStreamController.sink.add(++_newsBadgeCount);
    });

    _socket.on('consultingMessage', (data) {
      _consultingStreamController.sink.add(++_consultingBadgeCount);
    });
  }

  void dispose() {
    _newsStreamController.close();
    _consultingStreamController.close();
    _socket.disconnect();
  }
}
