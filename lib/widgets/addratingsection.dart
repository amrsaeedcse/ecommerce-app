import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/getx/finalratingcont.dart';
import 'package:ecommerceapp/bloc/getratings/get_ratings_cubit.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/addrating/add_rating_cubit.dart';
import '../data/rating/ratingmodel.dart';
import 'package:get/get.dart';

class AddRatingSection extends StatelessWidget {
  AddRatingSection({
    super.key,
    required this.productModel,
    required this.resetList,
  });
  final ProductModel productModel;
  // final ScrollController scrollController;
  final void Function() resetList;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController tCont = TextEditingController();
  final ratingCont = Get.find<RatingController>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRatingCubit, AddRatingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56.h,
                child: Form(
                  key: _formKey,
                  child: CustomTextField(
                    hint: "Add comment",
                    cont: tCont,
                    type: InputType.name,
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.w),
            state is! AddRatingLoading
                ? IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        RatingModel ratingModel = RatingModel(
                          time: Timestamp.now(),
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          userName:
                              FirebaseAuth.instance.currentUser!.displayName!,
                          rating: ratingCont.numberOfStar.value,
                          comment: tCont.text,
                        );
                        context.read<AddRatingCubit>().addRating(
                          ratingModel,
                          productModel.id,
                        );
                        context.read<GetRatingsCubit>().getRating(
                          productModel.id,
                        );
                        tCont.clear();
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : CupertinoActivityIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
          ],
        );
      },
    );
  }
}
