import 'package:flutter/material.dart';

class DisplayCard extends StatelessWidget {
  DisplayCard({
    @required this.value,
    this.delta,
    @required this.text,
    @required this.deltaColor,
    @required this.color,
    this.cardColor,
  });

  final String text;
  final int value;
  final String delta;
  final Color color;
  final Color deltaColor;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5.0,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              delta.toString(),
              style: TextStyle(
                fontSize: 14.0,
                color: deltaColor,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: deltaColor,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: cardColor,
      ),
    );
  }
}
