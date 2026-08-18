import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_screen/screens/loading_screen.dart' as ls;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    .portraitUp
  ]);
  runApp(const MaterialApp(
    home: ls.LoadingScreen(),
  ));
}