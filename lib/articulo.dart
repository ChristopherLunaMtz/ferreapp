// To parse this JSON data, do
//
//     final articulo = articuloFromJson(jsonString);

import 'dart:convert';

Articulo articuloFromJson(String str) => Articulo.fromJson(json.decode(str));

String articuloToJson(Articulo data) => json.encode(data.toJson());

class Articulo {
  int? id;
  String? name;
  double? price;
  int? quantity;

  Articulo({
    this.id,
    this.name,
    this.price,
    this.quantity,
  });

  factory Articulo.fromJson(Map<String, dynamic> json) => Articulo(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
      };
}
