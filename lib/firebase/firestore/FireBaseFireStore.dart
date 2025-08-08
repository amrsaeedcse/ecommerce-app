import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/data/address/addressmodel.dart';
import 'package:ecommerceapp/data/cart/cartmodel.dart';
import 'package:ecommerceapp/data/checkout/checkoutmodel.dart';
import 'package:ecommerceapp/data/notifications/notificationsmodel.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/data/rating/ratingmodel.dart';
import 'package:ecommerceapp/firebase/fireauth/firebaseauth.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../widgets/user.dart';

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
        List<ProductModel> productsList = await checkHeart(querySnapshot);
        for (var p in productsList) {
          print(p.isFav);
        }
        // for (DocumentSnapshot<Map<String, dynamic>> documentSnapshot
        //     in querySnapshot.docs) {
        //   ProductModel productModel = ProductModel.fromJson(
        //     documentSnapshot.data()!,
        //   );
        //   productsList.add(productModel);
        // }
        someProducts = List<ProductModel>.from(productsList);
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
          DocumentSnapshot<Map<String, dynamic>> doc = await fireBaseFireStore
              .collection("users")
              .doc(ratingModel.userId)
              .get();
          ratingModel.userName = doc.data()!["name"];
          if (doc.data()!.containsKey('image')) {
            Uint8List a = base64Decode(doc.data()!['image']);
            ratingModel.userImage = a;
          }

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
      // DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      //     await fireBaseFireStore
      //         .collection("users")
      //         .doc(FirebaseAuth.instance.currentUser!.uid)
      //         .get();
      // print(documentSnapshot.exists);
      // ratingModel.userName = "mohamde";

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

  Future<void> addCheckOutWithProducts(
    CheckOutModel checkOutModel,
    NotificationsModel nM,
  ) async {
    checkOutModel.progress = "Processing";
    final userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference checkOutRef = await fireBaseFireStore
        .collection("checkOuts")
        .doc(userId)
        .collection("userCheckOuts")
        .add(checkOutModel.toJson());
    await checkOutRef.update({"orderId": checkOutRef.id});
    for (var cartModel in checkOutModel.cartModels) {
      final data = cartModel.toJSon();
      data['time'] = Timestamp.now();
      await checkOutRef.collection("carts").add(data);
    }
    nM.message =
        "you placed and order #${checkOutRef.id} check your email history for full details";
    await addNotifications(nM);

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': "service_c1giws2",
        'template_id': "template_d8qqlu5",
        'user_id': "03Eq50fwVTJw_DFiJ",
        'template_params': {
          "order_id": checkOutRef.id,
          "email": FirebaseAuth.instance.currentUser!.email,
          "orders": checkOutModel.cartModels.map((e) {
            return {
              "name": e.name,
              "units": e.quantity,
              "price": e.price,
              "image_url": e.imageUrl,
            };
          }).toList(),
          "cost": {"shipping": 8, "tax": 0, "total": checkOutModel.price},
        },
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {
      throw Exception("erorr");
    }
    //
  }

  Future<List<CheckOutModel>> getOrders() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("checkOuts")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCheckOuts")
        .orderBy("time", descending: true)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<CheckOutModel> checkOutModels = [];
      for (var doc in querySnapshot.docs) {
        CheckOutModel checkOutModel = CheckOutModel.fromJson(doc.data());

        QuerySnapshot<Map<String, dynamic>> querySnapshot = await doc.reference
            .collection("carts")
            .get();
        List<CartModel> cartModels = querySnapshot.docs.map((e) {
          return CartModel.fromJson(e.data());
        }).toList();
        checkOutModel.cartModels = List<CartModel>.from(cartModels);
        checkOutModels.add(checkOutModel);
      }
      return checkOutModels;
    } else {
      throw Exception("empty");
    }
  }

  Future addToWithList(ProductModel prM) async {
    await fireBaseFireStore
        .collection("wishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userWishList")
        .add(prM.toJson());
  }

  Future removeFromWithList(ProductModel prM) async {
    QuerySnapshot<Map<String, dynamic>> queryDocumentSnapshot =
        await fireBaseFireStore
            .collection("wishList")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userWishList")
            .where("name", isEqualTo: prM.name.trim())
            .limit(1)
            .get();
    if (queryDocumentSnapshot.docs.isNotEmpty) {
      await fireBaseFireStore
          .collection("wishList")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userWishList")
          .doc(queryDocumentSnapshot.docs.first.id)
          .delete();
    } else {
      throw Exception("error");
    }
  }

  Future<List<ProductModel>> checkHeart(
    QuerySnapshot<Map<String, dynamic>> q,
  ) async {
    List<ProductModel> productModels = [];
    for (var doc in q.docs) {
      ProductModel productModel = ProductModel.fromJson(doc.data());
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await fireBaseFireStore
              .collection("wishList")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("userWishList")
              .where("name", isEqualTo: productModel.name)
              .get();
      if (querySnapshot.docs.isNotEmpty) {
        productModel.isFav = true;
      }
      productModels.add(productModel);
    }
    return productModels;
  }

  Future<List<ProductModel>> getWishList() async {
    QuerySnapshot<Map<String, dynamic>> queryDocumentSnapshot =
        await fireBaseFireStore
            .collection("wishList")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userWishList")
            .get();
    print(queryDocumentSnapshot.docs.length);
    if (queryDocumentSnapshot.docs.isEmpty) {
      throw Exception("empty");
    } else {
      List<ProductModel> productModels = [];
      for (var p in queryDocumentSnapshot.docs) {
        ProductModel productModel = ProductModel.fromJson(p.data());
        productModel.isFav = true;
        productModels.add(productModel);
      }
      return productModels;
    }
  }

  Future<UserModel> getProfile() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await fireBaseFireStore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    if (documentSnapshot.exists) {
      return UserModel.fromJsonXd(documentSnapshot.data()!);
    } else {
      throw Exception("error");
    }
  }

  Future editProfile(UserModel userModel) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(userModel.toJson());
  }

  Future<List<NotificationsModel>> getNotifications() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("Notifications")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userNotifications")
        .orderBy("time", descending: true)
        .get();
    if (querySnapshot.docs.isEmpty) {
      throw Exception("empty");
    } else {
      List<NotificationsModel> notificationsModels = querySnapshot.docs.map((
        e,
      ) {
        return NotificationsModel.fromJson(e.data());
      }).toList();
      return notificationsModels;
    }
  }

  Future addNotifications(NotificationsModel notificationsModel) async {
    print("hdsd");
    await fireBaseFireStore
        .collection("Notifications")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userNotifications")
        .add(notificationsModel.toJson());
  }

  Future<String> getProfileImage() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await fireBaseFireStore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    if (documentSnapshot.exists) {
      if (documentSnapshot.data()!.containsKey("image")) {
        return documentSnapshot.data()!['image'];
      } else {
        throw Exception("noImage");
      }
    } else {
      throw Exception("error");
    }
  }

  Future addProfileImage(String image) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'image': image}, SetOptions(merge: true));
  }

  Future removeAddress(AddressModel addressModel, BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await fireBaseFireStore
              .collection("address")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("userAddresses")
              .where('city', isEqualTo: addressModel.city)
              .where('state', isEqualTo: addressModel.state)
              .where('street', isEqualTo: addressModel.street)
              .where('zipCode', isEqualTo: addressModel.zipCode)
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
            .delete();
        SnackBarWarning.showSnack("address removed", context);
      } else {
        throw Exception("error");
      }
    } catch (e) {
      SnackBarWarning.showSnack(
        "error happened while removing address",
        context,
      );
    }
  }
}
