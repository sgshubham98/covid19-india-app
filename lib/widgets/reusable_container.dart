import 'package:flutter/material.dart';
import 'package:covid19_app/utilities/constants.dart';

class ReusableContainer extends StatelessWidget {
  ReusableContainer({
    this.content,
    this.imageName,
    this.onTap,
    this.buttonText,
    this.imageHeight,
    this.left,
    this.bottom,
    this.right,
    this.top,
  });

  final String content;
  final String imageName;
  final String buttonText;
  final onTap;
  final double imageHeight;
  final double left, right, bottom, top;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: MediaQuery.of(context).size.height / 5.0,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      content,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.44,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      buttonText == null ? "" : buttonText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  )
                ],
              ),
            ),
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: kTitleColor,
            ),
          ),
        ),
        Positioned(
          left: left,
          bottom: bottom,
          right: right,
          top: top,
          child: Image(
            image: AssetImage('assets/images/$imageName.png'),
            height: imageHeight,
          ),
        ),
      ],
    );
  }
}
