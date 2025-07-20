import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading {
  static void showAlertLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
            child: Center(
              child: CupertinoActivityIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
