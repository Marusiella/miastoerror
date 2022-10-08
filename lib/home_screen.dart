import 'package:flutter/material.dart';
import 'package:miastoerror/provider.dart';
import 'package:miastoerror/select_city.dart';
import 'package:provider/provider.dart';

import 'list_of.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<MyProvider>(context).city == ""
        ? const SelectCity()
        : const ListHome();
  }
}
