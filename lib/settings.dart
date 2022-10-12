import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 33, 34, 35),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Wyloguj",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              IconButton(
                  onPressed: () =>
                      Provider.of<MyProvider>(context, listen: false)
                          .logOut(context),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
