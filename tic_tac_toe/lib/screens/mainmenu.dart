// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/screens/createroomscreen.dart';
import 'package:tic_tac_toe/screens/joinroomscreen.dart';
import 'package:tic_tac_toe/widgets/custombutton.dart';

class MainMenu extends StatefulWidget {
  static String routeName = "/main-menu";
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  onTap: () {
                    createRoom(context);
                  },
                  text: "Create Room"),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  onTap: () {
                    joinRoom(context);
                  },
                  text: "Join Room")
            ],
          ),
        ),
      ),
    );
  }
}
