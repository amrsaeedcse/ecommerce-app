import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

import 'package:ecommerceapp/animation/fadeanimation.dart';
import 'package:ecommerceapp/bloc/getprofileimage/get_profile_image_cubit.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhoto extends StatefulWidget {
  ProfilePhoto({super.key, required this.l, required this.editable});
  final double l;
  final bool editable;

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  final ImagePicker imagePicker = ImagePicker();
  Uint8List? theOldPic;

  Future getImage() async {
    XFile? imageXFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageXFile != null) {
      final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();
      String image = base64Encode(await imageXFile.readAsBytes());
      try {
        await fireBaseFireStore.addProfileImage(image);
        context.read<GetProfileImageCubit>().getImage();
      } catch (e) {
        print("erorr");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    context.read<GetProfileImageCubit>().getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<GetProfileImageCubit, GetProfileImageState>(
          builder: (context, getState) {
            if (getState is GetProfileImageLoading) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  ClipOval(
                    child: theOldPic == null
                        ? Image.network(
                            width: widget.l.w,
                            height: widget.l.h,
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                          )
                        : Image.memory(
                            width: widget.l.w,
                            height: widget.l.h,
                            theOldPic!,
                          ),
                  ),
                  CupertinoActivityIndicator(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ],
              );
            } else if (getState is GetProfileImageNoImage) {
              return ClipOval(
                child: Image.network(
                  width: widget.l.w,
                  height: widget.l.h,
                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                ),
              );
            } else if (getState is GetProfileImageFailure) {
              return ClipOval(
                child: Image.network(
                  width: widget.l.w,
                  height: widget.l.h,
                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                ),
              );
            }

            Uint8List file = base64Decode(
              (getState as GetProfileImageSuccess).image,
            );
            theOldPic = base64Decode((getState).image);

            return FadeAnimation(
              w: ClipOval(
                child: Image.memory(
                  width: widget.l.w,
                  height: widget.l.h,
                  file,
                ),
              ),
            );
          },
        ),
        // : ClipOval(
        //     child: Image.file(
        //       imageFile!,
        //       width: widget.l.w,
        //       height: widget.l.h,
        //     ),
        //   ),
        widget.editable
            ? Positioned(
                right: 0,
                bottom: 0,
                child: Material(
                  color: Theme.of(context).primaryColor,
                  shape: CircleBorder(),
                  child: InkWell(
                    customBorder: CircleBorder(),
                    onTap: getImage,
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Padding(
                        padding: EdgeInsets.all(1.0.r),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
