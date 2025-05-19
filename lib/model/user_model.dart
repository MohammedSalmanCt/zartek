import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zartek_machine/model/dishes_model.dart';

class UserModel {
  final String name;
  final String email;
  final String id;
  final DocumentReference? reference;
  final List<DishesModel> cart;

  const UserModel({
    required this.name,
    required this.email,
    required this.id,
    this.reference,
    required this.cart,
  });

  UserModel copyWith({
    String? name,
    String? id,
    String? email,
    DocumentReference? reference,
    List<DishesModel>? cart,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      reference: reference ?? this.reference,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'reference':reference,
      'cart': cart.map((dish) => dish.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, {DocumentReference? reference}) {
    return UserModel(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      reference: map["reference"]??"",
      cart: (map['cart'] as List<dynamic>?)
          ?.map((item) => DishesModel.fromMap(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromMap(data, reference: doc.reference);
  }

  Map<String, dynamic> toJson() => toMap();
}
