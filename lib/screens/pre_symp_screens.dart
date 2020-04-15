import 'package:covid19_app/screens/precautions_screen.dart';
import 'package:covid19_app/screens/symptoms_screen.dart';
import 'package:covid19_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class PreSympScreen extends StatefulWidget {
  @override
  _PreSympScreenState createState() => _PreSympScreenState();
}

class _PreSympScreenState extends State<PreSympScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: kTitleColor,
            labelColor: kTitleColor,
            tabs: [
              Tab(
                text: 'Symptoms',
              ),
              Tab(
                text: 'Precautions',
              ),
              
            ],
          ),
          body: TabBarView(
            children: [
              SymptomsScreen(),
              PrecautionsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
