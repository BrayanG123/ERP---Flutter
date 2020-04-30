import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto2_model.dart';
import 'package:image_picker/image_picker.dart';

class NewProductoPage extends StatefulWidget {
  @override
  _NewProductoPageState createState() => _NewProductoPageState();
}

class _NewProductoPageState extends State<NewProductoPage> {

  File foto;
  Dato producto;
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _costoController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    producto = ModalRoute.of(context).settings.arguments;
    _nombreController.text = producto.nombre;
    _costoController.text = producto.costounidad.toString();
    //print(producto.nombre);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gestionar Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_enhance),
            onPressed: _tomarFoto,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _mostrarFoto(),
          Divider(),
          _crearCategoria(),
          Divider(),
          _crearNombre(),
          Divider(),
          _crearCosto(),
          Divider(),
          _nombreImagen(),
          Divider(),
        ],
      ),
      floatingActionButton: _crearBotones(),
    );
  }

  Widget _crearBotones(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(child: SizedBox()),
        FloatingActionButton(heroTag: 'nn', child: Icon(Icons.remove), onPressed: (){} ),
        SizedBox(width: 30.0),
        FloatingActionButton(heroTag: 'edit', child: Icon(Icons.edit), onPressed: (){} ),
      ],
    );
  }

  Widget _crearCategoria(){
    return Row(
      children: <Widget>[
        Expanded(
          child: Text('Categoria: '),
        ),
        Expanded(
          child: Text('Aqui estrara el DropDown'),
        ),
      ],
    );
  }

  Widget _crearNombre(){
    return TextField(
      //autofocus: true,
      controller: _nombreController,
      decoration: InputDecoration(
        counter: Text('Letras: 0'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Nombre del producto',
        labelText: 'Nombre',
        suffixIcon: Icon(Icons.text_format),
        icon: Icon(Icons.shopping_cart),
      ),
      
    );
  }


  Widget _crearCosto(){
    return Row(
      children: <Widget>[
        Text('Costo:'),
        SizedBox( width: 20.0,),
        Expanded(
          child: TextField(
            controller: _costoController,
            decoration: InputDecoration(             
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              hintText: 'Costo por unidad',
              labelText: 'Costo',
              suffixIcon: Icon(Icons.looks_one),
              icon: Icon(Icons.monetization_on),
            ),
          ),
        )
      ],
    );
  }


  Widget _nombreImagen(){
    return Row(
      
    );
  }

  Widget _mostrarFoto(){
    if ( producto.imagen != null /*producto.img != null*/ ){
      return Image(
        image: NetworkImage(producto.imagen[0]),
        height: 250.0,
        fit: BoxFit.contain,
      );
    }else{
      return Image(
        image: AssetImage( foto?.path ?? 'assets/no-image.png'),
        height: 250.0,
        fit: BoxFit.cover,
      );
    }
  }

  _tomarFoto() async{
    _procesarImagen( ImageSource.camera );
  }

  _seleccionarFoto() async{
    _procesarImagen( ImageSource.gallery );
  }

  _procesarImagen( ImageSource tipo ) async{
    foto = await ImagePicker.pickImage(
      source: tipo
    );
    if ( foto != null ){

    }
    setState(() {
      
    }); 
  }
}