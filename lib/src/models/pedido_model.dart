// To parse this JSON data, do
//
//     final pedidoModel = pedidoModelFromJson(jsonString);

import 'dart:convert';

PedidoModel pedidoModelFromJson(String str) => PedidoModel.fromJson(json.decode(str));

String pedidoModelToJson(PedidoModel data) => json.encode(data.toJson());

String datoToJson( Dato dato ) => json.encode( dato.toJson() );

class PedidoModel {
    bool ok;
    List<Dato> datos;

    PedidoModel({
        this.ok,
        this.datos,
    });

    factory PedidoModel.fromJson(Map<String, dynamic> json) => PedidoModel(
        ok: json["ok"],
        datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
    };
}

class Dato {
    int idPedido;
    int id_producto;
    String nombre;
    DateTime fecha_ped;
    DateTime fecha_entr;
    int cant;
    int prec_uni;

    Dato({
        this.idPedido,
        this.id_producto,
        this.nombre,
        this.fecha_ped,
        this.fecha_entr,
        this.cant,
        this.prec_uni
    });

    factory Dato.fromJson(Map<String, dynamic> json) => Dato(
        idPedido      : json["id_pedido"],
        id_producto   : json["id_producto"],
        nombre        : json["nombre"],
        fecha_ped     : DateTime.parse(json["fechapedido"]),
        fecha_entr    : DateTime.parse(json["fechaentrega"]),
        cant          : json["cant"],
        prec_uni      : json["prec_uni"]
    );

    Map<String, dynamic> toJson() => {
        "id_pedido"     : idPedido,
        "id_producto"   : id_producto,
        "nombre"        : nombre,
        "fecha_ped"     : fecha_ped.toIso8601String(),
        "fecha_entr"    : fecha_entr.toIso8601String(),
        "cant"          : cant,
        "prec_uni"      : prec_uni
    };
}
