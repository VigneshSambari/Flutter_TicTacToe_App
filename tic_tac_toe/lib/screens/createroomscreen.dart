// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/socketmethods.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/widgets/custombutton.dart';
import 'package:tic_tac_toe/widgets/customtext.dart';
import 'package:tic_tac_toe/widgets/customtextfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = "/creates-room";
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController nameControl = TextEditingController();
  final SocketMethods socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                shadow: [Shadow(blurRadius: 25, color: Colors.lightBlue)],
                text: "Create Room",
                fontSize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                controller: nameControl,
                hintText: "Enter your name",
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                  onTap: () {
                    socketMethods.createRoom(nameControl.text);
                  },
                  text: "Create Room")
            ],
          ),
        ),
      ),
    );
  }
}
