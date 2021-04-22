import 'package:solarex/provider/google_sign_in.dart';
import 'package:flutter/material.dart';

class ProviderWidget extends InheritedWidget {
  final GoogleSignInProvider auth;
  final db;
  final colors;

  ProviderWidget({required Key key, required Widget child, required this.auth, this.db, this.colors}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static ProviderWidget of(BuildContext context) =>
  
      (context.dependOnInheritedWidgetOfExactType(aspect: ProviderWidget) as ProviderWidget);
}