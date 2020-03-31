import 'package:flutter/material.dart';
import 'package:covid19_app/utilities/constants.dart';

class CircleCard extends StatelessWidget {
  const CircleCard({
    @required this.imageName,
  });

  final imageName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width / 8),
          color: kTitleColor,
          image: DecorationImage(
            image: AssetImage('assets/images/$imageName.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: MediaQuery.of(context).size.width / 6),
      ),
    );
  }
}
