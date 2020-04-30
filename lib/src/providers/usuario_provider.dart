
import 'dart:convert';

import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {

  Future<Map<String, dynamic>> login( String user, String password ) async{

    final url = 'http://erp-si2.herokuapp.com/login/ingresar';

    final _prefs = new PreferenciasUsuario();

    final authData = {
      'user': user,
      'passw': password,
    };

    Map<String, String> header = {
      'Content-Type': 'application/json',
    };

    final resp = await http.post( url, headers: header, body: json.encode(authData));
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if ( decodedResp['ok'] ){
      Map<String, dynamic> aux = decodedResp['datos'];
      _prefs.token = decodedResp['token'];
      
      return { 'ok': true  };
    }else{
      //print('fallo: Algo esta fallando en usuario_provider');
      return {'ok': false}; 
    }
  }


}