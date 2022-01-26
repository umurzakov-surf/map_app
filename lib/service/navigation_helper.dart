import 'package:flutter/cupertino.dart';

class NavigationHelper {
  void push(BuildContext context, Route route) {
    Navigator.of(context).push<void>(route);
  }

  void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
