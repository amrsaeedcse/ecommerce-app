import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../animation/slidefadeanimation.dart';
import '../../../data/address/addressmodel.dart';
import '../../../getit/service_locator.dart';
import '../../../screens/information/address/editaddresspage.dart';
import '../../../widgets/customtext.dart';

class AddressListView extends StatefulWidget {
  final List<AddressModel> data;
  final bool use;
  final dynamic addressController;

  const AddressListView({
    super.key,
    required this.data,
    required this.use,
    this.addressController,
  });

  @override
  State<AddressListView> createState() => _AddressListViewState();
}

class _AddressListViewState extends State<AddressListView> {
  @override
  Widget build(BuildContext context) {
    return widget.data.isNotEmpty
        ? ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return SlideFadeAnimation(
                widget: Slidable(
                  key: UniqueKey(),
                  startActionPane: ActionPane(
                    dismissible: DismissiblePane(
                      onDismissed: () {
                        final FireBaseFireStore fireBaseFireStore =
                            getIt<FireBaseFireStore>();
                        final addressToRemove = widget.data[index];

                        // Remove from Firebase
                        fireBaseFireStore.removeAddress(
                          addressToRemove,
                          context,
                        );

                        // Use scheduler to remove from UI after current frame
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {
                              widget.data.removeAt(index);
                            });
                          }
                        });
                      },
                    ),
                    motion: StretchMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        autoClose: false,
                        onPressed: (context) async {
                          // تغلق السلايد بحركة الحذف
                          final controller = Slidable.of(context);
                          await controller?.dismiss(
                            ResizeRequest(const Duration(milliseconds: 300), () {
                              // بعد ما الأنيميشن يخلص، احذف العنصر من القائمة
                              final FireBaseFireStore fireBaseFireStore =
                                  getIt<FireBaseFireStore>();
                              final addressToRemove = widget.data[index];

                              // Remove from Firebase
                              fireBaseFireStore.removeAddress(
                                addressToRemove,
                                context,
                              );

                              // Use scheduler to remove from UI after current frame
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (mounted) {
                                  setState(() {
                                    widget.data.removeAt(index);
                                  });
                                }
                              });
                            }),
                          );
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        foregroundColor: Theme.of(context).colorScheme.surface,
                        label: "delete",
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Material(
                      color: Theme.of(context).colorScheme.onPrimary,
                      child: InkWell(
                        onTap: () {
                          if (widget.use && widget.addressController != null) {
                            widget.addressController.addressModel.value =
                                widget.data[index];
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: 72.h,
                          padding: EdgeInsets.only(left: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 248.w,
                                child: CustomText(
                                  text:
                                      '${widget.data[index].street}, ${widget.data[index].city}, ${widget.data[index].state} ${widget.data[index].zipCode}',
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
                                        addressModel: widget.data[index],
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
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemCount: widget.data.length,
          )
        : Center(
            child: CustomText(
              text: "no addresses",
              weight: FontWeight.w700,
              size: 17.sp,
              color: Theme.of(context).primaryColor,
            ),
          );
  }
}
