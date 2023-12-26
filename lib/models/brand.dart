import 'dart:convert';

class Brand {
  final String id;
  final String title;
  final String image;
 
 
  //final List<dynamic> cart;

  Brand({
    required this.id,
    required this.title,
    required this.image,
  
 
   // required this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
     
      
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      image: map['image'] ?? '',
     
     
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source));

  Brand copyWith({
    String? id,
    String? title,
    String? image,
   
    
  }) {
    return Brand(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
    
     
    );
  }
}
