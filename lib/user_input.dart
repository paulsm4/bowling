import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  final int _pinsStanding;
  final bool _gameOver;
  final Function(int) _doThrow;
  final VoidCallback _resetGame;
 
  UserInput(this._pinsStanding, this._gameOver, this._doThrow, this._resetGame);

  @override
  Widget build(BuildContext context) {
    if (!_gameOver) {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Text("Select #/pins down this throw"),
            ),
            ElevatedButton(
              child: Text("Reset Game"),
              onPressed: _resetGame),
          ]),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          child: Wrap(children: mkButtons(MediaQuery.of(context).orientation)),
        ),
      ]);
    } else {
      return Container(
        child: ElevatedButton(
          child: Text("Reset Game"),
          onPressed: _resetGame)
        );
    }
  }

  List<Widget> mkButtons(Orientation orientation) {
    // Set appropriate dimensions/attributes
    double? buttonWidth, font;
    if (orientation == Orientation.landscape) {
      buttonWidth = 45;
      font = 12;
    } else {
      buttonWidth = 35;
      font = 9;
    }
    var buttonStyle = ElevatedButton.styleFrom (
          textStyle: TextStyle(fontSize: font),
          primary:  Color(0xc0c0c0), // silver
          onPrimary: Colors.black,
    );

    // Generate a pushbutton for each standing pin
    List<Widget>buttons = [];
    for (int i=0; i <= _pinsStanding; i++) {
      buttons.add(SizedBox (
        width: buttonWidth,
        child: ElevatedButton(
          style: buttonStyle,
          child: Text((i).toString(), softWrap: false),
          onPressed: () => _doThrow(i)),
        ),
      );
    }

    // Return the "throw" buttons in a Row() widget
    return buttons;
  }
}