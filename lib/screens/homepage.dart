import 'package:ecommerceapp/screens/themain4screens/page1.dart';
import 'package:ecommerceapp/widgets/catogeriesscroll.dart';
import 'package:ecommerceapp/widgets/customappbar.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/homepagesearch.dart';
import 'package:ecommerceapp/widgets/productlist.dart';
import 'package:ecommerceapp/widgets/textrow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/bottomnav.dart';
import '../widgets/gap.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int currIndex = 0;

  List<Widget> screens = [Page1(), Placeholder(), Placeholder(), Placeholder()];

  void setIndex(int index) {
    setState(() {
      currIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: BottomNav(fun: setIndex),
        backgroundColor: theme.colorScheme.surface,
        body: IndexedStack(index: currIndex, children: screens),
      ),
    );
  }
}
