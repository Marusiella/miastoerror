import 'package:flutter/material.dart';
import 'package:miastoerror/provider.dart';
import 'package:miastoerror/select_city.dart';
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
      child: Column(
        children: [
          SizedBox(
            height: height * 0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () =>
                        Provider.of<MyProvider>(context, listen: false)
                            .logOut(context),
                    icon: const Icon(
                      Icons.logout,
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
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Not implemented yet"),
                      ));
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          SizedBox(
              height: height * (1 - 0.24),
              child: RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<MyProvider>(context, listen: false)
                      .getPostNow();
                },
                child: ListView.builder(
                  itemCount: Provider.of<MyProvider>(context).posts.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: height * 0.2,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 10, top: 10, bottom: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: height * 0.2,
                                width: height * 0.17,
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
                              children: [
                                Text(
                                  Provider.of<MyProvider>(context)
                                      .posts[index]
                                      .title,
                                  style: TextStyle(
                                      fontSize: mediaQuery.size.height * 0.03,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )),
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.15,
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
    );
  }
}

String ifTooLongShort(String text) {
  if (text.length > 100) {
    return "${text.substring(0, 20)}...";
  } else {
    return text;
  }
}
