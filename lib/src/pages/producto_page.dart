
import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_providers.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey           = GlobalKey<FormState>();
  final scaffoldKey       = GlobalKey<ScaffoldState>();
  final productoProvider = new ProductosProvider();

  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {

    final ProductoModel productoArg = ModalRoute.of(context).settings.arguments;
    if ( productoArg != null ){
      producto = productoArg;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Prodctos page'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.photo_size_select_actual ),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon( Icons.camera_alt ),
            onPressed: _tomarFoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearBoton(),
                _crearDisponible(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: ( value ) => producto.titulo = value,
      validator: ( value ) {
        if ( value.length < 3 ) {
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: ( value ) => producto.valor = double.parse( value ),
      validator: (value) {
        if ( utils.isNumeric( value )) {
          return null;
        }else{
          return 'Solo caracteres numericos';
        }
      },
    );
  }

  Widget _crearBoton(){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: ( _guardando )? null : _submit,
    );
  }

  Widget _crearDisponible(){
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: ( value ) => setState( (){
        producto.disponible = value;
      } ),
    );
  }

  void _submit() async{

    if ( !formKey.currentState.validate() ) { return; }

    formKey.currentState.save();

    setState(() { _guardando = true; });

    if ( foto != null ){
      producto.foto = await productoProvider.subirImagen(foto);
    }

    if ( producto.id == null ){
      productoProvider.crearProducto( producto );
    }else{
      productoProvider.editarProdcuto(producto);
    }
    mostrarSnackBar('Registos Guardados');
    //setState(() { _guardando = false; });
    Navigator.pop(context);
  }

  void mostrarSnackBar(String mensaje){
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration( milliseconds: 1500 ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto(){
    if (producto.foto != null){
      //proceso pendiente
      return Container();
    }else{
      return Image(
        image: AssetImage( foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _seleccionarFoto() async{
    _procesarImagen( ImageSource.gallery );
  }

  _tomarFoto()  async{
    _procesarImagen( ImageSource.camera ); 
  }

  _procesarImagen( ImageSource tipo ) async{

    foto = await ImagePicker.pickImage(
      source: tipo,
    );
    if ( foto != null){

    }
    setState(() {
      
    });
  }




}