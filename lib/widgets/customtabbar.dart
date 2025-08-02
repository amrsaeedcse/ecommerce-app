import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'customtab.dart';

class CustomTabBar extends StatefulWidget {
  CustomTabBar({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      child: TabBar(
        onTap: (value) {
          widget.pageController.animateToPage(
            value,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        },
        controller: tabController,
        isScrollable: true,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsetsGeometry.only(right: 13.w),
        physics: BouncingScrollPhysics(),
        tabAlignment: TabAlignment.start,
        indicator: BoxDecoration(color: Colors.transparent),
        tabs: [
          Tab(child: CustomTab(text: "Processing")),
          Tab(child: CustomTab(text: "Shipped")),
          Tab(child: CustomTab(text: "Delivered")),
          Tab(child: CustomTab(text: "Returned")),
          Tab(child: CustomTab(text: "Canceled")),
        ],
      ),
    );
  }
}
