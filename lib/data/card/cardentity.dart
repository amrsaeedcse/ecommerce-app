class CardEntity {
  final String number;
  final String ccv;
  final String exp;
  final String cardHolder;
  CardEntity({
    required this.number,
    required this.cardHolder,
    required this.ccv,
    required this.exp,
  });
}
