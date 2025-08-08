import 'package:ecommerceapp/bloc/getNotifications/get_notifications_cubit.dart';
import 'package:ecommerceapp/data/notifications/notificationsmodel.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/notificationslist.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<GetNotificationsCubit>().getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 71.0.h, horizontal: 24.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: CustomText(
                  text: "Notifications",
                  weight: FontWeight.w700,
                  size: 16.sp,
                ),
              ),
            ],
          ),
          Gap(40.h),
          Expanded(
            child: BlocBuilder<GetNotificationsCubit, GetNotificationsState>(
              builder: (context, state) {
                print("resatrere");
                if (state is GetNotificationsLoading) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                } else if (state is GetNotificationsFailure) {
                  SnackBarWarning.showSnack(
                    "error happened please restart or check your internet",
                    context,
                  );
                  return Center(
                    child: CupertinoActivityIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                } else if (state is GetNotificationsEmpty) {
                  return Center(
                    child: Lottie.asset("assets/lottie/No History.json"),
                  );
                }
                final List<NotificationsModel> data =
                    (state as GetNotificationsSuccess).data;
                return NotificationsList(data: data);
              },
            ),
          ),
        ],
      ),
    );
  }
}
