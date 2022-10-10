import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Login screen"),
          Text("Don't have an account?"),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/register');
            },
            child: const Text("Register"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  onChanged: (value) =>
                      Provider.of<MyProvider>(context, listen: false)
                          .setEmail(value),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (value) =>
                      Provider.of<MyProvider>(context, listen: false)
                          .setPassword(value),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<MyProvider>(context, listen: false)
                        .signIn(context);
                  },
                  child: const Text("Sign in"),
                ),
                Text(Provider.of<MyProvider>(context).error)
              ],
            ),
          )
        ],
      ),
    );
  }
}
