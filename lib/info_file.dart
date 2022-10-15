import 'package:flutter/material.dart';
import 'package:miastoerror/models.dart';
import 'package:miastoerror/provider.dart';
import 'package:provider/provider.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final DbPost post = ModalRoute.of(context)!.settings.arguments as DbPost;
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=${post.latitude},${post.longitude}";
    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);
    return Stack(
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Text(
                            post.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: ListView(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Text(post.description,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w300)),
                                )
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () => Navigator.pushNamed(
                                    context, "/map",
                                    arguments: [post.latitude, post.longitude]),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Przejdź do mapy",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                )),
                            if (Provider.of<MyProvider>(context).isAdmin)
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () => Provider.of<MyProvider>(
                                          context,
                                          listen: false)
                                      .deletePost(post, context),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Usuń",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 20)),
                                  ))
                          ],
                        )
                      ],
                    )),
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 34,
              )),
        ),
      ],
    );
  }
}
