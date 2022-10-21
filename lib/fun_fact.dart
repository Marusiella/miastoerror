import 'dart:collection';

import 'package:flutter/material.dart';

class FunFact extends StatelessWidget {
  const FunFact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String type = ModalRoute.of(context)!.settings.arguments as String;
    return Container(
      color: const Color.fromARGB(255, 33, 34, 35),
      width: double.infinity,
      height: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
                  const Text("Fun Fact",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                          color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
