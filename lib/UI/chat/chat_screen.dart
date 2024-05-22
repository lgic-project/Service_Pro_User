import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_pro_user/Provider/user_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;

  @override
  void initState() {
    final token = Provider.of<UserProvider>(context, listen: false).token;
    super.initState();
    socket = IO
        .io('http://20.52.185.247:8000/message?token=$token', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.on('conncet', (_) {
      print('connected');
    });
    socket.on('message', (data) {
      print('Received message; $data');
    });
    socket.connect();
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Center(
        child: Text('Chat Screen'),
      ),
    );
  }
}
