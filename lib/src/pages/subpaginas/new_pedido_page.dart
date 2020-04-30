import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/pedido_model.dart';

import 'package:formvalidation/src/providers/pedido_providers.dart';


class PedidoEditPage extends StatefulWidget {
  @override
  _PedidoEditPageState createState() => _PedidoEditPageState();
}

class _PedidoEditPageState extends State<PedidoEditPage> {

  final _pedidoProvider = new PedidoProviders();
  Dato _pedido = new Dato();

  String _defecto = 'resistencia';
  String _fecha = '';

  TextEditingController _cantController = new TextEditingController();
  TextEditingController _fechaPedController = new TextEditingController();
  TextEditingController _fechaEntregaController = new TextEditingController();

  List<String> _poderes = ['fuerza', 'resistencia', 'velocidad', 'invisibilidad'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion Pedido'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          Text('ID: '),
          Text('Se recomienda seleecionar primero el Proveedor'),
          _campoProveedor(),
          Divider(),
          _campoProducto(),
          Divider(),
          _campoCantidad(),
          Divider(),
          _campoFechaPedido( context ),
          Divider(),
          //SizedBox( height: 20.0, ),
          _campoFechaEntrega( context ),
          Divider(),
        ],
      ),
      floatingActionButton: _crearBotones(),
    );
  }

  List<DropdownMenuItem<String>> elementos() {
    List<DropdownMenuItem<String>> lista = new List();
    _poderes.forEach( (poder){
      lista.add( DropdownMenuItem(
        child: Text( poder ),
        value: poder,
      ) );
    } );

    return lista;
  }

  Widget _campoProducto(){
    return Row(
      children: <Widget>[
       Expanded(
         child:  Text('Producto: '),
       ),
       Expanded(
         child:  DropdownButton(
           value: _defecto,
           items: elementos(),
           onChanged: ( seleccionado ){
             setState(() {
               _defecto = seleccionado;
             });
           },
         ),
       ),     
      ],
    );
  }

  Widget _campoProveedor(){
    return Row(
      children: <Widget>[
       Expanded(
         child:  Text('Proveedor: '),
       ),
       Expanded(
         child:  DropdownButton(
           value: _defecto,
           items: elementos(),
           onChanged: ( seleccionado ){
             setState(() {
               _defecto = seleccionado;
             });
           },
       ), 
       ),    
      ],
    );
  }

  Widget _campoCantidad(){
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              hintText: 'Introduzca la cantidad',
              labelText: 'Cantidad',
              suffixIcon: Icon(Icons.add_circle_outline),
              icon: Icon(Icons.plus_one),
            ),
            keyboardType: TextInputType.number,
            onTap: (){            
              _selectDay( context, 'pedido' );
            },
          ),
        ),
      ],
    );
  }


  Widget _campoFechaPedido( BuildContext context ){
    return TextField(
      enableInteractiveSelection: false,
      controller: _fechaPedController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Fecha Pedido',
        labelText: 'Fecha Pedido',
        suffixIcon: Icon(Icons.calendar_view_day),
        icon: Icon(Icons.calendar_today),
      ),
      onTap: (){
        FocusScope.of(context).requestFocus( new FocusNode() );
        _selectDay( context, 'pedido' );
      },
    );
  }

   _selectDay( BuildContext context, String tipo ) async{
     DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2021),
     );

    if ( picked != null ){
      setState(() {
        _fecha = picked.toIso8601String();
        if ( tipo.contains('pedido') ){
          _fechaPedController.text = _fecha.substring(0, 10);
        }else{
          _fechaEntregaController.text = _fecha.substring(0, 10);
        }       
      });
    }

   }

  Widget _campoFechaEntrega( BuildContext context ){
    return TextField(
      enableInteractiveSelection: false,
      controller: _fechaEntregaController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Fecha Entrega',
        labelText: 'Fecha Entrega',
        suffixIcon: Icon(Icons.calendar_view_day),
        icon: Icon(Icons.calendar_today),
      ),
      onTap: (){
        FocusScope.of(context).requestFocus( new FocusNode() );
        _selectDay( context, 'entrega' );
      },
    );
  }

  Widget _crearBotones(){
    //Dato pedido = new Dato();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 30.0),
        FloatingActionButton(
          heroTag: '2', child: Icon(Icons.delete), onPressed: (){} ,
        ),
        Expanded(child: SizedBox()),
        FloatingActionButton(
          heroTag: '3', child: Icon(Icons.done), onPressed: (){
            _pedidoProvider.crearPedido( _pedido );
          } ,
        ),
        SizedBox(width: 30.0),
        FloatingActionButton(
          heroTag: '4', child: Icon(Icons.edit), onPressed: (){} ,
        ),
      ],
    );
  }
}