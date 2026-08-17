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
          if (_shakeCount >= 10)
          {
            upplyTimers();
          }
        }
      },
      shakeThresholdGravity: 2.7,
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
      }
    });
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
              child: Image.asset(
                "lib/Images/BottleCap.png",
                height: 50,
                width: 50,
                alignment: .bottomCenter,),
            ),
            Image.asset(
              "lib/Images/bottle.png",
              height: 500,
              width: 1000),
            
          ],
        ),
        ]
      )
    );
  }
}
