import 'dishes_model.dart';

class CategoryModel{
  String id;
  String name;
  List<DishesModel> dishes;

//<editor-fold desc="Data Methods">
  CategoryModel({
    required this.id,
    required this.name,
    required this.dishes,
  });



  CategoryModel copyWith({
    String? id,
    String? name,
    List<DishesModel>? dishes,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dishes: dishes ?? this.dishes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'dishes': dishes.isEmpty
          ? []
          : List<dynamic>.from(dishes.map((x) => x.toMap())),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'].toString(),
      name: map['name']??"",
      dishes:map['dishes']== null
          ? []: map['dishes'].length==0?[]
          : List<DishesModel>.from( map['dishes']!.map((x) => DishesModel.fromMap(x))),

    );
  }

//</editor-fold>
}
