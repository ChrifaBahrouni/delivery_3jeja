import 'dart:convert';

import 'package:delivery_3jeja/models/rating.dart';


class Product {
  final String name;
  final String description;
  final double quantity;
  final String image;
  final String category;
  final double price;
  final String? id;
   final String bayer ;
  final List<Rating>? rating;
  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.image,
    required this.category,
    required this.price,
    this.id,
    this.rating,
     required this.bayer 
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'photo': image,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating,
      'bayer': bayer,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      image: map['photo'] ?? '',
         bayer: map['bayer'] ?? '', 
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
