import 'package:ecommerceapp/bloc/filter/filter_control_cubit.dart';
import 'package:ecommerceapp/bloc/filtergender/filter_gender_control_cubit.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:ecommerceapp/getx/countcontrol.dart';
import 'package:ecommerceapp/getx/finalratingcont.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/filterrow.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/homepagesearch.dart';
import 'package:ecommerceapp/widgets/productsgrid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../data/product/productmodel.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel> data = [];
  String query = '';
  int count = 0;
  FocusNode focusNode = FocusNode();
  TextEditingController tCont = TextEditingController();
  FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();

  Future<List<ProductModel>> getData() async {
    List<ProductModel> list = await fireBaseFireStore.getData(query);
    return list;
  }

  final ratingController = Get.put(RatingController());
  final countController = Get.put(CountControl());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tCont.addListener(() {
      setState(() {
        query = tCont.text;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<RatingController>();
    Get.delete<CountControl>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(66.h),
            Row(
              children: [
                Back(),
                SizedBox(width: 9.w),
                Expanded(
                  child: Hero(
                    tag: '1',
                    child: HomePageSearch(fn: focusNode, tCont: tCont),
                  ),
                ),
              ],
            ),
            Gap(24.h),
            FilterRow(),
            Gap(17.h),
            Obx(
              () => CustomText(
                text: "${countController.count.value} Results Found",
                weight: FontWeight.w500,
                size: 12.sp,
              ),
            ),
            Gap(16.h),
            Expanded(
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Lottie.asset("assets/lottie/search imm.json"),
                    );
                  }
                  data = snapshot.data!;
                  return data.isNotEmpty
                      ? BlocBuilder<FilterGenderControlCubit, FilterGenderType>(
                          builder: (context, state) {
                            return BlocBuilder<FilterControlCubit, FilterType>(
                              builder: (context, filter) {
                                switch (filter) {
                                  case FilterType.None:
                                    data = snapshot.data!;
                                    break;

                                  case FilterType.Lowest_HighestPrice:
                                    data.sort(
                                      (a, b) => a.price.compareTo(b.price),
                                    );
                                    break;

                                  case FilterType.Highest_LowestPrice:
                                    data.sort(
                                      (a, b) => b.price.compareTo(a.price),
                                    );
                                    break;
                                  default:
                                    break;
                                }
                                switch (state) {
                                  case FilterGenderType.Men:
                                    data = data
                                        .where(
                                          (element) => element.gender == "male",
                                        )
                                        .toList();
                                    break;
                                  case FilterGenderType.Women:
                                    data = data
                                        .where(
                                          (element) =>
                                              element.gender == "female",
                                        )
                                        .toList();
                                    break;
                                  default:
                                    break;
                                }
                                WidgetsBinding.instance.addPostFrameCallback((
                                  timeStamp,
                                ) {
                                  if (mounted) {
                                    countController.count.value = data.length;
                                  }
                                });
                                return ProductsGrid(
                                  key: UniqueKey(),
                                  count: data.length,
                                  data: data,
                                );
                              },
                            );
                          },
                        )
                      : Center(
                          child: Lottie.asset("assets/lottie/No History.json"),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
