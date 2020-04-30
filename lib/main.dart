import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/botones_page.dart';

import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/producto_page.dart';
import 'package:formvalidation/src/pages/productos2_page.dart';
import 'package:formvalidation/src/pages/pruebas/notificaciones.dart';
import 'package:formvalidation/src/pages/subpaginas/almacen_page.dart';
import 'package:formvalidation/src/pages/subpaginas/categoria_page.dart';
import 'package:formvalidation/src/pages/subpaginas/new_pedido_page.dart';
import 'package:formvalidation/src/pages/subpaginas/new_producto_page.dart';
import 'package:formvalidation/src/pages/subpaginas/pedidos_page.dart';
import 'package:formvalidation/src/pages/subpaginas/proveedores_page.dart';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
 
void main() async{

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
  
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //final prefs = PreferenciasUsuario();
    //print(prefs.token);
    
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login'     : ( BuildContext context ) => LoginPage(),
          'home'      : ( BuildContext context ) => HomePage(),
          'producto'  : ( BuildContext context ) => ProductoPage(),
          'botones'   : ( BuildContext context ) => BotonesPage(),
          'proveedor' : ( BuildContext context ) => ProveedoresPage(),
          'pedido'    : ( BuildContext context ) => PedidosPage(),
          'categoria' : ( BuildContext context ) => CategoriaPage(),
          'almacen'   : ( BuildContext context ) => AlmacenPage(),
          'newpedido' : ( BuildContext context ) => PedidoEditPage(),
          'newproducto' : ( BuildContext context ) => NewProductoPage(),
          'producto2'   : ( BuildContext context ) => Producto2Page(),
          'prueba'      : ( BuildContext context ) => PruebaSocket(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
      
  }
}