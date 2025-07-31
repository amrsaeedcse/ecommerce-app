import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddOrRemove extends StatelessWidget {
  const AddOrRemove({super.key, required this.tap, required this.icon});
  final void Function() tap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      shape: CircleBorder(),
      child: InkWell(
        onTap: tap,
        customBorder: CircleBorder(),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          width: 24,
          height: 24,
          child: Center(
            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
