import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'LandingPage.dart';
import 'ShowTheSignPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _ScanningPage createState() => _ScanningPage();
}

class _ScanningPage extends State<Home> {
  final picker = ImagePicker();
  late File _image;
  bool _loading = false;
  late List _output;


  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {});
  }

  @override
  void dispose() {
    Tflite.close();
    _loading = false;
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _output = output!;
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children:[Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.cyan, Colors.blueGrey])),
            ),Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10.0),
                    const SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: Image(
                        image: AssetImage('assets/logo/logo_transparent.png'),
                      ),
                    ),
                    Center(
                        child: Container(
                            decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            child: GlassContainer(
                                height: 400,
                                width: 300,
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(colors: [
                                  Colors.white.withOpacity(0.60),
                                  Colors.white.withOpacity(0.60)
                                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                borderGradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.70),
                                    Colors.white.withOpacity(0.20),
                                    Colors.lightBlueAccent.withOpacity(0.10),
                                    Colors.lightBlueAccent.withOpacity(0.12)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: const [0.0, 0.39, 0.40, 1.0],
                                ),
                                blur: 15.0,
                                borderWidth: 1.5,
                                elevation: 3.0,
                                isFrostedGlass: true,
                                shadowColor: Colors.black.withOpacity(0.20),
                                alignment: Alignment.center,
                                frostedOpacity: 0.2,
                                margin: const EdgeInsets.all(8.0),
                                padding: const EdgeInsets.all(8.0),

                                child: Column(
                                    children: [
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 30),

                                            GestureDetector(
                                              onTap: pickImage,
                                              child: Container(
                                                width: MediaQuery.of(context).size.width - 225,
                                                alignment: Alignment.center,
                                                padding:
                                                const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                                                decoration: BoxDecoration(
                                                  color: Colors.lightBlue[400],
                                                  borderRadius:  BorderRadius.circular(25.0),

                                                ),
                                                child:  Center(
                                                  child: Stack(
                                                    children:   [
                                                      const Icon(
                                                        Icons.camera_alt_sharp,
                                                        color: Colors.white,
                                                        size: 100,
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.fromLTRB(5,100, 0, 5),
                                                        child: const Text('Open Camera',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.bold,
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            GestureDetector(

                                              onTap: pickGalleryImage,
                                              child: Container(

                                                width: MediaQuery.of(context).size.width - 225,
                                                alignment: Alignment.center,
                                                padding:
                                                const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                                                decoration: BoxDecoration(
                                                  color: Colors.lightBlue[400],
                                                  borderRadius: BorderRadius.circular(25.0),
                                                ),
                                                child:  Center(
                                                  child: Stack(
                                                    children:   [
                                                      const Icon(
                                                        Icons.image_search,
                                                        color: Colors.white,
                                                        size: 100,
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.fromLTRB(5,100, 0, 5),
                                                        child: const Text('Use Gallery',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]
                                      )
                                    ]
                                )
                            )
                        )
                    )
                  ]
              ),
            )
        ])
    );
  }


}
