import 'package:flutter/material.dart';
import 'package:miastoerror/main.dart';
import 'package:miastoerror/provider.dart';
import 'package:provider/provider.dart';

class SelectCity extends StatelessWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
              onPressed: () => Provider.of<MyProvider>(context, listen: false)
                  .logOut(context),
              child: const Text("Logout")),
          Column(
            children: city
                .map((e) => TextButton(
                    onPressed: () =>
                        Provider.of<MyProvider>(context, listen: false)
                            .setCity(e),
                    child: Text(upFirstLetter(e))))
                .toList(),
          ),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              child: const Text("Next")),
        ],
      ),
    );
  }
}

String upFirstLetter(String text) {
  return text[0].toUpperCase() + text.substring(1);
}
