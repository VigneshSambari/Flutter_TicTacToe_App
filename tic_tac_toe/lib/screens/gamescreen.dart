// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/roomdataprovider.dart';
import 'package:tic_tac_toe/resources/socketmethods.dart';
import 'package:tic_tac_toe/utils/scoreboard.dart';
import 'package:tic_tac_toe/views/tictactoeboard.dart';
import 'package:tic_tac_toe/views/waitinglobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketMethods.updatePlayersState(context);
    socketMethods.updateRoomListener(context);
    socketMethods.pointIncreaseListener(context);
    socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    print(Provider.of<RoomDataProvider>(context).player1.name);
    print(Provider.of<RoomDataProvider>(context).player2.name);
    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ScoreBoard(),
                  TicTacToeBoard(),
                  Text(
                      '${roomDataProvider.roomData['turn']['nickname']}\'s turn'),
                ],
              ),
            ),
    );
  }
}
