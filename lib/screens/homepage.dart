import 'package:ecommerceapp/screens/notifications/notificationspage.dart';
import 'package:ecommerceapp/screens/sitting/sittingpage.dart';
import 'package:ecommerceapp/screens/themain4screens/page1.dart';
import 'package:ecommerceapp/screens/themain4screens/page2.dart';
import 'package:ecommerceapp/widgets/catogeriesscroll.dart';
import 'package:ecommerceapp/widgets/customappbar.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/homepagesearch.dart';
import 'package:ecommerceapp/widgets/productlist.dart';
import 'package:ecommerceapp/widgets/textrow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/navbartcontrol/nav_bar_control_cubit.dart';
import '../widgets/bottomnav.dart';
import '../widgets/gap.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> screens = [Page1(), NotificationsPage(), Page2(), SittingPage()];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<NavBarControlCubit, int>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            bottomNavigationBar: BottomNav(),
            backgroundColor: theme.colorScheme.surface,
            body: IndexedStack(index: state, children: screens),
          ),
        );
      },
    );
  }
}
