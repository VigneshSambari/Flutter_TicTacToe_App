// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/provider/roomdataprovider.dart';
import 'package:tic_tac_toe/resources/gamemethods.dart';
import 'package:tic_tac_toe/resources/socketclient.dart';
import 'package:tic_tac_toe/screens/gamescreen.dart';
import 'package:tic_tac_toe/utils/utils.dart';

class SocketMethods {
  final _socketFunctions = SocketClient.instance.socket!;
  Socket get socketClient => _socketFunctions;

  //emits
  void createRoom(String name) {
    if (name.isNotEmpty) {
      _socketFunctions.emit('createRoom', {
        'name': name,
      });
    }
  }

  void joinRoom(String name, String roomId) {
    if (name.isNotEmpty && roomId.isNotEmpty) {
      socketClient.emit('joinRoom', {
        'nickname': name,
        'roomId': roomId,
      });
    }
  }

  void taponGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketFunctions.emit(
        'tap',
        {
          'index': index,
          'roomId': roomId,
        },
      );
    }
  }

  void tapListen(BuildContext context) {
    _socketFunctions.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(data['index'], data['choice']);
      roomDataProvider.updateRoomData(data['room']);

      GameMethods().checkWinner(context, _socketFunctions);
    });
  }

  //listeners
  void createRoomSuccessListener(BuildContext context) {
    _socketFunctions.on('createRoomSuccess', (room) {
      //print(room);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketFunctions.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketFunctions.on('errorOccured', (data) {
      showSnackBar(context, data);
    });
  }

  void updateRoomListener(BuildContext context) {
    print("Inside update room");
    _socketFunctions.on("updateRoom", (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void updatePlayersState(BuildContext context) {
    _socketFunctions.on("updatePlayers", (playerData) {
      print("Inside update player1&2");
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
        playerData[0],
      );
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
        playerData[1],
      );
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketFunctions.on('pointIncrease', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketFunctions.on('endGame', (playerData) {
      showDialogGame(context, '${playerData['nickname']} won the game!');
      Navigator.popUntil(context, (route) => false);
    });
  }
}
