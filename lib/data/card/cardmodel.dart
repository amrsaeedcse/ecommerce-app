import 'package:ecommerceapp/data/card/cardentity.dart';
import 'package:flutter/material.dart';

class CardModel extends CardEntity {
  CardModel({
    required super.number,
    required super.cardHolder,
    required super.ccv,
    required super.exp,
  });
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      exp: json['exp'],
      ccv: json['ccv'],
      cardHolder: json['cardHolder'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJSon() {
    return {"exp": exp, "ccv": ccv, "cardHolder": cardHolder, "number": number};
  }
}
