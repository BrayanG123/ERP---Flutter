import 'package:flutter/material.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PruebaSocket extends StatefulWidget {

  @override
  _PruebaSocketState createState() => _PruebaSocketState();
}

class _PruebaSocketState extends State<PruebaSocket> {

  WebSocketChannel channel;
  TextEditingController controller;

  @override
    void initState(){
      super.initState();
      channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
      controller = TextEditingController();
    }
    
    void sendData(){
      if ( controller.text.isNotEmpty ){
        channel.sink.add( controller.text );
        controller.text = "";
      }
    }

    @override
    void dispose(){
      channel.sink.close();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(

      appBar: AppBar(
        title: Text('Prueba Socket'),
      ),

      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Envia a la WebSocket',
                ),
              ),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                return Container(
                  child: Text( snapshot.hasData ? '${ snapshot.data }' : '' ),
                );
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () {
          sendData();
        },
      ),

    );
  }

  

}