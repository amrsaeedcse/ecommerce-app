import 'package:ecommerceapp/data/catogeries/catogeries.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/catogeries/categoriesproducts.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: CatogeriesModel.catogeriesList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.0.h),
          child: Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoriesProducts(
                      productModel: CatogeriesModel.catogeriesList[index].title,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                height: 64.w,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          CatogeriesModel.catogeriesList[index].image,
                          width: 40.w,
                          height: 40.h,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      CustomText(
                        text: CatogeriesModel.catogeriesList[index].title,
                        weight: FontWeight.w500,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
