import 'package:flutter/material.dart';

class Letter extends StatefulWidget // widget of loading screen
{
  const Letter({super.key});

  @override
  State<Letter> createState() => _Letter();
}

class _Letter extends State<Letter>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(child: Text("ПОЗДРВРВРВ"),)
    );
  }
}
