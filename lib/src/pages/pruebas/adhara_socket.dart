
//import 'package:adhara_socket_io/adhara_socket_io.dart';
//importar en  yaml el adhara_socket_io


const URI = "http://127.0.0.1"; // Url de tu conexión Socket
 
class SocketProvider {
  static final SocketProvider _instancia = new SocketProvider._internal();
 
  factory SocketProvider() {
    return _instancia;
  }
 
  SocketProvider._internal();
 
  SocketIOManager _manager;
  SocketIO _socket;
 
  initSockets() async {

    _manager = SocketIOManager();

    _socket = await _manager.createInstance(SocketOptions(
      //Socket IO server URI
      URI,
      //Query params - can be used for authentication
      query: {},
      /*query: {
        "token": "###########",
      },*/ // Esto es un ejemplo si quieren usar token
      //Enable or disable platform channel logging
      enableLogging: false,
      transports: [Transports.WEB_SOCKET, Transports.POLLING] //Esto es importante
    ));

    _socket.onConnect((data){
      print("Conectado");
    });
    
    _socket.onDisconnect((data){
      print("Desconectado");
    });

    _socket.connect();

  }
 
  accion(String evento, dynamic datos) async {
    print(evento);
    print(datos);
    print(_socket);
    if (_socket != null) {
      _socket.emit(evento, [datos]);
    }
  }
 
  escuchar(String evento) async {
    print(evento);
    print(_socket);
    if (_socket != null) {
      return _socket.on(evento, (data){   //sample event
        print("Evento $evento");
        print(data);
      });
    }
  }
}