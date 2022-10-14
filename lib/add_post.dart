import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  late ImagePicker _picker;
  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    try {
      Provider.of<MyProvider>(context, listen: false).determinePosition();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please turn on location in settings"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 33, 34, 35),
      width: MediaQuery.of(context).size.width,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Dodawanie zgłoszenia",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.045,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
                color: Colors.white),
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () async {
              final pickedFile = await _picker.pickImage(
                  source: ImageSource.camera, imageQuality: 25);
              Provider.of<MyProvider>(context, listen: false)
                  .addImage(pickedFile!.path);
            },
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                Provider.of<MyProvider>(context).urlImage == ""
                    ? "Dodaj zdjęcie"
                    : "Ponów zdjęcie",
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              TextField(
                style: const TextStyle(color: Colors.white),
                maxLength: 30,
                decoration: const InputDecoration(
                  helperStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Tytuł',
                ),
                onChanged: (value) =>
                    Provider.of<MyProvider>(context, listen: false)
                        .setTitle(value),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextField(
                maxLength: 100,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  // color white of all
                  helperStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Opis',
                ),
                onChanged: (value) =>
                    Provider.of<MyProvider>(context, listen: false)
                        .setDescription(value),
              ),
            ],
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              if (Provider.of<MyProvider>(context, listen: false).urlImage !=
                      "" &&
                  Provider.of<MyProvider>(context, listen: false).title != "" &&
                  Provider.of<MyProvider>(context, listen: false).description !=
                      "") {
                Provider.of<MyProvider>(context, listen: false).addPost();
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Wypełnij wszystkie pola"),
                ));
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Dodaj",
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            )),
        if (Provider.of<MyProvider>(context).urlImage != "")
          Image.file(
            File(Provider.of<MyProvider>(context).urlImage),
            width: MediaQuery.of(context).size.height * 0.3,
          ),
      ]),
    );
  }
}
