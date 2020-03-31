import 'package:flutter/material.dart';
import 'package:covid19_app/widgets/reuable_container_right.dart';
import 'package:covid19_app/widgets/reusable_container.dart';

class PrecautionsScreen extends StatefulWidget {
  @override
  _PrecautionsScreenState createState() => _PrecautionsScreenState();
}

class _PrecautionsScreenState extends State<PrecautionsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ReusableContainer(
                    imageName: 'stay_home',
                    left: 12.0,
                    bottom: 6.0,
                    content: 'dshjas',
                    imageHeight: height / 6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ReusableContainerRight(
                    right: 16.0,
                    bottom: 8.0,
                    imageName: 'social_distance',
                    imageHeight: height/5,
                    content: 'dshjas',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ReusableContainer(
                    imageName: 'crowd',
                    content: 'dshjas',
                    imageHeight: MediaQuery.of(context).size.height / 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ReusableContainerRight(
                    right: 16.0,
                    bottom: 8.0,
                    imageName: 'face_mask',
                    imageHeight: height/5,
                    content: 'dshjas',
                  ),
                ),
              ],
            ),
    );
  }
}