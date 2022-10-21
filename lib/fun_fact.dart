import 'dart:collection';

import 'package:MiastoError/models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'main.dart';

class FunFact extends StatelessWidget {
  const FunFact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String type = ModalRoute.of(context)!.settings.arguments as String;
    FunFacts fact = FunFacts(theme: "", fact: "", links: []);
    for (var key in funFacts) {
      if (key.theme == type) {
        fact = key;
      }
    }
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              fact.fact,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                  color: Color.fromARGB(255, 247, 247, 247)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            for (var link in fact.links)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 33, 34, 35),
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.2,
                            vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () => launchUrlString(link),
                    child: const Text(
                      "Dowiedz się więcej",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),
          ],
        ),
      ),
    );
  }
}
