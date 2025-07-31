import 'package:get/get.dart';

class RatingController extends GetxController {
  RxDouble finalRating = 0.0.obs;
  RxInt numberOfThem = 0.obs;
  RxInt numberOfStar = 1.obs;

  RxString size = "S".obs;
  RxString color = "red".obs;
  RxInt quantity = 0.obs;

  void setRating(double rat) {
    finalRating.value = rat;
  }

  void setNumber(int rat) {
    numberOfThem.value = rat;
  }

  void setNumberOfStar(int rat) {
    numberOfStar.value = rat;
    print(numberOfStar.value);
    print(numberOfThem.value);
    print(finalRating.value);
  }

  void setSize(String s) {
    size.value = s;
  }

  void setColor(String s) {
    color.value = s;
  }

  void setQuantity(int s) {
    quantity.value = s;
  }
}
