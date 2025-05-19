class DishesModel{
  String id;
  String name;
  String price;
  String currency;
  String description;
  String image_url;
  double calories;
  int qty;
  List addons;
  bool customizations_available;
  bool is_veg;

//<editor-fold desc="Data Methods">
  DishesModel({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.description,
    required this.image_url,
    required this.calories,
    required this.qty,
    required this.addons,
    required this.customizations_available,
    required this.is_veg,
  });



  DishesModel copyWith({
    String? id,
    String? name,
    String? price,
    String? currency,
    String? description,
    String? image_url,
    double? calories,
    int? qty,
    List? addons,
    bool? customizations_available,
    bool? is_veg,
  }) {
    return DishesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      image_url: image_url ?? this.image_url,
      calories: calories ?? this.calories,
      qty: qty ?? this.qty,
      addons: addons ?? this.addons,
      customizations_available: customizations_available ?? this.customizations_available,
      is_veg: is_veg?? this.is_veg,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'currency': this.currency,
      'description': this.description,
      'image_url': this.image_url,
      'calories': this.calories,
      'qty': this.qty,
      'addons': this.addons,
      'customizations_available': this.customizations_available,
      'is_veg': this.is_veg,
    };
  }

  factory DishesModel.fromMap(Map<String, dynamic> map) {
    return DishesModel(
      id: map['id'].toString(),
      name: map['name']??"",
      price: map['price']??"0",
      currency: map['currency'] ??"INR",
      description: map['description']??"",
      image_url: map['image_url'] ??"",
      calories:double.parse( map['calories']==null?"0":map['calories'].toString()),
      qty: map['qty']??0,
      addons: map['addons']??[],
      is_veg: map['is_veg'],
      customizations_available: map['customizations_available'],
    );
  }

//</editor-fold>
}