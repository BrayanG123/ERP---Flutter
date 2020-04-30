
import 'dart:convert';

import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

import 'package:formvalidation/src/models/categoria_model.dart';

class CategoriaProviders {
  final String _url = 'http://erp-si2.herokuapp.com';
  final _prefs = PreferenciasUsuario();


  Future<List<CategoriaModel>> cargarCategoria() async{

    final url = '$_url/categoria/1_all_categ';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode( resp.body );
    final List<CategoriaModel> categorias = new List();

    if ( decodedData == null ) return [];

    Map<String, dynamic> listaDatos = {
      'datos' : decodedData['datos']
    };
    //print(listaDatos);
    int c = 0;
    decodedData.forEach( (id, almacen) {
      if ( c > 0){
        final cateTemp = CategoriaModel.fromJson(listaDatos);
        categorias.add(cateTemp);
      }
      c = c + 1;
    });
    //print(categorias);
    print('Se ha retornado la lista de categorias desde CategoriaProviders');
    return categorias;

  }

  Future<bool> crearCategoria ( Dato categoria ) async{
    final url = '$_url/categoria/registrar';

    Map<String, String> header = {
      'Content-Type'  : 'application/json',
      'Authorization' : '${ _prefs.token }'
    }; 
    final resp = await http.post( url, headers: header, body: json.encode( categoria ) );
    print(resp.body);
    //final decodedData = json.decode( resp.body );
    //print(decodedData);

    return true;
  }
  

}