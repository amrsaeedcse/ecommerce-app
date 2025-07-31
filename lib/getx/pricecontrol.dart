import 'package:get/get.dart';

class PriceControl extends GetxController {
  var subTotal = 0.0.obs;
  final shippingCost = 8.0.obs;
  final disCost = 0.0.obs;
  var tax = 0.0.obs;
  var total = 0.0.obs;
  var isDis = false.obs;

  void setSubTotal(double price) => subTotal.value = price;
  void setShippingCost(double price) => shippingCost.value = price;
  void setTotal(double price) => total.value = price;
  void setDisCost(double price) => disCost.value = price;
  void setIsDis(bool isD) {
    isDis.value = isD;
  }
}
