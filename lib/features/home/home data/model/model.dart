class Model {
  final String name;
  final String description;
  final String category;
  final String image;
  final num price;

  Model(
      {required this.description,
      required this.category,
      required this.name,
      required this.image,
      required this.price});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      category: json['category'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      description: json['description'],
    );
  }
}
