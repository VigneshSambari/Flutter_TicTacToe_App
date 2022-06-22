// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/roomdataprovider.dart';
import 'package:tic_tac_toe/widgets/customtext.dart';
import 'package:tic_tac_toe/widgets/customtextfield.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({Key? key}) : super(key: key);

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController roomController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomController = TextEditingController(
      text:
          Provider.of<RoomDataProvider>(context, listen: false).roomData['_id'],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    roomController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Waiting for Player to Join"),
          SizedBox(
            height: 20,
          ),
          Text("Room Id:"),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: roomController,
            hintText: '',
            isReadOnly: true,
          )
        ],
      ),
    );
  }
}
