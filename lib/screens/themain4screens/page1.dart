import 'package:ecommerceapp/animation/fadeanimation.dart';
import 'package:ecommerceapp/bloc/gethomepagecat/get_home_page_cat_cubit.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:ecommerceapp/screens/cart/cartpage.dart';
import 'package:ecommerceapp/screens/catogeries/catogeriespage.dart';
import 'package:ecommerceapp/screens/product/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/catogeriesscroll.dart';
import '../../widgets/customappbar.dart';
import '../../widgets/customtext.dart';
import '../../widgets/gap.dart';
import '../../widgets/homepagesearch.dart';
import '../../widgets/productlist.dart';
import '../../widgets/productlistshimmer.dart';
import '../../widgets/textrow.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<ProductModel> topO = [];

  List<ProductModel> newO = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getData();
  }

  Future getData() async {
    await context.read<GetHomePageCatCubit>().getHomePageCat(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Gap(63.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FadeAnimation(
                  w: ClipOval(
                    child: Image.network(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadiusGeometry.circular(100.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: "Men",
                          weight: FontWeight.w700,
                          size: 14.sp,
                        ),
                        SizedBox(width: 6.72.w),
                        SvgPicture.asset("assets/images/icons/arrowdown2.svg"),
                      ],
                    ),
                  ),
                ),
                Material(
                  color: theme.primaryColor,
                  shape: CircleBorder(),
                  child: InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()),
                      );
                    },
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // color: theme.primaryColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset("assets/images/icons/bag2.svg"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(24.h),
            Hero(
              tag: "1",
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                ),
                child: AbsorbPointer(child: HomePageSearch()),
              ),
            ),

            Gap(24.h),
            TextRow(
              t1: "Categories",
              t2: "See All",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesPage()),
                );
              },
            ),
            Gap(16.h),
            CatogeriesScroll(),
            Gap(24.h),
            TextRow(t1: "Top Selling", t2: "See All", onTap: () {}),
            Gap(16.5.h),
            BlocConsumer<GetHomePageCatCubit, GetHomePageCatState>(
              listener: (context, state) {},
              builder: (context, state) {
                FireBaseFireStore fireBaseFireStore =
                    getIt<FireBaseFireStore>();

                topO = fireBaseFireStore.getTopSelling();
                newO = fireBaseFireStore.getNewIn();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (state is! GetHomePageCatLoading)
                        ? ProductList(
                            data: topO,
                            onTpaImage: () {},
                            onTpaLike: () {},
                          )
                        : ProductListShimmer(),
                    Gap(24.h),
                    TextRow(t1: "New In", t2: "See All", onTap: () {}),
                    Gap(16.h),
                    (state is! GetHomePageCatLoading)
                        ? ProductList(
                            data: newO,
                            onTpaImage: () {},
                            onTpaLike: () {},
                          )
                        : ProductListShimmer(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
