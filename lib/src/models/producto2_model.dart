// To parse this JSON data, do
//
//     final producto2Model = producto2ModelFromJson(jsonString);

import 'dart:convert';

Producto2Model producto2ModelFromJson(String str) => Producto2Model.fromJson(json.decode(str));

String producto2ModelToJson(Producto2Model data) => json.encode(data.toJson());

class Producto2Model {
    bool ok;
    List<Dato> datos;

    Producto2Model({
        this.ok,
        this.datos,
    });

    factory Producto2Model.fromJson(Map<String, dynamic> json) => Producto2Model(
        //ok    : json["ok"],
        datos : List<Dato>.from(json["datos"].map((objeto) => Dato.fromJson(objeto))),
    );

    Map<String, dynamic> toJson() => {
        "ok"    : ok,
        "datos" : List<dynamic>.from(datos.map((x) => x.toJson())),
    };
}

class Dato {
    String idProducto;
    String idCategoria;
    String nombre;
    List<String> imagen;
    int costounidad;
    bool estado;

    Dato({
        this.idProducto,
        this.idCategoria,
        this.nombre,
        this.imagen,
        this.costounidad,
        this.estado,
    });

    factory Dato.fromJson(Map<String, dynamic> json) => Dato(
        idProducto  : json["id_producto"],
        idCategoria : json["id_categoria"],
        nombre      : json["nombre"],
        imagen      : List<String>.from(json["imagen"].map((x) => x)),//json["imagen"],
        costounidad : json["costounidad"],
        estado      : json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id_producto"   : idProducto,
        "id_categoria"  : idCategoria,
        "nombre"        : nombre,
        "imagen"        : List<dynamic>.from(imagen.map((x) => x)),
        "costounidad"   : costounidad,
        "estado"        : estado,
    };
}