// To parse this JSON data, do
//
//     final categoriaModel = categoriaModelFromJson(jsonString);

import 'dart:convert';

CategoriaModel categoriaModelFromJson(String str) => CategoriaModel.fromJson(json.decode(str));

String categoriaModelToJson(CategoriaModel data) => json.encode(data.toJson());

String datoCatModeltoJson( Dato data ) => json.encode( data.toJson() );

class CategoriaModel {
    List<Dato> datos;
    Dato elemento;

    CategoriaModel({
        this.datos,
    });

    factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
        datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
    };
   
}

class Dato {
    int idCategoria;
    String nombre;
    bool estado;

    Dato({
        this.idCategoria,
        this.nombre,
        this.estado
    });

    factory Dato.fromJson(Map<String, dynamic> json) => Dato(
        idCategoria: json["id_categoria"],
        nombre: json["nombre"],
        estado: json["estado"]
    );

    Map<String, dynamic> toJson() => {
        "id_categoria": idCategoria,
        "nombre": nombre,
        "estado": estado
    };
}
