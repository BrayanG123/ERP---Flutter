import 'dart:async';



class Validators {


  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( email, sink ) {

      Pattern patron = r'[\w]';
      Pattern patron2 = r'(\W|^)[\w.\-]{0,25}';
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(patron2);

      if ( regExp.hasMatch( email ) ) {
        sink.add( email );
      } else {
        sink.addError('Email no es correcto');
      }

    }
  );


  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( password, sink ) {

      if ( password.length >= 2 ) {
        sink.add( password );
      } else {
        sink.addError('Más de 6 caracteres por favor');
      }

    }
  );


}
