import 'dart:convert';

class FastFood {
  final String id;
  final String nom_etab;
  final String avatar;
  final String items;
  //final String distance;
  final String Frais_livraison;

  //final List<dynamic> cart;

  FastFood({
    required this.id,
    required this.nom_etab,
    required this.avatar,
    required this.items,
    //required this.distance,
    required this.Frais_livraison,

    // required this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': nom_etab,
      'avatar': avatar,
      'items': items,
      // 'distance': distance,
      'Frais_livraison': Frais_livraison,
    };
  }

  factory FastFood.fromMap(Map<String, dynamic> map) {
    return FastFood(
      id: map['_id'] ?? '',
      nom_etab: map['nom_etab'] ?? '',
      avatar: map['avatar'] ?? '',
      items: map['items'] ?? '',
      //distance: map['distance'] ?? '',
      Frais_livraison: map['Frais_livraison'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FastFood.fromJson(String source) =>
      FastFood.fromMap(json.decode(source));

  FastFood copyWith({
    String? id,
    String? nom_etab,
    String? avatar,
    String? items,
    // String? distance,
    String? Frais_livraison,
  }) {
    return FastFood(
      id: id ?? this.id,
      nom_etab: nom_etab ?? this.nom_etab,
      avatar: avatar ?? this.avatar,
      items: items ?? this.items,
      // distance: distance ?? this.distance,
      Frais_livraison: Frais_livraison ?? this.Frais_livraison,
    );
  }
}
