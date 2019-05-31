import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final Function onPressed;
  String text;

  BlueButton(this.text,Function this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: RaisedButton(
        color: Colors.greenAccent[400],
        onPressed: onPressed,
        padding: EdgeInsets.all(10),
        child: Text(text,style: TextStyle(fontSize: 36,color: Colors.white)),
      ),
    );
  }
}
