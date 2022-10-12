import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miastoerror/models.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final DbPost post = ModalRoute.of(context)!.settings.arguments as DbPost;
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=${post.latitude},${post.longitude}";
    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    return Container(
        child: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: Image.network(
            post.uidOfImage,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 33, 34, 35),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          post.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            post.description,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        TextButton(
                          child: const Text("Uruchom mapy"),
                          onPressed: () async {
                            Navigator.pushNamed(context, "/map",
                                arguments: [post.latitude, post.longitude]);
                          },
                        ),
                      ],
                    )),
              ],
            )),
      ],
    ));
  }
}
