import 'package:ecommerceapp/bloc/editaddress/edit_address_cubit.dart';
import 'package:ecommerceapp/data/address/addressmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/getAddresses/get_addresses_cubit.dart';
import '../../../widgets/CustomElevatedButton.dart';
import '../../../widgets/back.dart';
import '../../../widgets/customtext.dart';
import '../../../widgets/gap.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/snackbar.dart';
import '../../../widgets/textfieldcus.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key, required this.addressModel});
  final AddressModel addressModel;
  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late TextEditingController t1;

  late TextEditingController t2;

  late TextEditingController t3;

  late TextEditingController t4;

  @override
  void initState() {
    // TODO: implement initState
    t1 = TextEditingController(text: widget.addressModel.street);
    t2 = TextEditingController(text: widget.addressModel.city);
    t3 = TextEditingController(text: widget.addressModel.state);
    t4 = TextEditingController(text: widget.addressModel.zipCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocConsumer<EditAddressCubit, EditAddressState>(
        listener: (context, state) {
          if (state is EditAddressSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            SnackBarWarning.showSnack("Address Edited", context);

            context.read<GetAddressesCubit>().getAddresses();
          } else if (state is EditAddressLoading) {
            Loading.showAlertLoading(context);
          } else if (state is EditAddressFailure) {
            Navigator.pop(context);
            SnackBarWarning.showSnack("Error happened try again", context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: Padding(
              padding: EdgeInsets.only(right: 24.0.w, left: 24.w, bottom: 34.h),
              child: Column(
                children: [
                  Gap(63.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(alignment: Alignment.centerLeft, child: Back()),
                      Center(
                        child: CustomText(
                          text: "Edit address",
                          weight: FontWeight.w700,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  Gap(32.h),
                  TextFieldCus(hint: "Street Address", cont: t1),
                  Gap(12.h),
                  TextFieldCus(hint: "City", cont: t2),
                  Gap(12.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldCus(hint: "State", cont: t3),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: TextFieldCus(hint: "Zip Code", cont: t4),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomElevatedButton(
                    fun: () {
                      if (t1.text.isNotEmpty &
                          t1.text.isNotEmpty &
                          t2.text.isNotEmpty &
                          t3.text.isNotEmpty &
                          t4.text.isNotEmpty) {
                        context.read<EditAddressCubit>().edit(
                          widget.addressModel,
                          AddressModel(
                            state: t3.text.trim(),
                            city: t2.text.trim(),
                            street: t1.text.trim(),
                            zipCode: t4.text.trim(),
                          ),
                        );
                      } else {
                        SnackBarWarning.showSnack(
                          "Please Enter all Fields",
                          context,
                        );
                      }
                    },
                    color: theme.primaryColor,
                    customText: CustomText(
                      text: "Save",
                      weight: FontWeight.w700,
                      size: 16,
                      color: theme.colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
