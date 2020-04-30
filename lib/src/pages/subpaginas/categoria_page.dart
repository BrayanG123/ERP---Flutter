import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/categoria_model.dart';
import 'package:formvalidation/src/pages/reciclers/fondo_pantalla.dart';
import 'package:formvalidation/src/providers/categoria_providers.dart';

class CategoriaPage extends StatelessWidget {

  List<CategoriaModel> _lista = new List();
  final _categoriaprovider = new CategoriaProviders();
  TextEditingController _crearController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
      ),
      body: Stack(
        children: <Widget>[
          fondoPantalla(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(                      
              children: <Widget>[
                _newCategoria( context ),                        
                Expanded(             
                  child: _crearListado(),           
                )
              ],
            ),
          ),
        ],
      ), 
      
    );
  }

  Widget _crearListado(){
    return FutureBuilder(
      future: _categoriaprovider.cargarCategoria(),
      builder: (BuildContext context, AsyncSnapshot<List<CategoriaModel>> snapshot){
        if ( snapshot.hasData ){
          final categorias = snapshot.data;
          _lista = snapshot.data;
          return ListView.builder(      
            scrollDirection: Axis.vertical,  
            shrinkWrap: true,
            itemCount: categorias[0].datos.length, //los n elementos
            itemBuilder: (context, i) => _crearItem(context, categorias[0].datos[i]),//un objeto en especifico
          );
        }else{
          return Center( child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _crearItem( BuildContext context, Dato categoria ){
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
                  //child: Image.network(categoria.imagen, fit: BoxFit.cover),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () => {},
                ),
                title: Text('${ categoria.nombre }'),          
                subtitle: Text('ID Categoria: ${ categoria.idCategoria }'),               
              ),

              SizedBox(height: 20.0,)
          ],
      ),
      )
      
    );
  }

  Widget _newCategoria( BuildContext context ){
    return Column(
      children: <Widget>[
        Text('Crear nueva categoria', style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 8.0,),
        TextField(
          controller: _crearController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: 'Categoria',
          labelText: 'Nueva categoria',
          //suffixIcon: Icon(Icons.cat),
          icon: Icon(Icons.category),
        ),
        ),
        RaisedButton(
          child: Text('Crear'),
          onPressed: (){
            if ( _crearController.text.length == 0){
              return _alerta(context);
            }else{
              if ( _existe( _crearController.text ))  
                return _alerta(context);
              else
                _postCategoria( _crearController.text );
            }
          },
        )
      ],
    );
  }

  _postCategoria( String nombre ){
    Dato categoria =  new Dato(nombre: nombre);
    _categoriaprovider.crearCategoria(categoria);
  }

  bool _existe( String nombre ){

    _lista[0].datos.forEach( (cat){
      if ( cat.nombre.contains(nombre) )  return true;
    } );

    return false;
  }

  Widget _alerta( BuildContext context ){
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop(); },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ha ocurrido un error"),
      content: Text("Instroduzca un nombre valido \nPuede que el nombre ya exista"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }


}