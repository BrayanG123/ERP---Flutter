
import 'dart:convert';

import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/producto2_model.dart';

class Productos2Providers {

  final String _url = 'http://erp-si2.herokuapp.com'; 
  final _prefs = PreferenciasUsuario();


  Future<List<Producto2Model>> cargarProductos( ) async{
    final url  = '$_url/producto/1_all_prod';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode( resp.body );
    final List<Producto2Model> productos = new List();

    if ( decodedData == null ) { return []; }

    Map<String, dynamic> prueba = {
      "datos" : decodedData['datos']
    };

    int c = 0;
    
    decodedData.forEach( ( id, prod ){
      if (c > 0){ 
        final prodtemp = Producto2Model.fromJson(prueba);  
        productos.add(prodtemp);        
      }
      c=c+1;
    });
    //para llegar a la lista de 1 elemento <List<Producto2Model>> : productos
    //para llegar al arreglo de objetos Producto2Model : productos[0]
    //para llegar a un objeto : productos[0].datos[1]
    //para llegar a un atributo en especifico: productos[0].datos[1].nombre
    //solo el productos[0] esta permitido, el [1] esta fuera del limite
    print(productos[0].datos[1].nombre); //nombre del productos
    print(productos[0].datos.length); //los 17 elementos (productos)
    print(productos[0].datos[1]); //instancia de dato
    //print(productos.length);
    return productos;
  }
}