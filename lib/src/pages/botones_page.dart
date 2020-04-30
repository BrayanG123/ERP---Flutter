
import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:ui';

import 'package:formvalidation/src/pages/productos2_page.dart';
import 'package:formvalidation/src/pages/subpaginas/almacen_page.dart';
import 'package:formvalidation/src/pages/subpaginas/categoria_page.dart';
import 'package:formvalidation/src/pages/subpaginas/pedidos_page.dart';
import 'package:formvalidation/src/pages/subpaginas/proveedores_page.dart';

class BotonesPage extends StatelessWidget {

  static final String routeName = 'botones';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
                _botonesRedondeados(context),
              ],
            ),
          ),
          
        ],
      ),
      bottomNavigationBar: _buttonNavigationBar(context),
    );
  }

  Widget _fondoApp(){

    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin:  FractionalOffset(0.0, 0.6),
          end:    FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
          ]
        )
      ),
    );
    
    final cajaRosada = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236, 98, 188, 1.0),
              Color.fromRGBO(241, 142, 172, 1.0)
            ]
          ),
        ),
      ),
    );
    
    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -100,
          child: cajaRosada,
        )
      ],
    );

  }


  Widget _titulos(){
    return SafeArea(
        child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Modulos ERP', style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 5.0,),
            Text('Escoja el modulo con el que desea trabajar', style: TextStyle(color: Colors.white, fontSize: 15.0))
          ],
        ),
      ),
    );
  }


  Widget _buttonNavigationBar(BuildContext context){
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.blue,
        textTheme: Theme.of(context).textTheme
              .copyWith( caption: TextStyle( color: Color.fromRGBO(116, 117, 152, 1.0) ))
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 30.0,),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outlined, size: 30.0),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle, size: 30.0),
            title: Container()
          )
        ],
      ),
    );
  }


  Widget _botonesRedondeados(BuildContext context){
    return Table(
      children: [
        TableRow(
          children: [
            _crearBotonRedondeado(context, Colors.blue, Icons.airport_shuttle, 
            'Pedidos',PedidosPage() ),

            _crearBotonRedondeado(context, Colors.green, Icons.business, 
            'Proveedores', ProveedoresPage() )
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado( context, Colors.deepPurple, Icons.add_shopping_cart,
            'Productos', Producto2Page()),

            _crearBotonRedondeado(context, Colors.blue, Icons.local_convenience_store, 
            'Almacenes', AlmacenPage() )
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado( context, Colors.deepPurple, Icons.add_box,
            'Categoria', CategoriaPage() ),

            _crearBotonRedondeado(context, Colors.blue, Icons.hourglass_empty, 
            'Comming Soon', BotonesPage() )
          ]
        ),
      ],
    );
  }


  Widget _crearBotonRedondeado( BuildContext context,Color color, IconData icono, String texto, url ){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 180.0,
            //margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(62, 66, 107, 0.7),
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox( height: 5.0, ),           
                FloatingActionButton(
                  heroTag: 'btn${texto}',
                  backgroundColor: color,
                  child: Icon(icono),
                  onPressed: () => Navigator.of(context).
                                  push( MaterialPageRoute(builder: (BuildContext context) {
                                      return url;
                                    })
                                  )
                ),
                Text( texto, style: TextStyle( color: color, fontSize: 25.0 ),  )
              ],
            ),
          ),
        ),
      ),
    );
  }

}



