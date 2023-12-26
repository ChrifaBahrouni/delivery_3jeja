import 'dart:convert';

import 'package:delivery_3jeja/models/subcategory.dart';



class Categorie {
  final String? id;
  final String photo;
  final String name;
   final String? bayer ; 
  //final String bayer ; 
  final List<SubCategory>? subcategories;
  Categorie(
      {
      required this.photo,
      required this.name,
        // required this.bayer, 
      this.subcategories , 
      this.id , this.bayer});

  Map<String, dynamic> toMap() {
    return {
     // 'id': id,
      'name': name,
      'photo': photo,
      'subcategories': subcategories,
    };
  }

  factory Categorie.fromMap(Map<String, dynamic> map) {
    return Categorie(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      photo: map['photo'] ?? '',
      subcategories: map['subcategories'] != null
          ? List<SubCategory>.from(
              map['subcategories']?.map(
                (x) => SubCategory.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Categorie.fromJson(String source) =>
      Categorie.fromMap(json.decode(source));

  Categorie copyWith({
    String? id,
    String? name,
    String? photo,
  }) {
    return Categorie(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
    );
  }
}
