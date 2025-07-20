import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    required this.color,
    required this.customText,
    this.fun,
    this.icon,
  });
  final Color color;
  final Widget customText;
  final void Function()? fun;
  Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: fun != null
                    ? color
                    : Theme.of(context).colorScheme.onPrimary,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(40),
                ),
              ),
              onPressed: fun,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [customText],
                ),
              ),
            ),
          ),
        ),
        icon != null
            ? Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Align(alignment: Alignment.centerLeft, child: icon),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
