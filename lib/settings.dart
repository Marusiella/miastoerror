import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IconButton(
              onPressed: () => Provider.of<MyProvider>(context, listen: false)
                  .logOut(context),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
