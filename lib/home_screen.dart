import 'package:flutter/material.dart';
import 'package:miastoerror/select_city.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SelectCity(),
    );
  }
}
