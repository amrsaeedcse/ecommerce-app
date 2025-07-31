class ProductEntity {
  final String id, name, imageUrl, category, gender;
  final double price;
  final double? oldPrice;
  final bool isPriceChanged, isNew, isTopSelling;

  ProductEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    this.isPriceChanged = false,
    this.isNew = false,
    this.isTopSelling = false,
    required this.category,
    required this.gender,
  });
}
