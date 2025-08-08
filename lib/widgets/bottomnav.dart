import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/navbartcontrol/nav_bar_control_cubit.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarControlCubit, int>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: state,
          onTap: (index) {
            currIndex = index;
            context.read<NavBarControlCubit>().changeIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: _buildColoredIcon(
                "assets/images/icons/home2.svg",
                0,
                state,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: _buildColoredIcon(
                "assets/images/icons/notificationbing.svg",
                1,
                state,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: _buildColoredIcon(
                "assets/images/icons/receipt1.svg",
                2,
                state,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: _buildColoredIcon(
                "assets/images/icons/profile.svg",
                3,
                state,
              ),
              label: "",
            ),
          ],
        );
      },
    );
  }

  Widget _buildColoredIcon(String url, int index, int currentIndex) {
    return Padding(
      padding: EdgeInsets.only(top: 26.0.h, bottom: 10.h),
      child: SvgPicture.asset(
        url,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
        color: index == currentIndex
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
