import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../getit/service_locator.dart';

class HeartFav extends StatefulWidget {
  HeartFav({super.key, required this.productModel, this.additionalTap});
  final ProductModel productModel;
  void Function()? additionalTap;
  @override
  State<HeartFav> createState() => _HeartFavState();
}

class _HeartFavState extends State<HeartFav> {
  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();
  late BuildContext currContext;
  bool noPress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    currContext = context;
    super.didChangeDependencies();
  }

  Future addToWishList() async {
    if (!mounted || noPress) return; // early return

    setState(() {
      noPress = true;
    });

    try {
      if (widget.productModel.isFav) {
        // Remove from wishlist
        await fireBaseFireStore.removeFromWithList(widget.productModel);
        if (mounted) {
          setState(() {
            widget.productModel.isFav = false;
          });
          SnackBarWarning.showSnack("removed from wishList", currContext);
        }
      } else {
        // Add to wishlist
        await fireBaseFireStore.addToWithList(widget.productModel);
        if (mounted) {
          setState(() {
            widget.productModel.isFav = true;
          });
          SnackBarWarning.showSnack("added to wishList", currContext);
        }
      }
    } catch (e) {
      if (mounted) {
        SnackBarWarning.showSnack("error happened", currContext);
      }
    } finally {
      if (mounted) {
        setState(() {
          noPress = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: noPress == false
          ? () async {
              await addToWishList();
              if (widget.additionalTap != null) {
                widget.additionalTap!();
              }
            }
          : () {},
      child: widget.productModel.isFav == false
          ? SvgPicture.asset("assets/images/icons/heart.svg")
          : SvgPicture.asset("assets/images/icons/redheart.svg"),
    );
  }
}
