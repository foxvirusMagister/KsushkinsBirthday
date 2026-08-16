import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_screen/screens/greetings_screen.dart' as gs;
import 'package:loading_screen/Textures/grid_texture.dart' as gt;

class LoadingScreen extends StatefulWidget // widget of loading screen
{
  const LoadingScreen({super.key});


  @override
  State<LoadingScreen> createState() => _LoadingScreen();
}

class _LoadingScreen extends State<LoadingScreen>
{
  Color textColor = const Color.fromARGB(255, 0, 0, 255);
  String text = "ЗАГРУЗКА...";

  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){_loadingStart();});
  }

  Future<void> changeColors() async
    {
      Future.delayed(Duration(milliseconds: 500), ()async{
        if (mounted)
        {
          setState((){
            textColor = const Color.fromARGB(255, 255, 0, 0);
          });
        }
      });
      Future.delayed(Duration(milliseconds: 1000), ()async{
        if (mounted)
        {
          setState((){
            textColor = const Color.fromARGB(255, 0, 255, 0);
          });
        }
      });
      Future.delayed(Duration(milliseconds: 1500), ()async{
        if (mounted)
        {
          setState((){
            textColor = const Color.fromARGB(255, 0, 0, 255);
          });
        }
      });
    }

  Future<void> _loadingStart() async
  {
    changeColors();
    Timer.periodic(Duration(seconds: 1, milliseconds: 500), (timer){changeColors();});
    if (!mounted) {return;}
    Future.delayed(Duration(seconds: 2, milliseconds: 500), (){
      if (mounted)
      {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const gs.Letter()));
      }
      });
    
  }

  @override
  Widget build(BuildContext context)
  {
    
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 245, 245, 220),
        child: CustomPaint( // background
          painter: gt.GridPainter(
            cellSize: 250,
            lineColor1: Color.fromRGBO(255, 255, 255, 1),
            lineColor2: const Color.fromARGB(144, 0, 0, 0),
            lineWidth: 20,
            lengthBetweenBS: 1
          ),
          child: Column(
            mainAxisAlignment: .spaceEvenly,
            mainAxisSize: .max,
            children: [
              Center(
                child: AnimatedDefaultTextStyle(
                  style: TextStyle(color: textColor,
                  fontSize: 50,
                  fontFamily: "JulyMelt"),
                  duration: Duration(milliseconds: 500),
                  child: Text("ЗАГРУЗКА...")
                  ),
                ),
              Align(
              alignment: Alignment.centerLeft,
              child: LinearProgressIndicator(
                backgroundColor: Color.fromRGBO((180 * textColor.r).toInt(), (180 * textColor.g).toInt(), (180 * textColor.b).toInt(), 1),
                minHeight: 60,
                valueColor: AlwaysStoppedAnimation<Color>(textColor),
                
              ),
              //child: AnimatedContainer( // bar container
                //width: length,
                //height: 100, 
                //color: Color.fromARGB(255 - transparent, (255 * textColor.r).toInt(), (255 * textColor.g).toInt(), (255 * textColor.b).toInt()),
                //duration: Duration(seconds: durationOfAnim, milliseconds: durationOfAnimMilliseconds),
                //curve: Curves.easeInOut
              ),
            ],
          ),
        ),
      )
    );
  }
}


