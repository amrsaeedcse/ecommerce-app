import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModelMake {
  final String id, name, imageUrl, category, gender;
  final double price;
  final double? oldPrice;
  final bool isPriceChanged, isNew, isTopSelling;

  ProductModelMake({
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

  static final List<ProductModelMake> demo20Products = [
    ProductModelMake(
      id: 'p1',
      name: 'Gray Hoodie',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      oldPrice: 70,
      price: 60,
      isPriceChanged: true,
      isTopSelling: true,
      category: 'hoodie',
      gender: 'male',
    ),
    ProductModelMake(
      id: 'p2',
      name: 'Pink Hoodie',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 55,
      isNew: true,
      category: 'hoodie',
      gender: 'female',
    ),
    ProductModelMake(
      id: 'p3',
      name: 'Black Athletic Shorts',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 35,
      isTopSelling: true,
      category: 'shorts',
      gender: 'male',
    ),
    ProductModelMake(
      id: 'p4',
      name: 'White Linen Shorts',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 40,
      isNew: true,
      category: 'shorts',
      gender: 'female',
    ),
    ProductModelMake(
      id: 'p5',
      name: 'Running Shoes',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 120,
      isTopSelling: true,
      category: 'shoes',
      gender: 'male',
    ),
    ProductModelMake(
      id: 'p6',
      name: 'Casual Sneakers',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      oldPrice: 90,
      price: 80,
      isPriceChanged: true,
      category: 'shoes',
      gender: 'female',
    ),
    ProductModelMake(
      id: 'p7',
      name: 'Navy Hoodie',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 65,
      isNew: true,
      category: 'hoodie',
      gender: 'male',
    ),
    ProductModelMake(
      id: 'p8',
      name: 'Gray Crop Hoodie',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 50,
      isTopSelling: true,
      category: 'hoodie',
      gender: 'female',
    ),
    ProductModelMake(
      id: 'p9',
      name: 'Blue Sport Shorts',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 30,
      isNew: true,
      category: 'shorts',
      gender: 'male',
    ),
    ProductModelMake(
      id: 'p10',
      name: 'Pink Fitness Shorts',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 38,
      category: 'shorts',
      gender: 'female',
    ),
    ProductModelMake(
      id: 'p11',
      name: 'White Sneakers',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      oldPrice: 95,
      price: 85,
      isPriceChanged: true,
      category: 'shoes',
      gender: 'male',
    ),
    ProductModelMake(
      id: 'p12',
      name: 'Running Shoes Pink',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 110,
      isNew: true,
      category: 'shoes',
      gender: 'female',
    ),
    ProductModelMake(
      id: 'p13',
      name: 'Canvas Tote Bag',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 25,
      isTopSelling: true,
      category: 'bag',
      gender: 'male',
    ),
    ProductModelMake(
      id: 'p14',
      name: 'Crossbody Bag',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 45,
      isNew: true,
      category: 'bag',
      gender: 'female',
    ),
    ProductModelMake(
      id: 'p15',
      name: 'Gold Hoop Earrings',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 30,
      category: 'accessory',
      gender: 'female',
    ),
    ProductModelMake(
      id: 'p16',
      name: 'Leather Wallet',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 40,
      isTopSelling: true,
      category: 'accessory',
      gender: 'male',
    ),
    ProductModelMake(
      id: 'p17',
      name: 'Baseball Cap',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 20,
      category: 'accessory',
      gender: 'male',
    ),
    ProductModelMake(
      id: 'p18',
      name: 'Basketball Shoes',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 130,
      isTopSelling: true,
      category: 'shoes',
      gender: 'male',
    ),
    ProductModelMake(
      id: 'p19',
      name: 'Cargo Shorts',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      price: 45,
      category: 'shorts',
      gender: 'male',
    ),
    ProductModelMake(
      id: 'p20',
      name: 'Scarf',
      imageUrl:
          'https://hourscollection.com/cdn/shop/files/YoursisHourshoodies-front_1000x.jpg?v=1748289262',
      oldPrice: 25,
      price: 18,
      isPriceChanged: true,
      category: 'accessory',
      gender: 'female',
    ),
  ];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'oldPrice': oldPrice,
      'isPriceChanged': isPriceChanged,
      'isNew': isNew,
      'isTopSelling': isTopSelling,
      'category': category,
      'gender': gender,
    };
  }

  static Future<void> upload20Products() async {
    final ref = FirebaseFirestore.instance.collection('products');
    for (var p in demo20Products) {
      await ref.doc(p.id).set(p.toJson());
    }
    print('✅ 20 products uploaded!');
  }
}
