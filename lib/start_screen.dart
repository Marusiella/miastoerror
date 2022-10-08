import 'package:flutter/material.dart';
import 'package:miastoerror/provider.dart';
import 'package:miastoerror/register_screen.dart';
import 'package:provider/provider.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MyProvider>(context, listen: false).ifSignedIn(context);
      print("init state");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: const Register());
  }
}
