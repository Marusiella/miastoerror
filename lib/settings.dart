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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.chevron_left_sharp,
                        color: Colors.white,
                      )),
                ),
                const Text("Settings",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        color: Colors.white)),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 33, 34, 35),
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
