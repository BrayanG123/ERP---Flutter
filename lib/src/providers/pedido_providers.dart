import 'dart:convert';

import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/pedido_model.dart';

class PedidoProviders {

  final String _url = 'http://erp-si2.herokuapp.com';
  final _prefs = PreferenciasUsuario();

  Future<List<PedidoModel>> cargarPedidos() async{
    final url = '$_url/pedido/1_all_pedido';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode( resp.body );
    final List<PedidoModel> pedidos = new List();

    if ( decodedData == null ) return [];

    Map<String, dynamic> listaDatos = {
      'datos' : decodedData['datos']
    };
    //print(listaDatos);
    int c = 0;
    decodedData.forEach( (id, pedido) {
      if ( c > 0){
        final prodTemp = PedidoModel.fromJson(listaDatos);
        pedidos.add(prodTemp);
      }
      c = c + 1;
    });
    //print(pedidos);
    return pedidos;
    //return pedidos;
  } 

  Future<bool> crearPedido( Dato pedido ) async{

    final url = '$_url/pedido/registrar';

    Map<String, String> header = {
      'Content-Type'  : 'application/json',
      'Authorization' : '${ _prefs.token }'
    };

    final resp = await http.post( url, headers: header, body: json.encode( pedido ) );

    //print(resp.body);

    return true;
  }

  Future<int> borrarPedido(String id) async{
    final url = '$_url/pedido/eliminar/$id';
    print('El id');
    print(id);
    Map<String, String> header = {
      'Authorization' : '${ this._prefs.token }'
    };
    
    final resp = await http.delete( url, headers: header );
    
    //final decodedData = json.decode( resp.body );
    print('Json decode:');
    print( json.decode( resp.body ) );

    return 1;
  }

}