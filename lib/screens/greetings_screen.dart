import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'dart:async';

class Letter extends StatefulWidget // widget of loading screen
{
  const Letter({super.key});

  @override
  State<Letter> createState() => _Letter();
}

class _Letter extends State<Letter>
{

  double transparency = 1;
  double distance = 0;
  int _shakeCount = 0;
  late ShakeDetector _shakeDetector;
  bool capOpened = false;
  double bottleOpacity = 0;

  @override
  void initState()
  {
    super.initState();
    _shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: (event) {
        if (mounted)
        {
          setState(() {
            _shakeCount += 1;
          },);
          if (_shakeCount >= 3)
          {
            upplyTimers();
            _shakeDetector.stopListening();
          }
        }
      },
      shakeThresholdGravity: 2.4,
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500
    );
  }

  @override
  void dispose()
  {
    _shakeDetector.stopListening();
    super.dispose();
  }

  Future<void> upplyTimers() async
  {
    Timer.periodic(Duration(milliseconds: 25), (_timer){
      if (mounted && distance <= MediaQuery.of(context).size.height / 6)
      {
        setState(() {
        distance += 4;
        });
      }
      else
      {
        _timer.cancel();
        if (mounted)
        {
          setState(() {
            transparency = 0;
          });
        }
        Future.delayed(Duration(milliseconds: 1500), () async {showLetter();});
      }
    });
  }

  Future<void> showLetter() async
  {
    if (mounted)
    {
      setState(() {
        bottleOpacity = 1;
      },);
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Stack(
        fit: .expand,
        children: [
          Positioned.fill(
          child: Image.asset(
            "lib/Images/SandAndWater.webp",
            fit: .cover,
            alignment: .bottomCenter,
          ),
        ),
        Column(
          mainAxisAlignment: .end,
          spacing: distance,
          children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: transparency,
              child: capOpened ? Image.asset(
                "lib/Images/BottleCap.png",
                height: 50,
                width: 50,
                alignment: .bottomCenter,) : Text(" "),
            ),
            Image.asset(
              capOpened ? "lib/Images/bottle.png" : "lib/Images/bottleWithCap.png",
              height: 500,
              width: 1000),
          ],
        ),
        Positioned.fill(
          child: Center(
            child: AnimatedOpacity(
              opacity: bottleOpacity,
              duration: Duration(milliseconds: 500),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("lib/Images/Papirus.png",),
                  fit: .fill)
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Text(
                        "Привет мамочка! Я каждый день мечтал об этом слове, и вот он наконец, вспоминает об уходеее!",
                        style: TextStyle(
                          fontFamily: "Kosmos",
                          fontSize: 24,
                          color: const Color.fromARGB(255, 46, 8, 30)
                        )
                      ),
                )
              ),
            ),
          ),
        ),
        ]
      )
    );
  }
}
