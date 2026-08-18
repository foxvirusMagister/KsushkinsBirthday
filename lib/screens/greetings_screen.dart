import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'dart:async';

String text1 = "Привет, Ксюша, поздравляю тебя с днём рождения, хочу пожелать тебе, чтобы каждый день начинался с улыбки, рядом были только добрые люди, а сердце всегда знало, куда идти. Пусть сбываются мечты — даже те, о которых ты ещё никому не рассказывала. Оставайся такой же яркой, доброй и невероятной. Желаю тебе море поводов для радости, океан любви и горы денег. Пусть проблемы обходят стороной, настроение будет как после отпуска, а подруги — всегда на связи. Желаю тебе не бояться быть собой, смело идти к своим целям и помнить, что ты способна на всё. Пусть этот год станет временем больших возможностей, приятных перемен и искреннего счастья. Я горжусь тобой и всегда поддержу! Ты лучшая, и точка!";
String text2 = "Yes";


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
  int page = 1;

  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){});
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
            setState((){
              capOpened = true;
            });
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

  Future<void> preloadImages() async
  {
    if (mounted)
    {
      final context = this.context;
      await precacheImage(const AssetImage("lib/Images/bottle.png"), context);
      await precacheImage(const AssetImage("lib/Images/bottleWithCap.png"), context);
      await precacheImage(const AssetImage("lib/Images/SandAndWater.webp"), context);
      await precacheImage(const AssetImage("lib/Images/BottleCap.png"), context);
      await precacheImage(const AssetImage("lib/Images/Papirus.png"), context);
    }
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
        Align(
          alignment: .topCenter,
          child: Text(
            "Потряси телефон что бы открыть бутылку",
            style: TextStyle(
              color: const Color.fromARGB(255, 7, 10, 36),
              fontFamily: "JulyMelt",
              fontSize: 24
            ),
            ),
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
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(0, 0, 0, 0)),
                      foregroundColor: WidgetStatePropertyAll(const Color.fromARGB(0, 0, 0, 0)),
                      elevation: WidgetStatePropertyAll(0),
                      shape: WidgetStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.zero)))
                    ),
                    onPressed: (){
                      setState(() {
                        page += 1;
                      });
                    },
                    child: Text(
                          page == 1 ? text1 : text2,
                          style: TextStyle(
                            fontFamily: "Kosmos",
                            fontSize: 18,
                            color: const Color.fromARGB(255, 46, 8, 30)
                          )
                        ),
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
