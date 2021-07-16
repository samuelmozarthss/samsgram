import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:samsgram/app/dark_theme.dart';

import 'light_theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Slidy',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
    ).modular();
  }
}