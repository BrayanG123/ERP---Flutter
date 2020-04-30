
import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/pedido_model.dart';

import 'package:formvalidation/src/providers/pedido_providers.dart';
class PedidosPage extends StatelessWidget {

  final pedidoprov = new PedidoProviders();

  @override
  Widget build(BuildContext context) {

    //final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos')
      ),
      body: _crearListado( ),
      floatingActionButton: _crearPedido( context ),
    );
  }

   Widget _crearListado(){
    return FutureBuilder(
      future: pedidoprov.cargarPedidos(),
      builder: (BuildContext context, AsyncSnapshot<List<PedidoModel>> snapshot){
        if ( snapshot.hasData ){
          final pedidos = snapshot.data;
          return ListView.builder(
            itemCount: pedidos[0].datos.length, //los n elementos
            itemBuilder: (context, i) => _crearItem(context, pedidos[0].datos[i]),//un objeto en especifico
          );
        }else{
          return Center( child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _crearItem( BuildContext context, Dato pedido ){
    String disponible = 'Disponible';
    
    //if (!pedido.estado){
    //  disponible = 'No Disponible';
    //}
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direction ){
        pedidoprov.borrarPedido( pedido.idPedido.toString() );
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
              child: Icon(Icons.account_balance)//Image.network(pedido.foto[1], fit: BoxFit.cover),
            ),
            title: Text('${ pedido.nombre }'),
            
            subtitle: Text('FechaPeido: ${ pedido.fecha_ped } \nFechaEntrega: ${pedido.fecha_entr}'),
            
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

  _crearPedido( context ) {
    return FloatingActionButton(
      heroTag: '1',
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () =>  Navigator.pushNamed(context, 'newpedido'), //_pruebaPost()
    );
  }

  _pruebaPost(){
    Dato pedido = new Dato( 
      nombre:"pruebaFlutter", 
      id_producto: 1, 
      fecha_ped: DateTime.now(),
      fecha_entr: DateTime.now(),
      cant:5, 
      prec_uni: 55      
    );

    /*print('==== Pedido Page ====');
    print(pedido.idPedido);
    print(pedido.nombre);
    print(pedido.cant);
   
    print('==== Pedido Page ====');
    print(pedido);
    print('==== Pedido Page ====');
    */
    pedidoprov.crearPedido(pedido);
    
  }
}