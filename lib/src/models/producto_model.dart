// To parse this JSON data, do
//
//     final ProductoModel = ProductoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel ProductoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String ProductoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    String id;
    String titulo;
    double valor;
    bool disponible;
    String foto;

    ProductoModel({
        this.id,
        this.titulo = '',
        this.valor = 0.0,
        this.disponible = true,
        this.foto,
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => new ProductoModel(
        id            : json["id"],
        titulo        : json["titulo"],
        valor         : json["valor"],
        disponible    : json["disponible"],
        foto          : json["foto"],
    );

    Map<String, dynamic> toJson() => {
        //"id"          : id,
        "titulo"      : titulo,
        "valor"       : valor,
        "disponible"  : disponible,
        "foto"        : foto,
    };
}
