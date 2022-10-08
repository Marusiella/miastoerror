import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Register screen"),
          Text("Already have an account?"),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text("Login"),
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
                        .singUp(context);
                  },
                  child: const Text("Sign up"),
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
