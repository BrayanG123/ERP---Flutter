// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
    bool ok;
    List<Dato> datos;

    Client({
        this.ok,
        this.datos,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        ok: json["ok"],
        datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
    };
}

class Dato {
    int idCategoria;
    String nombre;

    Dato({
        this.idCategoria,
        this.nombre,
    });

    factory Dato.fromJson(Map<String, dynamic> json) => Dato(
        idCategoria: json["id_categoria"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id_categoria": idCategoria,
        "nombre": nombre,
    };
}
