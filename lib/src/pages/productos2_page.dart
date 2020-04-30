import 'package:flutter/material.dart';

import 'package:formvalidation/src/models/producto2_model.dart';
import 'package:formvalidation/src/pages/reciclers/fondo_pantalla.dart';
import 'package:formvalidation/src/pages/subpaginas/new_producto_page.dart';
import 'package:formvalidation/src/providers/productos2_providers.dart';

class Producto2Page extends StatelessWidget {

  final prodprov = new Productos2Providers();
  List<Producto2Model> listaCateg = []; 

  @override
  Widget build(BuildContext context) {

    //final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos')
      ),
      body: Stack(
        children: <Widget>[
          fondoPantalla(),
          _crearListado( ),
        ],
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
          //_porCategoria( productos ); //tendra todos los prod ordenados por categoria
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

  Widget _crearItem( BuildContext context, Dato producto ){
    String disponible = 'Disponible';
    //if (!producto.estado){
    //  disponible = 'No Disponible';
    //}
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direction ){
        Navigator.pushNamed(context, 'newproducto', arguments: producto);
        //productosProvider.borrarProducto( producto.idProducto );
      },
      
      child: Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: 
          Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              
              ListTile(
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 60,
                    minHeight: 80,
                    maxWidth: 60,
                    maxHeight: 80,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FadeInImage(
                      image: NetworkImage(producto.imagen[0]),
                      placeholder: AssetImage('assets/jar-loading.gif'),
                    ),
                  )
                  
                ),
                trailing: IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () => {},
                ),
                title: Text('${ producto.nombre }'),          
                subtitle: Text('Precio: ${ producto.costounidad } \nEstado: ${disponible}'),               
              ),

              SizedBox(height: 20.0,)
          ],
      ),
      )
      
    );
  }

  _crearProducto( BuildContext context ) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.of(context).
                                  push( MaterialPageRoute(builder: (BuildContext context) {
                                      return NewProductoPage() ;
                                    })
                                  ),
    );
  }

  _porCategoria( List<Producto2Model> producto ){

  }
}