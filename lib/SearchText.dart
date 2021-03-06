import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:teambetatech/ShowTheSignPage.dart';

import 'LandingPage.dart';


class SearchTextState extends StatefulWidget {
  const SearchTextState({Key? key}) : super(key: key);

  @override
  State<SearchTextState> createState() => SearchText();

}

class SearchText extends State<SearchTextState> {

  final nameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  //Scaffold used to implements the basic material design visual layout structure
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container( //Container  used to store more widgets and position it on the screen accordingly
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.cyan, Colors.blueGrey])),
            ),
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10.0),
                    Container(
                      width: 100.0,
                      height: 100.0,
                      child: const Image(
                        image: AssetImage('assets/logo/logo_transparent.png'), //image added
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
                              child: Column(children: [
                                const SizedBox(
                                  height: 100.0,
                                ),
                                SizedBox(
                                  width: 250.0,
                                  child:  TextField(
                                    controller: nameController,

                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Object Name',
                                    ),
                                  )


                                ),



                                const SizedBox(
                                  height: 20.00,
                                ),
                                RaisedButton(onPressed : (){

                                  var className = nameController.text;


                                  getSign(className);
                                  if (showPopup){
                                    showPopup = false;
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                        ),
                                        title: const Text("Error 404",
                                            textAlign: TextAlign.center),
                                        content: const Text("Ops! you scan an object out of our scope",
                                            textAlign: TextAlign.center),
                                        actions: <Widget>[
                                          Center(
                                            child: RaisedButton(
                                              color: Colors.lightBlue[400],
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25.0),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LandingPageState())); // navigate to the landing page

                                              },
                                              child: const Text("Home",
                                                  style: TextStyle(color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                  }else{
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            ShowTheSignState(classLabel:name)));
                                  }



                                  },
                                    color: Colors.lightBlue[400],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: const Text(
                                      "Search sign", //button text
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                ),
                              ]),
                            )))
                  ],
                ))
          ],
        ));
  }
}




late String name = "";
late bool showPopup = false;

// method check the inout is in the database
void getSign(object) {
  String classLabel = object.toLowerCase();
  var classes = ["airplane","apple","bag","bicycle","boat","brass","bread","bun","bus","car","cd","chicken","coconut","cricket","cup","desk","egg","father","female","fish","flower","food","football","frock","fruit","grass","knife","male","medicine","milk","motorbike","paper","pen","person","plate","rock","sand","saree","shirt","shoes","shorts","shower","slippers","socks","spoon","tea","television","threeWheeler","train","tree","trousers","underwear","van","vegetable","vest","volleyball","water"];

  if (classes.contains(classLabel)) {
    name = classLabel;
  } else {
    name = "";
    showPopup = true;
  }
}