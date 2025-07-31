import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, required this.fun});
  final void Function(int index) fun;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        widget.fun(index);
        setState(() {
          currIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: _buildColoredIcon("assets/images/icons/home2.svg", 0),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildColoredIcon(
            "assets/images/icons/notificationbing.svg",
            1,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildColoredIcon("assets/images/icons/receipt1.svg", 2),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: _buildColoredIcon("assets/images/icons/profile.svg", 3),
          label: "",
        ),
      ],
    );
  }

  Widget _buildColoredIcon(String url, index) {
    return Padding(
      padding: EdgeInsets.only(top: 26.0.h, bottom: 10.h),
      child: SvgPicture.asset(
        width: 24,
        height: 24,
        fit: BoxFit.contain,
        url,
        color: index == currIndex
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
