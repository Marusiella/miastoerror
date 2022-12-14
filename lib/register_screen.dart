import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(255, 33, 34, 35),
      child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                  alignment: Alignment.centerLeft,
                  child: const Text("Zarejestruj się.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                  child: Text(
                      "Dzięki tobie twoja okolica może wyglądać lepiej!",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white.withAlpha(209),
                          fontSize: 23,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w300)),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'example@example.com',
                            hintStyle: const TextStyle(color: Colors.white),
                            labelText: "Email",
                            labelStyle: const TextStyle(color: Colors.white),
                            errorText:
                                Provider.of<MyProvider>(context).error != ""
                                    ? Provider.of<MyProvider>(context,
                                            listen: false)
                                        .error
                                        .split("]")[1]
                                    : null
                            // input color white
                            ),
                        onChanged: (value) =>
                            Provider.of<MyProvider>(context, listen: false)
                                .setEmail(value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'strongpassword',
                            hintStyle: const TextStyle(color: Colors.white),
                            labelText: "Password",
                            labelStyle: const TextStyle(color: Colors.white),
                            errorText:
                                Provider.of<MyProvider>(context).error != ""
                                    ? Provider.of<MyProvider>(context,
                                            listen: false)
                                        .error
                                        .split("]")[1]
                                    : null
                            // input color white
                            ),
                        onChanged: (value) =>
                            Provider.of<MyProvider>(context, listen: false)
                                .setPassword(value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Masz już konto?",
                      style: TextStyle(
                          fontSize: 18, color: Colors.white.withAlpha(209)),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                          Provider.of<MyProvider>(context, listen: false)
                              .error = "";
                        },
                        child: const Text(
                          "Zaloguj się!",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ))
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.28,
                              vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () =>
                          Provider.of<MyProvider>(context, listen: false)
                              .singUp(context),
                      child: Provider.of<MyProvider>(context).isLoaded
                          ? const Text(
                              "Zarejestruj",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.black,
                            )),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () =>
                          Provider.of<MyProvider>(context, listen: false)
                              .signUpGoogle(context),
                      child: Provider.of<MyProvider>(context).isLoaded
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                    width: 30,
                                    "https://pngimg.com/uploads/google/google_PNG19635.png"),
                                const Text(
                                  "Zarejestruj przez Google",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                              ],
                            )
                          : const CircularProgressIndicator(
                              color: Colors.black,
                            )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
