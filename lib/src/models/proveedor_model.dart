// To parse this JSON data, do
//
//     final proveedorModel = proveedorModelFromJson(jsonString);

import 'dart:convert';

ProveedorModel proveedorModelFromJson(String str) => ProveedorModel.fromJson(json.decode(str));

String proveedorModelToJson(ProveedorModel data) => json.encode(data.toJson());

class ProveedorModel {
    bool ok;
    List<Dato> datos;

    ProveedorModel({
        this.ok,
        this.datos,
    });

    factory ProveedorModel.fromJson(Map<String, dynamic> json) => ProveedorModel(
        ok: json["ok"],
        datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
    };
}

class Dato {
    int idProvedor;
    String nombre;
    List<String> telefono;
    String email;
    String direccion;
    List<String> foto;
    bool estado;

    Dato({
        this.idProvedor,
        this.nombre,
        this.telefono,
        this.email,
        this.direccion,
        this.foto,
        this.estado,
    });

    factory Dato.fromJson(Map<String, dynamic> json) => Dato(
        idProvedor  : json["id_provedor"],
        nombre      : json["nombre"],
        telefono    : List<String>.from(json["telefono"].map((x) => x)),
        email       : json["email"],
        direccion   : json["direccion"],
        foto        : List<String>.from(json["foto"].map((x) => x)),
        estado      : json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id_provedor" : idProvedor,
        "nombre"      : nombre,
        "telefono"    : List<dynamic>.from(telefono.map((x) => x)),
        "email"       : email,
        "direccion"   : direccion,
        "foto"        : List<dynamic>.from(foto.map((x) => x)),
        "estado"      : estado,
    };
}
