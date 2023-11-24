
Productmodel? productmodel;

class Productmodel {
  final String name;
  final int price;
  final List image;
  final String id;
  final bool delete;

  Productmodel({
    required this.name,
    required this.price,
    required this.image,
    required this.id,
    required this.delete,
  });

  factory Productmodel.fromJson(Map<String, dynamic> json) => Productmodel(
      name: json["name"],
      price: json["price"],
      // image: json["image"],
      id: json["id"],
      delete: json["delete"], image: []);

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    // "image": image,
    "id": id,
    "delete": delete,
  };

  Productmodel copyWith({
    String? name,
    int? price,
    List? image,
    String? id,
    bool? delete,
  }) {
    return Productmodel(
      name: name??this.name,
      price: price ?? this.price,
      // image: image ?? this.image,
      id: id ?? this.id,
      delete: delete ?? this.delete, image: [],
    );
  }
}