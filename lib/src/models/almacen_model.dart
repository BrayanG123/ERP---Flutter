// To parse this JSON data, do
//
//     final almacenModel = almacenModelFromJson(jsonString);

import 'dart:convert';

AlmacenModel almacenModelFromJson(String str) => AlmacenModel.fromJson(json.decode(str));

String almacenModelToJson(AlmacenModel data) => json.encode(data.toJson());

class AlmacenModel {
    bool ok;
    List<Dato> datos;

    AlmacenModel({
        this.ok,
        this.datos,
    });

    factory AlmacenModel.fromJson(Map<String, dynamic> json) => AlmacenModel(
        ok: json["ok"],
        datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
    };
}

class Dato {
    int idAlmacen;
    String nombre;
    Ubicacion ubicacion;

    Dato({
        this.idAlmacen,
        this.nombre,
        this.ubicacion,
    });

    factory Dato.fromJson(Map<String, dynamic> json) => Dato(
        idAlmacen: json["id_almacen"],
        nombre: json["nombre"],
        ubicacion: Ubicacion.fromJson(json["ubicacion"]),
    );

    Map<String, dynamic> toJson() => {
        "id_almacen": idAlmacen,
        "nombre": nombre,
        "ubicacion": ubicacion.toJson(),
    };
}

class Ubicacion {
    String latitud;
    String longitud;

    Ubicacion({
        this.latitud,
        this.longitud,
    });

    factory Ubicacion.fromJson(Map<String, dynamic> json) => Ubicacion(
        latitud: json["latitud"],
        longitud: json["longitud"],
    );

    Map<String, dynamic> toJson() => {
        "latitud": latitud,
        "longitud": longitud,
    };
}
