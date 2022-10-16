import 'package:flutter/material.dart';
import 'package:MiastoError/provider.dart';
import 'package:MiastoError/select_city.dart';
import 'package:provider/provider.dart';

class ListHome extends StatelessWidget {
  const ListHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    //get safearea height
    var height = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
    return Container(
      color: const Color.fromARGB(255, 33, 34, 35),
      child: Stack(children: [
        Column(
          children: [
            SizedBox(
              height: height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pushNamed(context, "/map"),
                      icon: const Icon(
                        Icons.map,
                        color: Colors.white,
                      )),
                  Text(
                    upFirstLetter(Provider.of<MyProvider>(context).city),
                    style: TextStyle(
                        fontSize: mediaQuery.size.height * 0.05,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, "/settings"),
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            SizedBox(
                height: height * (1 - 0.17) + height * 0.03,
                child: RefreshIndicator(
                  onRefresh: () =>
                      Provider.of<MyProvider>(context, listen: false)
                          .getPostNow(),
                  child: ListView.builder(
                    itemCount: Provider.of<MyProvider>(context).posts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.pushNamed(context, "/info",
                            arguments:
                                Provider.of<MyProvider>(context, listen: false)
                                    .posts[index]),
                        child: SizedBox(
                          height: height * 0.17,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 10, top: 10, bottom: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: height * 0.15,
                                    width: height * 0.14,
                                    child: Image.network(
                                      Provider.of<MyProvider>(context)
                                          .posts[index]
                                          .uidOfImage,
                                      // height: height * 0.2,
                                      fit: BoxFit.cover,
                                      // width: height * 0.2,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ifTooLongShort(
                                          Provider.of<MyProvider>(context)
                                              .posts[index]
                                              .title,
                                          shorter: true),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:
                                              mediaQuery.size.height * 0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.45,
                                      child: Text(
                                        ifTooLongShort(
                                            Provider.of<MyProvider>(context)
                                                .posts[index]
                                                .description),
                                        style: TextStyle(
                                            fontSize:
                                                mediaQuery.size.height * 0.025,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white70),
                                      ),
                                    ),
                                    Text(
                                      Provider.of<MyProvider>(context,
                                              listen: true)
                                          .calculateScore(
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .posts[index])
                                          .toString(),
                                      style: TextStyle(
                                          color: (Provider.of<MyProvider>(
                                                          context,
                                                          listen: false)
                                                      .calculateScore(Provider
                                                              .of<MyProvider>(
                                                                  context,
                                                                  listen: false)
                                                          .posts[index]) <=
                                                  0
                                              ? const Color.fromARGB(
                                                  255, 255, 122, 122)
                                              : const Color.fromARGB(
                                                  255, 189, 255, 151)),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: height - (height * 0.17),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.15,
                            vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () => Navigator.pushNamed(context, "/add"),
                    child: const Text(
                      "Zgłoś",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    )),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}

String ifTooLongShort(String text, {bool shorter = false}) {
  if (text.length > 20) {
    if (shorter) {
      return "${text.substring(0, 13)}...";
    } else {
      return "${text.substring(0, 19)}...";
    }
  } else {
    return text;
  }
}
