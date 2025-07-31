abstract class CartProductEntity {
  final String name;
  final String imageUrl;
  final String size;
  final String color;
  final double price;
  final int quantity;

  CartProductEntity({
    required this.quantity,
    required this.name,
    required this.imageUrl,
    required this.size,
    required this.color,
    required this.price,
  });
}
