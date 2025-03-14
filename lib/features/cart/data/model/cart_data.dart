class CartModel {
  final String image;
  final String id;
  final String description;
  final String name;
  final String category;
  final num price;
  final num quantity;
  final num totalPrice;
  CartModel({
    required this.id,
    required this.image,
    required this.description,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  });
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["_id"],
      image: json['image'],
      description: json['description'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
    );
  }
}
