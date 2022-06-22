// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/socketmethods.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/widgets/custombutton.dart';
import 'package:tic_tac_toe/widgets/customtext.dart';
import 'package:tic_tac_toe/widgets/customtextfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = "/join-room";
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gameIdController = TextEditingController();
  final SocketMethods socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    socketMethods.joinRoomSuccessListener(context);
    socketMethods.errorOccuredListener(context);
    socketMethods.updatePlayersState(context);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: ListView(shrinkWrap: true, children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  shadow: [
                    Shadow(
                      blurRadius: 25,
                      color: Colors.lightBlue,
                    ),
                  ],
                  text: "Join Room",
                  fontSize: 80,
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                CustomTextField(
                  controller: nameController,
                  hintText: "Enter your name",
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: gameIdController,
                  hintText: "Enter Game ID",
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                CustomButton(
                    onTap: () {
                      socketMethods.joinRoom(
                          nameController.text, gameIdController.text);
                    },
                    text: "Join Room")
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
