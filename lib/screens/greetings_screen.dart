import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

String text1 = "Привет, Ксюша, поздравляю тебя с днём рождения, хочу пожелать тебе, чтобы каждый день начинался с улыбки, рядом были только добрые люди, а сердце всегда знало, куда идти. Пусть сбываются мечты — даже те, о которых ты ещё никому не рассказывала. Оставайся такой же яркой, доброй и невероятной. Желаю тебе море поводов для радости, океан любви и горы денег. Пусть проблемы обходят стороной, настроение будет как после отпуска, а подруги — всегда на связи. Желаю тебе не бояться быть собой, смело идти к своим целям и помнить, что ты способна на всё. Пусть новая учеба станет временем больших возможностей, приятных перемен и искреннего счастья. Я горжусь тобой и всегда поддержу! Ты лучшая, и точка!(нажми что бы читать далее)";
String text2 = "В самом начале лета, я и не думал, что этим летом найду поистине потрясающую подругу, если бы тогда Богдан не решил бы позвать меня погулять с вами, я бы так и остался бы сидеть дома, не знаю что бы щас было со мной если бы я выбрал другой ответ на его сообщение. Когда я пришёл на место встречи, и не обнаружив Богдана и Милю уж было подумал что бы пойти поесть шаурмы, но решил посидеть подольше, так как каждую минуту ожидал что они прийдут, и тут я заметил что какая то красивая девушка села на соседнюю лавку, тогда я подумал: ого, кто то так же как и я пришёл первее всех, через какое то время я начал предполагать что ты и есть третий неизвестный человек, что будет гулять с нами (нажми для 3 страницы)";
String text3 = "Но я постеснялся просто так подойти узнать не ждёшь ли ты кого-то. После того как Богдан с Милей пришли, я подошёл к ним, и спросил не ты ли с нами тоже гуляешь, они ответили утвердительно, вот и так неловко мы познакомились. А теперь, спустя 47 дней, я пишу тебе цифровое письмо, в цифровом мире что создал что бы поздравить тебя, а так же рассказал тебе о себе то о чем боялся себе признаться. Ты очень приятный и интересный в общении человек, умеешь поддержать, умеешь слушать, умеешь задавать вопросы и интересоваться, я даже мечтать о таком не мог. Я надеюсь, тебе не тяжело живётся с таким титулом. Я очень рад, что встретил тебя и надеюсь что наше общение продолжится и дальше!. (как и в прошлый раз нажми)";
String text4 = "Это приложение получилось не таким большим как я хотел, надеюсь тебя это не расстраивает, идея создать программу открытку-письмо, пришла ко мне еще недели 2 назад, поскольку я подумал раз ты решила нарисовать всякие прикольные картинки, то и я сделаю подарок из того что мне нравится(и получается лучше), в тот момент я придумывал концепт, и начал разработку недели полторы назад, всё это время я создавал это небольшое приложение, после разговоров с ИИ, я пришёл к теме моря и тому что бы получить письмо тебе нужно потрясти телефон, разработка была не без трудностей, как минимум надо было вспоминать как это всё работает) Ну на этом вроде всё, долго затягивать это не буду. Спойлер по подарку далее если хочешь)))";
String text5 = "АГААААА! Бодро ты листнула) Ты думала что я так просто расскажу единственное ли это из того что я подготовил)00))))000???";


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
  final player = AudioPlayer();
  final soundPlayer = AudioPlayer();

  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){preloadImages();});
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
    player.dispose();
    soundPlayer.dispose();
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
      await precacheImage(const AssetImage("lib/Images/Papirus2.png"), context);

      await player.play(AssetSource("lib/Sounds/Ocean.mp3"), volume: 0.3);
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
        soundPlayer.play(AssetSource("lib/Sounds/cap.mp3"));
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Потряси телефон что бы открыть бутылку",
              style: TextStyle(
                color: const Color.fromARGB(255, 207, 212, 255),
                backgroundColor: const Color.fromARGB(96, 0, 0, 0),
                fontFamily: "JulyMelt",
                fontSize: 24
              ),
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
                  image: DecorationImage(image: page % 2 == 1 ? AssetImage("lib/Images/Papirus.png") : AssetImage("lib/Images/Papirus2.png"),
                  fit: .fill)
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(0, 0, 0, 0)),
                      foregroundColor: WidgetStatePropertyAll(const Color.fromARGB(0, 0, 0, 0)),
                      elevation: WidgetStatePropertyAll(0),
                      side: WidgetStatePropertyAll(BorderSide.none),
                      shape: WidgetStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.zero)))
                    ),
                    onPressed: (){
                      if (bottleOpacity == 1)
                      {
                        soundPlayer.play(AssetSource("lib/Sounds/page.mp3"));
                        setState(() {
                          page += 1;
                        });
                      }
                    },
                    child: Text(
                          page == 1 ? text1 : page == 2 ? text2 : page == 3 ? text3 : page == 4 ? text4 : text5,
                          style: TextStyle(
                            fontFamily: "Kosmos",
                            fontSize: 16,
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
