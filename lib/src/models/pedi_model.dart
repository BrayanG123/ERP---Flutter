// To parse this JSON data, do
//
//     final pediModel = pediModelFromJson(jsonString);

import 'dart:convert';

PediModel pediModelFromJson(String str) => PediModel.fromJson(json.decode(str));

String pediModelToJson(PediModel data) => json.encode(data.toJson());

class PediModel {
    List<Dato> datos;

    PediModel({
        this.datos,
    });

    factory PediModel.fromJson(Map<String, dynamic> json) => PediModel(
        datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
    };
}

class Dato {
    int idPedido;
    String nombre;
    DateTime fechapedido;
    DateTime fechaentrega;
    int cant;
    int preciounidad;

    Dato({
        this.idPedido,
        this.nombre,
        this.fechapedido,
        this.fechaentrega,
        this.cant,
        this.preciounidad,
    });

    factory Dato.fromJson(Map<String, dynamic> json) => Dato(
        idPedido: json["id_pedido"],
        nombre: json["nombre"],
        fechapedido: DateTime.parse(json["fechapedido"]),
        fechaentrega: DateTime.parse(json["fechaentrega"]),
        cant: json["cant"],
        preciounidad: json["preciounidad"],
    );

    Map<String, dynamic> toJson() => {
        "id_pedido": idPedido,
        "nombre": nombre,
        "fechapedido": fechapedido.toIso8601String(),
        "fechaentrega": fechaentrega.toIso8601String(),
        "cant": cant,
        "preciounidad": preciounidad,
    };
}
