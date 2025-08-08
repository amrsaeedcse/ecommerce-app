import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../bloc/getAddresses/get_addresses_cubit.dart';
import '../../../widgets/customtext.dart';
import '../../../widgets/back.dart';
import '../../../widgets/gap.dart';
import '../../../screens/information/address/addaddress.dart';
import '../../../getx/addresscontrol.dart';
import '../../../data/address/addressmodel.dart';
import 'addresslist.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key, required this.use});
  final bool use;

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late final addressController;

  @override
  void initState() {
    if (widget.use) {
      addressController = Get.find<AddressControl>();
    }
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
                  child: AddressListView(
                    data: data,
                    use: widget.use,
                    addressController: widget.use ? addressController : null,
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
