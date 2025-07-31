import 'package:ecommerceapp/data/cart/cartmodel.dart';
import 'package:ecommerceapp/widgets/cartrow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../getx/pricecontrol.dart';

class CartList extends StatefulWidget {
  CartList({super.key, required this.cartModels});
  final List<CartModel> cartModels;

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  final priceController = Get.find<PriceControl>();

  void getPrices() {
    double sum = 0;
    for (int i = 0; i < widget.cartModels.length; i++) {
      sum += (widget.cartModels[i].price * widget.cartModels[i].quantity);
    }
    priceController.setSubTotal(sum);
    priceController.setTotal(
      priceController.tax.value + priceController.shippingCost.value + sum,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getPrices();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
      padding: EdgeInsets.zero,
      itemCount: widget.cartModels.length,
      itemBuilder: (context, index) {
        return CartRow(cartModel: widget.cartModels[index]);
      },
    );
  }
}
