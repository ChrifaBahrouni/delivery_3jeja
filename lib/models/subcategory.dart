import 'dart:convert';

class SubCategory {
  final String id;
  final double name;
  SubCategory({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
    };
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategory.fromJson(String source) =>
      SubCategory.fromMap(json.decode(source));
}
