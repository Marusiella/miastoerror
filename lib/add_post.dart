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
    // TODO: implement initState
    super.initState();
    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text("Dodawanie zgłoszenia"),
        if (Provider.of<MyProvider>(context).urlImage != "")
          Image.file(
            File(Provider.of<MyProvider>(context).urlImage),
            width: 200,
          ),
        TextButton(
            onPressed: () async {
              final pickedFile =
                  await _picker.pickImage(source: ImageSource.camera);
              Provider.of<MyProvider>(context, listen: false)
                  .addImage(pickedFile!.path);
            },
            child: Text(Provider.of<MyProvider>(context).urlImage == ""
                ? "Dodaj zdjęcie"
                : "Ponów zdjęcie")),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Tytuł',
          ),
          onChanged: (value) =>
              Provider.of<MyProvider>(context, listen: false).setTitle(value),
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Opis',
          ),
          onChanged: (value) => Provider.of<MyProvider>(context, listen: false)
              .setDescription(value),
        ),
        TextButton(
            onPressed: () {
              if (Provider.of<MyProvider>(context, listen: false).urlImage !=
                      "" &&
                  Provider.of<MyProvider>(context, listen: false).title != "" &&
                  Provider.of<MyProvider>(context, listen: false).description !=
                      "") {
                Provider.of<MyProvider>(context, listen: false).addPost();
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Wypełnij wszystkie pola"),
                ));
              }
            },
            child: const Text("Dodaj"))
      ]),
    );
  }
}
