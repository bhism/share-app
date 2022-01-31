import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? file;
  List<String> images = [];
  ImagePicker image = ImagePicker();
  final TextEditingController emailController = new TextEditingController();
  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      images.add(img.path);
    });
  }

  void share(BuildContext context) async {
    if (file != null) {
      await Share.shareFiles(
        images,
        text: emailController.text,
      );
    } else {
      await Share.share(
        emailController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'share app',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'WEBFUN',
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  color: Colors.black12,
                  child: file == null
                      ? IconButton(
                          onPressed: () {
                            getImage();
                          },
                          icon: Icon(
                            Icons.add,
                          ),
                        )
                      : Image.file(
                          file!,
                          fit: BoxFit.fill,
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Text',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    share(context);
                  },
                  color: Colors.red,
                  child: Text(
                    'Share >',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
