import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class Presentation extends StatefulWidget {
  const Presentation({Key? key}) : super(key: key);

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MyProvider>(context, listen: false).ifSignedIn(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 33, 34, 35)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // SizedBox(
          //   height: MediaQuery.of(context).size.width * 0.1,
          // ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
            child: Image.asset(
              "assets/croped_dog.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8),
            child: const Text("Zgłaszaj błędy w swoim mieście.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500)),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.width * 0.08,
          // ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8),
            child: Text(
                "Twórz miasto wraz innymi pomagając urzędowi znajdować problemy życia codziennego.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withAlpha(128),
                    fontSize: 16,
                    fontFamily: "Roboto")),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.width * 0.2,
          // ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: const Text(
                      "Rejestracja",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    )),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white.withAlpha(89),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: const Text(
                      "Logowanie",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
