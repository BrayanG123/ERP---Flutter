import 'dart:convert';

import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/almacen_model.dart';

class AlmacenProviders{
  final String _url = 'http://erp-si2.herokuapp.com';

  Future<List<AlmacenModel>> cargarAlmacen() async{

    final url = '$_url/almacen/1_all_almac';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode( resp.body );
    final List<AlmacenModel> almacenes = new List();

    if ( decodedData == null ) return [];

    Map<String, dynamic> listaDatos = {
      'datos' : decodedData['datos']
    };
    print(listaDatos);
    int c = 0;
    decodedData.forEach( (id, almacen) {
      if ( c > 0){
        final almaTemp = AlmacenModel.fromJson(listaDatos);
        almacenes.add(almaTemp);
      }
      c = c + 1;
    });
    print(almacenes);
    return almacenes;

  }

  Future<int> borrarAlmacen( String id ) async{
    final url = '$_url/almacen/eliminar/$id';
    final _prefs = PreferenciasUsuario();
    Map<String, String> header = {
      'Authorization' : '${ _prefs.token }'
    };
    
    final resp = await http.delete( url, headers: header );
    
    //final decodedData = json.decode( resp.body );
    print('Json decode:');
    print( json.decode( resp.body ) );

    return 1;
  }





}