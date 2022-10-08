import 'package:flutter/material.dart';
import 'package:miastoerror/provider.dart';
import 'package:miastoerror/select_city.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Provider.of<MyProvider>(context).city == ""
          ? const SelectCity()
          : Text("ssss"),
    );
  }
}
