import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketsService {
  static const String _server = 'ws://echo.websocket.org';
  final WebSocketChannel _channel = IOWebSocketChannel.connect(_server);

  WebSocketChannel get channel => _channel;

  Stream getStream() {
    return _channel.stream;
  }

  void sendData(dynamic data) {
    print('Channel: $data');
    _channel.sink.add(data);
  }

  void closeSocket() {
    _channel.sink.close();
  }

}
