import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/data/address/addressmodel.dart';
import 'package:ecommerceapp/data/cart/cartmodel.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/data/rating/ratingmodel.dart';
import 'package:ecommerceapp/firebase/fireauth/firebaseauth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseFireStore {
  final fireBaseFireStore = FirebaseFirestore.instance;
  List<ProductModel> someProducts = [];
  List<ProductModel> categoryProduct = [];

  Future<bool> isHere(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await fireBaseFireStore.collection("users").doc(userId).get();
      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future addUserWithGoogle({
    required String email,
    required String name,
    required String age,
    required String sex,
    required String userId,
  }) async {
    await FirebaseFirestore.instance.collection("users").doc(userId).set({
      "name": name,
      "email": email,
      "age": age,
      "sex": sex,
    }, SetOptions(merge: true));
  }

  Future getCategoryProducts(String category) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await fireBaseFireStore
              .collection("products")
              .where('category', isEqualTo: "shoes")
              .get();
      if (querySnapshot.docs.isNotEmpty) {
        List<ProductModel> productsList = [];
        for (DocumentSnapshot<Map<String, dynamic>> documentSnapshot
            in querySnapshot.docs) {
          ProductModel productModel = ProductModel.fromJson(
            documentSnapshot.data()!,
          );
          productsList.add(productModel);
          categoryProduct = List<ProductModel>.from(productsList);
          print(productsList);
        }
      } else {
        throw Exception("no Products");
      }
    } catch (e) {
      print(e.toString());
      print(e.toString());
      if (e.toString().contains("no Products")) {
        throw Exception("no Products");
      } else {
        throw Exception("error");
      }
    }
  }

  Future getHomePageCat() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await fireBaseFireStore.collection("products").limit(10).get();
      if (querySnapshot.docs.isNotEmpty) {
        List<ProductModel> productsList = [];
        for (DocumentSnapshot<Map<String, dynamic>> documentSnapshot
            in querySnapshot.docs) {
          ProductModel productModel = ProductModel.fromJson(
            documentSnapshot.data()!,
          );
          productsList.add(productModel);
        }
        someProducts = List<ProductModel>.from(productsList);
        print(someProducts[0].isNew);
        print(getTopSelling());
        print(getNewIn());
      } else {
        throw Exception("no Products");
      }
    } catch (e) {
      print(e.toString());
      if (e.toString().contains("no Products")) {
        throw Exception("no Products");
      } else {
        throw Exception("error");
      }
    }
  }

  List<ProductModel> getNewIn() {
    if (someProducts.isNotEmpty) {
      List<ProductModel> newInList = someProducts
          .where((element) => element.isNew == true)
          .toList();
      return newInList;
    }
    return [];
  }

  List<ProductModel> getTopSelling() {
    if (someProducts.isNotEmpty) {
      List<ProductModel> topSelling = someProducts
          .where((element) => element.isTopSelling == true)
          .toList();
      return topSelling;
    }
    return [];
  }

  // List<ProductModel> getCategoryPr(String category) {
  //   if (someProducts.isNotEmpty) {
  //     List<ProductModel> categoryProduct = someProducts
  //         .where((element) => element.category == category)
  //         .toList();
  //     return categoryProduct;
  //   }
  //   return [];
  // }
  Future<List<ProductModel>> getData(String query) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await fireBaseFireStore
              .collection("products")
              .where("name", isGreaterThanOrEqualTo: query)
              .where("name", isLessThan: query + 'z')
              .get();
      List<ProductModel> productsList = [];
      for (DocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        ProductModel productModel = ProductModel.fromJson(
          documentSnapshot.data()!,
        );
        productsList.add(productModel);
      }
      return productsList;
    } catch (e) {
      return [];
    }
  }

  Future<List<RatingModel>> getRating(String pId) async {
    print("hi");
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await fireBaseFireStore
              .collection("ratings")
              .doc(pId)
              .collection("comments")
              .orderBy('time', descending: false)
              .get();
      if (querySnapshot.docs.isNotEmpty) {
        print(querySnapshot.docs);
        List<RatingModel> ratingsModels = [];
        for (DocumentSnapshot<Map<String, dynamic>> documentSnapshot
            in querySnapshot.docs) {
          RatingModel ratingModel = RatingModel.fromJsom(
            documentSnapshot.data()!,
          );
          ratingsModels.add(ratingModel);
        }
        // print(ratingsModels[0].comment);
        // print(ratingsModels[0].rating);
        return ratingsModels;
      } else {
        throw Exception("no ratings");
      }
    } catch (e) {
      if (e.toString().contains("no ratings")) {
        throw Exception("no ratings");
      } else {
        throw Exception("error");
      }
    }
  }

  Future addRating(RatingModel ratingModel, String pId) async {
    try {
      await fireBaseFireStore
          .collection("ratings")
          .doc(pId)
          .collection("comments")
          .add(ratingModel.toJson());
    } catch (e) {
      throw Exception();
    }
  }

  Future addToCart(CartModel cartModel) async {
    try {
      await fireBaseFireStore
          .collection("cart")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userCarts")
          .add(cartModel.toJSon());
    } catch (e) {
      throw Exception("error");
    }
  }

  Future<List<CartModel>> getCart() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCarts")
        .get();
    print(querySnapshot.docs);
    if (querySnapshot.docs.isNotEmpty) {
      List<CartModel> cartModels = [];
      for (var doc in querySnapshot.docs) {
        CartModel cartModel = CartModel.fromJson(doc.data());
        cartModels.add(cartModel);
      }
      return cartModels;
    } else {
      throw Exception("no carts");
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> checkCouponCode(
    String coupon,
  ) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("coupons")
        .where("code", isEqualTo: coupon)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      return null;
    }
  }

  Future<List<AddressModel>> getAddresses() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("address")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userAddresses")
        .get();
    print(querySnapshot.docs);
    if (querySnapshot.docs.isNotEmpty) {
      List<AddressModel> addressModels = [];
      for (var doc in querySnapshot.docs) {
        print("wassap");
        AddressModel addressModel = AddressModel.fromJson(doc.data());
        addressModels.add(addressModel);
      }
      return addressModels;
    } else {
      throw Exception("no Address");
    }
  }

  Future addAddress(AddressModel addressModel) async {
    try {
      await fireBaseFireStore
          .collection("address")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userAddresses")
          .add(addressModel.toJSon());
    } catch (e) {
      throw Exception("error");
    }
  }

  Future editAddress(
    AddressModel oldAddressModel,
    AddressModel newAddressModel,
  ) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("address")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userAddresses")
        .where('city', isEqualTo: oldAddressModel.city)
        .where('state', isEqualTo: oldAddressModel.state)
        .where('street', isEqualTo: oldAddressModel.street)
        .where('zipCode', isEqualTo: oldAddressModel.zipCode)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          querySnapshot.docs[0];
      await fireBaseFireStore
          .collection("address")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userAddresses")
          .doc(documentSnapshot.id)
          .set(newAddressModel.toJSon());
    } else {
      throw Exception("error");
    }
  }

  Future removeAll() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCarts")
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
