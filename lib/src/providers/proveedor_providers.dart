
import 'dart:convert';

import 'package:formvalidation/src/models/proveedor_model.dart';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class ProveedorProviders {
  final String _url = 'http://erp-si2.herokuapp.com'; 
  final _prefs = PreferenciasUsuario();


  Future<bool> crearProveedor ( ProveedorModel proveedor ) async{
    final url = '$_url/provedor/registrar';

    Map<String, String> header = {
      'Content-Type'  : 'multipart/form-data',
      'Authorization' : '${ _prefs.token }'
    };

    final resp = await http.post( url, headers: header, body: proveedorModelToJson( proveedor ) );

    final decodedData = json.decode( resp.body );

    print(decodedData);

    return true;
  }

  Future<List<ProveedorModel>> cargarProveedores( ) async{
    final url  = '$_url/provedor/1_all_prov';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode( resp.body );
    final List<ProveedorModel> proveedores = new List();

    if ( decodedData == null ) { return []; }

    
    //print(decodedData['datos']);

    Map<String, dynamic> prueba = {
      "datos" : decodedData['datos']
    };
    //print(prueba);
    int c = 0;
    
    decodedData.forEach( ( id, provs ){
      if (c > 0){ 
        final provtemp = ProveedorModel.fromJson(prueba);  //Producto2Model.fromJson(prod);
        proveedores.add(provtemp);
        //print(prodtemp);
        
      }
      c=c+1;
    });
    //para llegar a la lista de 1 elemento <List<Producto2Model>> : proveedores
    //para llegar al arreglo de objetos ProveedorModel : proveedor[0]
    //para llegar a un objeto : proveedor[0].datos[1]
    //para llegar a un atributo en especifico: productos[0].datos[1].nombre
    //solo el productos[0] esta permitido, el [1] esta fuera del limite
    print(proveedores[0]); 
    print(proveedores[0].datos[0].nombre); //nombre del proveedor
    print(proveedores[0].datos.length); //los elementos (proveedores)
    print(proveedores[0].datos[0]); //instancia de dato (proveedor)
    //print(productos.length);
    return proveedores;
  }

  Future<int> borrarProveedor( String id ) async{
    final url = '$_url/provedor/eliminar/$id';

    Map<String, String> header = {
      'Authorization' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZF91c3VhcmlvIjoiMSIsInVzdWFyIjoibWFhY2MiLCJmb3RvIjoiXCJodHRwczovL3Jlcy5jbG91ZGluYXJ5LmNvbS9kZXZkcmVhbXMvaW1hZ2UvdXBsb2FkL3YxNTYzMjUzNTU1L2NvbGVnaW8vdXN1YXJpby9kZWZhdWx0L2hvbWJyZV9nbjZ0MW4ucG5nXCIiLCJlbWFpbCI6Im1pZ3VlbGFjYXlvQGdtYWlsLmNvbSIsImlhdCI6MTU2OTg2NjAwNywiZXhwIjoxNTY5OTUyNDA3fQ.ulq3TLpFveDmOji8sScGaYWzmJ-_NqRhO8NcavrqL6c'
    };

    final resp = await http.delete( url, headers: header );

    final decodedData = json.decode( resp.body );

    print(decodedData);

    return 1;
  }

  List<Map<int,dynamic>> listarImg(){

    List<Map<int,dynamic>> lista = [];

    cargarProveedores().then( (proveedores){
      final length = proveedores[0].datos.length;
      for (int i=0; i<length ; i++) {
        final registro = proveedores[0].datos[i];
        final id = proveedores[0].datos[i].idProvedor;
        dynamic img = proveedores[0].datos[i].foto;
        Map<int,dynamic> aux = {
          id : img[0]
        };
        lista.add( aux );
      }
    }).catchError( (error) => null );

    return lista;   
  }


}