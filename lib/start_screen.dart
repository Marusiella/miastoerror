import 'package:flutter/material.dart';
import 'package:MiastoError/provider.dart';
import 'package:MiastoError/register_screen.dart';
import 'package:provider/provider.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return const Register();
  }
}
