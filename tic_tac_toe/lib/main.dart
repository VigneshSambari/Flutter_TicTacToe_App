// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/roomdataprovider.dart';
import 'package:tic_tac_toe/screens/createroomscreen.dart';
import 'package:tic_tac_toe/screens/gamescreen.dart';
import 'package:tic_tac_toe/screens/joinroomscreen.dart';
import 'package:tic_tac_toe/screens/mainmenu.dart';
import 'package:tic_tac_toe/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TicTacToe",
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MainMenu.routeName: (context) => MainMenu(),
          JoinRoomScreen.routeName: (context) => JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => CreateRoomScreen(),
          GameScreen.routeName: (context) => GameScreen(),
        },
        initialRoute: MainMenu.routeName,
      ),
    );
  }
}
