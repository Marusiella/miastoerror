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
    return Column(
      children: [
        SizedBox(
          height: height * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () => Navigator.pushNamed(context, "/add"),
                  icon: const Icon(Icons.add)),
              IconButton(
                  onPressed: () =>
                      Provider.of<MyProvider>(context, listen: false)
                          .logOut(context),
                  icon: const Icon(Icons.logout)),
              Text(
                upFirstLetter(Provider.of<MyProvider>(context).city),
                style: TextStyle(
                    fontSize: mediaQuery.size.height * 0.05,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Not implemented yet"),
                    ));
                  },
                  icon: const Icon(Icons.settings)),
            ],
          ),
        ),
        SizedBox(
            height: height * (1 - 0.2),
            child: ListView.builder(
              itemCount: Provider.of<MyProvider>(context).posts.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                    children: [
                      Text(
                        Provider.of<MyProvider>(context).posts[index].title,
                        style: TextStyle(
                            fontSize: mediaQuery.size.height * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ))
      ],
    );
  }
}
