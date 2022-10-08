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
              itemBuilder: (context, index) {
                return Container(
                  height: height * 0.1,
                  child: Row(
                    children: [
                      Container(
                        width: height * 0.1,
                        height: height * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: mediaQuery.size.height * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Description",
                            style: TextStyle(
                                fontSize: mediaQuery.size.height * 0.02,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Not implemented yet"),
                            ));
                          },
                          icon: const Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                );
              },
            ))
      ],
    );
  }
}
