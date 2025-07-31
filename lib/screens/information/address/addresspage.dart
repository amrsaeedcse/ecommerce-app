import 'package:ecommerceapp/animation/slidefadeanimation.dart';
import 'package:ecommerceapp/bloc/getAddresses/get_addresses_cubit.dart';
import 'package:ecommerceapp/getx/addresscontrol.dart';
import 'package:ecommerceapp/screens/information/address/addaddress.dart';
import 'package:ecommerceapp/screens/information/address/editaddresspage.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/back.dart';
import '../../../widgets/gap.dart';
import 'package:get/get.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final addressController = Get.find<AddressControl>();

  @override
  void initState() {
    // TODO: implement initState
    context.read<GetAddressesCubit>().getAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<GetAddressesCubit, GetAddressesState>(
        builder: (context, state) {
          if (state is GetAddressesFailure) {
            return Center(
              child: CustomText(
                text: "error",
                weight: FontWeight.w700,
                size: 20,
              ),
            );
          } else if (state is GetAddressesLoading) {
            return Center(
              child: CupertinoActivityIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (state is GetAddressesEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: "no addresses for you add one !",
                    weight: FontWeight.w700,
                    size: 20,
                  ),
                  Gap(12.h),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAddressPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }
          final data = (state as GetAddressesSuccess).addressModels;
          return Padding(
            padding: EdgeInsets.only(right: 24.0.w, left: 24.w, bottom: 34.h),
            child: Column(
              children: [
                Gap(63.h),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(alignment: Alignment.centerLeft, child: Back()),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddAddressPage(),
                          ),
                        ),
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Center(
                      child: CustomText(
                        text: "Address",
                        weight: FontWeight.w700,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                Gap(32.h),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return SlideFadeAnimation(
                        widget: Material(
                          color: Theme.of(context).colorScheme.onPrimary,

                          borderRadius: BorderRadius.circular(8.r),
                          child: InkWell(
                            onTap: () {
                              addressController.addressModel.value =
                                  data[index];
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 72.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 248.w,
                                    child: CustomText(
                                      text:
                                          '${data[index].street}, ${data[index].city}, ${data[index].state} ${data[index].zipCode}',
                                      weight: FontWeight.w700,
                                      size: 16,
                                    ),
                                  ),

                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditAddressPage(
                                            addressModel: data[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: CustomText(
                                      text: "Edit",
                                      weight: FontWeight.w700,
                                      size: 12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    itemCount: data.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
