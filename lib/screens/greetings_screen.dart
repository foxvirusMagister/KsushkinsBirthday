import 'dart:math';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget // widget of loading screen
{
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreen();
}

class _LoadingScreen extends State<LoadingScreen>
{
  double length = 0;
  int transparent = 0;
  

  @override
  Widget build(BuildContext context)
  {
    Size screenSize = MediaQuery.of(context).size;
    if(length < screenSize.width * 0.9) {appendBar(screenSize);} //async moving of bar
    else
    {
      if (length < screenSize.width)
      {
        appendBar(screenSize);
      }
      if (transparent < 255)
      {
        makeBarTransparent(); //transparency of bar
      }
    }
    return Scaffold(
      body: Container( // background
        color: Color.fromARGB(255, 255, 200, 200),
        child: Center(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container( // bar container
              width: length,
              height: 100, 
              color: Color.fromARGB(255 - transparent, 255, 255, 255)
            ),
          ),
        ),
      )
    );
  }
  Future<void> appendBar(Size screenSize) async
  {
    return Future.delayed(
      Duration(milliseconds: 12),
      () => setState((){
        double percent = Random().nextDouble() * 2;
        length += screenSize.width / 100 * percent;
        }));
  }

  Future<void> makeBarTransparent() async
  {
    return Future.delayed(Duration(milliseconds: 25),
    () => setState(() {
      if(transparent <= 235)
      {
        transparent += 10;
      }
      else
      {
        transparent = 255;
      }
      }));
  }
}
