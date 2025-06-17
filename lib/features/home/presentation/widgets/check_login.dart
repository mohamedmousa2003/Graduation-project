import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/shared_pref.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../../../auth/presentation/pages/register_screen.dart';
import '../../../auth/presentation/pages/select_auth.dart';

void handleAuthNavigation({
  required BuildContext context,
  required WidgetBuilder destinationBuilder,
}) {
  final token = SharedPrefsService.getString("token");

  if (token != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: destinationBuilder),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Access Denied"),
        content: const Text("You must be logged in to view this place."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            child: const Text("Login"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RegisterScreen.routeName);
            },
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
