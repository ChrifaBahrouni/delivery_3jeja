import 'dart:convert';

class User {
  final String id;
  late final String name;
  final String email;
  final String password;
  final List<dynamic> adresse;
  final String type;
  late final int phone;
  final String token;
  late final String avatar;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.adresse,
    required this.type,
    required this.phone,
    required this.token,
    required this.avatar,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': adresse,
      'type': type,
      'phone': phone,
      'token': token,
      'cart': cart,
      'avatar': avatar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      adresse: map['adresse'] ?? '',
      type: map['type'] ?? '',
      phone: map['phone'] ?? '',
      token: map['token'] ?? '',
      avatar: map['avatar'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    List<dynamic>? address,
    String? type,
    int? phone,
    String? token,
    String? avatar,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      adresse: address ?? this.adresse,
      type: type ?? this.type,
      phone: phone ?? this.phone,
      token: token ?? this.token,
      avatar: avatar ?? this.avatar,
      cart: cart ?? this.cart,
    );
  }
}
