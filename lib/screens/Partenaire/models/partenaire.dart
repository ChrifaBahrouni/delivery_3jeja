import 'dart:convert';

class Partenaire {
  final String? id;
  final String Raison_sociale;
  final String nom_etab;
  final String type;
  final String items;
  final String cin;
  final String frais_livraison;
  final String whatsapp;
  final String facebook;
  final String instagram;

  //final List<dynamic> cart;

  Partenaire({
    //required
    this.id,
    required this.Raison_sociale,
    required this.nom_etab,
    required this.type,
    required this.cin,
    required this.items,
    required this.instagram,
    required this.facebook,
    required this.whatsapp,
    required this.frais_livraison,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Raison_sociale': Raison_sociale,
      'nom_etab': nom_etab,
      'cin': cin,
      'type': type,
      'instagram': instagram,
      'faceboook': facebook,
      'items': items,
      'frais_livraison': frais_livraison,
    };
  }

  factory Partenaire.fromMap(Map<String, dynamic> map) {
    return Partenaire(
      id: map['_id'] ?? '',
      nom_etab: map['nom_etab'] ?? '',
      Raison_sociale: map['Raison_sociale'] ?? '',
      instagram: map['instagram'] ?? '',
      items: map['items'] ?? '',
      cin: map['cin'] ?? '',
      type: map['type'] ?? '',
      frais_livraison: map['frais_livraison'] ?? '',
      facebook: map['facebook'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Partenaire.fromJson(String source) =>
      Partenaire.fromMap(json.decode(source));

  Partenaire copyWith({
    String? id,
    String? nom_etab,
    String? Raison_sociale,
    String? cin,
    String? instagram,
    String? facebook,
    String? whatsapp,
    String? items,
    String? frais_livraison,
  }) {
    return Partenaire(
      id: id ?? this.id,
      nom_etab: nom_etab ?? this.nom_etab,
      Raison_sociale: Raison_sociale ?? this.Raison_sociale,
      items: items ?? this.items,
      cin: items ?? this.cin,
      type: items ?? this.type,
      instagram: items ?? this.instagram,
      facebook: items ?? this.facebook,
      whatsapp: items ?? this.whatsapp,
      frais_livraison: frais_livraison ?? this.frais_livraison,
    );
  }
}
