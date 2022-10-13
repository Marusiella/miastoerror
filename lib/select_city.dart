import 'package:flutter/material.dart';
import 'package:miastoerror/main.dart';
import 'package:miastoerror/provider.dart';
import 'package:provider/provider.dart';

class SelectCity extends StatelessWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 33, 34, 35),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Wybierz miasto",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.045,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
                color: Colors.white),
          ),
          Column(
            children: city
                .map((e) => TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Provider.of<MyProvider>(context, listen: false)
                          .setCity(e);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        upFirstLetter(e),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            fontFamily: "Roboto",
                            color: Colors.black),
                      ),
                    )))
                .toList(),
          ),
        ],
      ),
    );
  }
}

String upFirstLetter(String text) {
  try {
    return text[0].toUpperCase() + text.substring(1);
  } catch (_) {
    return text;
  }
  // return text[0].toUpperCase() + text.substring(1);
}
