import 'package:flutter/material.dart';


import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/producto2_model.dart';
import 'package:formvalidation/src/providers/productos2_providers.dart';
import 'package:formvalidation/src/providers/productos_providers.dart';

class HomePage extends StatelessWidget {

  final productosProvider = new ProductosProvider();
  final prodprov = new Productos2Providers();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _crearListado/*_crearListadoGet*/(

      ),
      //floatingActionButton: _crearProducto( context ),
    );
  }

  Widget _crearListado(){
    return FutureBuilder(
      future: prodprov.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<Producto2Model>> snapshot){
        if ( snapshot.hasData ){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos[0].datos.length, //los 17 elementos
            itemBuilder: (context, i) => _crearItem(context, productos[0].datos[i]),//un objeto en especifico
          );
        }else{
          return Center( child: CircularProgressIndicator(),);
        }
      },
    );
  }

  /*Widget _crearListadoGet(){
    return FutureBuilder(
      future: productosProvider.cargarProdcutos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if ( snapshot.hasData ){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: ( context, i ) => _crearItem(context, productos[i]),
          );
        }else{
          return Center( child: CircularProgressIndicator() );
        }
      },
    );
  }*/

  Widget _crearItem( BuildContext context, Dato producto ){
    String disponible = 'Disponible';
    if (!producto.estado){
      disponible = 'No Disponible';
    }
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direction ){
        productosProvider.borrarProducto( producto.idProducto );
      },
      child: Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: 
          Column(
        children: <Widget>[
          ListTile(
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 60,
                minHeight: 80,
                maxWidth: 60,
                maxHeight: 80,
              ),
              child: Image.network('https://latevaruta.com/wp-content/uploads/2019/01/world-100x100@2x.png', fit: BoxFit.cover),
            ),
            title: Text('${ producto.nombre }'),
            
            subtitle: Text('Precio: ${ producto.costounidad } \nEstado: ${disponible}'),
            
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
      /*ListTile(
        title: Text( '${ producto.nombre } - ${ producto.costounidad }' ),
        subtitle: Text( producto.estado.toString() ),
        onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto),
      ),*/
    );
  }

  _crearProducto( BuildContext context ) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }
}