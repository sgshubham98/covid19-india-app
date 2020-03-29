import 'package:flutter/material.dart';
import 'package:covid19_app/widgets/display_card.dart';
import 'package:covid19_app/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    this.modelData,
  });

  final modelData;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int confirmedDelta, deceasedDelta, recoveredDelta;
  int confirmed, deceased, recovered, active;
  String lastupdatedtime;

  @override
  void initState() {
    super.initState();
    updateUI(widget.modelData);
  }

  void updateUI(apiData) {
    setState(() {
      if (apiData == null) {
        confirmedDelta = -1;
        deceasedDelta = -1;
        active = -1;
        recoveredDelta = -1;
        confirmed = -1;
        deceased = -1;
        lastupdatedtime = 'Unable to get data';
        recovered = -1;
        return;
      }
      lastupdatedtime = apiData['key_values'][0]['lastupdatedtime'];
      confirmedDelta = int.parse(apiData['key_values'][0]['confirmeddelta']);
      deceasedDelta = int.parse(apiData['key_values'][0]['deceaseddelta']);
      recoveredDelta = int.parse(apiData['key_values'][0]['recovereddelta']);
      confirmed = int.parse(apiData['statewise'][0]['confirmed']);
      deceased = int.parse(apiData['statewise'][0]['deaths']);
      active = int.parse(apiData['statewise'][0]['active']);
      recovered = confirmed - active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'COVID-19 India',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Covid 19 Latest Update',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      // FlatButton(
                      //   child: Text(
                      //     'Details',
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 16.0,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Text(
                    'Last updated : $lastupdatedtime',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      DisplayCard(
                        value: confirmed,
                        delta: confirmedDelta,
                        text: 'INFECTED',
                        color: kConfirmedColor,
                        deltaColor: kConfirmedDeltaColor,
                        cardColor: kCardColor,
                      ),
                      DisplayCard(
                        value: recovered,
                        delta: recoveredDelta,
                        text: 'RECOVERED',
                        color: kRecoveredColor,
                        deltaColor: kRecoveredDeltaColor,
                        cardColor: kCardColor,
                      ),
                      DisplayCard(
                        value: deceased,
                        delta: deceasedDelta,
                        text: 'DEATHS',
                        color: kDeathColor,
                        deltaColor: kDeathDeltaColor,
                        cardColor: kCardColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
