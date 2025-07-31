import 'package:ecommerceapp/data/address/addressentity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.state,
    required super.city,
    required super.street,
    required super.zipCode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      state: json['state'],
      city: json['city'],
      street: json['street'],
      zipCode: json['zipCode'],
    );
  }

  Map<String, dynamic> toJSon() {
    return {"state": state, "city": city, "street": street, "zipCode": zipCode};
  }
}
