import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: BasePage(),
    );
  }
}

class BasePage extends StatefulWidget {
  const BasePage({
    Key? key,
  }) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  String imageUrl = "assets/bg_image.jpeg";
  double blurValue = 0;
  Color baseColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            height: double.maxFinite,
            width: double.maxFinite,
          ),
          Center(
            child: GlassMorphism(
              blur: blurValue,
              opacity: 0.2,
              color: baseColor,
              child: Container(
                width: 500,
                height: 300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "GlassMorphism",
                        style: TextStyle(
                          color: baseColor == Colors.black
                              ? Colors.white
                              : Colors.black,
                          fontSize: 36,
                        ),
                      ),
                      Text(
                        "%${blurValue.toInt()}",
                        style: TextStyle(
                          color: baseColor == Colors.black
                              ? Colors.white
                              : Colors.black,
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.179,
            top: MediaQuery.of(context).size.height * 0.225,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CupertinoButton(
                child: Text(
                  baseColor == Colors.black ? "White" : "Black",
                  style: TextStyle(
                    color:
                        baseColor == Colors.black ? Colors.white : Colors.black,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (baseColor == Colors.black) {
                      baseColor = Colors.white;
                    } else {
                      baseColor = Colors.black;
                    }
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GlassMorphism(
                blur: 100,
                opacity: 0.5,
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: CupertinoSlider(
                    value: blurValue,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        blurValue = value;
                      });
                    },
                    min: 0,
                    max: 100,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlassMorphism extends StatelessWidget {
  double blur;
  double opacity;
  Widget child;
  Color color;
  GlassMorphism(
      {Key? key,
      required this.blur,
      required this.opacity,
      required this.child,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(opacity),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
