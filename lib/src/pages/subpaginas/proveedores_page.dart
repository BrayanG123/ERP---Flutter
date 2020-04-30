import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:formvalidation/src/models/proveedor_model.dart';
import 'package:formvalidation/src/pages/reciclers/fondo_pantalla.dart';
import 'package:formvalidation/src/providers/proveedor_providers.dart';
class ProveedoresPage extends StatelessWidget {

  final proveeprov = new ProveedorProviders();

  @override
  Widget build(BuildContext context) {

    //final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Proveedores')
      ),
      body: Stack(
        children: <Widget>[
          fondoPantalla(),
          _crearListado( ),
        ],
         
      ),
      floatingActionButton: _crearProducto( context ),
    );
  }

   Widget _crearListado(){
    return FutureBuilder(
      future: proveeprov.cargarProveedores(),
      builder: (BuildContext context, AsyncSnapshot<List<ProveedorModel>> snapshot){
        if ( snapshot.hasData ){
          final proveedores = snapshot.data;
          return ListView.builder(
            itemCount: proveedores[0].datos.length, //los n elementos
            itemBuilder: (context, i) => _builTripCard(context, proveedores[0].datos[i]),//un objeto en especifico
          );
        }else{
          return Center( child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _crearItem( BuildContext context, Dato proveedor ){
    String disponible = 'Disponible';
    
    //if (!proveedor.estado){
    //  disponible = 'No Disponible';
    //}
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direction ){
        proveeprov.borrarProveedor( proveedor.idProvedor.toString() );
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,       
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 60,
                  minHeight: 80,
                  maxWidth: 60,
                  maxHeight: 80,
                ),
                child: Image.network(proveedor.foto[0], fit: BoxFit.cover),
              ),
              title: Text('${ proveedor.nombre }'),
              
              subtitle: Text('Correo: ${ proveedor.email } \nEstado: ${disponible}'),
              
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('Mas detalles'), 
                  textColor: Colors.blue,
                  onPressed: (){},
                ),
                
              ],
            )
          ],
        ),
      )
      
    );
  }

  Widget _builTripCard( BuildContext context, Dato proveedor ){
    return Container(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            //color: const Color(0xff7c94b6),
            image:  DecorationImage(
              image: NetworkImage( proveedor.foto[0] ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
              //alignment: Alignment.topCenter
            )
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(        
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row( children: <Widget>[
                    Text('${ proveedor.nombre }', 
                          style: TextStyle(
                            fontSize: 30.0, 
                            fontWeight: FontWeight.bold,  
                            //color: Color(0xff00BCD4).withOpacity(0.5),                       
                          ),
                    ),
                    Spacer(),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                  child: Row( children: <Widget>[
                    Text('${ proveedor.direccion }',
                      style: TextStyle(
                            fontWeight: FontWeight.bold,
                      ) 
                    ),
                    Spacer(),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row( children: <Widget>[
                    Text('${ proveedor.email }', style: TextStyle(fontSize: 25.0)),
                    Spacer(),
                    
                  ],),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

 

  _crearProducto( BuildContext context ) {
      final prueba = {
          'idProvedor' : 22,
          'nombre' : 'prueba',
          'telefono' : ['prueba', 'prueba'],
          'email' : 'prueba.com',
          'direccion' : 'dirprueba',
          'foto' : ['https://storage.googleapis.com/gweb-uniblog-publish-prod/images/android_ambassador_v1_cmyk_200px.max-200x200.png'],
          'estado' : false
      };

    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => {}//proveeprov.crearProveedor(prueba) //Navigator.pushNamed(context, 'producto'),
    );
  }

  /*
   Widget _fondo(){
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
   */

}