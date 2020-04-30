
import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/almacen_model.dart';
import 'package:formvalidation/src/providers/almacen_providers.dart';

class AlmacenPage extends StatelessWidget {

  //final pedidoprov = new PedidoProviders();
  final almaprovider = new AlmacenProviders(); 

  @override
  Widget build(BuildContext context) {

    //final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Almacenes')
      ),
      body: _crearListado( ),
      //floatingActionButton: _crearProducto(  ),
    );
  }

   Widget _crearListado(){
    return FutureBuilder(
      future: almaprovider.cargarAlmacen(),
      builder: (BuildContext context, AsyncSnapshot<List<AlmacenModel>> snapshot){
        if ( snapshot.hasData ){
          final almacenes = snapshot.data;
          return ListView.builder(
            itemCount: almacenes[0].datos.length, //los n elementos
            itemBuilder: (context, i) => _crearItem(context, almacenes[0].datos[i]),//un objeto en especifico
          );
        }else{
          return Center( child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _crearItem( BuildContext context, Dato almacen ){
    
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direction ){
        almaprovider.borrarAlmacen( almacen.idAlmacen.toString() );
      },
      child: Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: 
          Column(
        children: <Widget>[
          Container(
            height: 100.0,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 60,
                  minHeight: 80,
                  maxWidth: 60,
                  maxHeight: 80,
                ),
                child: Icon(Icons.local_convenience_store)//Image.network(pedido.foto[1], fit: BoxFit.cover),
              ),
              title: Text('${ almacen.nombre }', 
                          style: TextStyle( fontWeight: FontWeight.bold,
                          color: Colors.deepPurple
                          )
              ),
              subtitle: Text('Latitud: ${ almacen.ubicacion.latitud } \nLongitud: ${almacen.ubicacion.longitud}'),       
            ),
          ),
         
        ],
      ),
      )
      
    );
  }

  _crearProducto(  ) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => (){} //_pruebaPost() //Navigator.pushNamed(context, 'producto'),
    );
  }

  _pruebaPost(){
    /*Dato almacen = new Dato( 
      nombre:"pruebaFlutter", 
      id_producto: 1, 
      fecha_ped: DateTime.now(),
      fecha_entr: DateTime.now(),
      cant:5, 
      prec_uni: 55      
    );*/
    
    //almaprovider.crearPedido(almacen);
    
  }
}