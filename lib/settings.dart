import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 33, 34, 35),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.28,
                      vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () => Provider.of<MyProvider>(context, listen: false)
                  .logOut(context),
              child: const Text(
                "Wyloguj mnie",
                style: TextStyle(color: Colors.red, fontSize: 17),
              )),
        ],
      ),
    );
  }
}
