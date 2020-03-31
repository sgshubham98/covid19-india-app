import 'package:flutter/material.dart';
import 'package:covid19_app/utilities/constants.dart';
import 'package:covid19_app/widgets/circle_card.dart';

class SymptomsScreen extends StatefulWidget {
  @override
  _SymptomsScreenState createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  @override
  Widget build(BuildContext context) {
    return /*MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'COVID-19 Symptoms',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: kTitleColor,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: kTitleColor,
                size: 32.0,
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
          ),
          body:*/ SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'The most common symptoms of coronavirus disease (COVID-19) are fever, tiredness, and dry cough. Most people (about 80%) recover from the disease without needing special treatment.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  '\n' +
                                      String.fromCharCode(0x2022) +
                                      ' People may be sick with the virus for 1 to 14 days before developing symptoms.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      CircleCard(
                        imageName: 'fever',
                      ),
                      SizedBox(width: 8.0),
                      CircleCard(
                        imageName: 'breath',
                      ),
                      SizedBox(width: 8.0),
                      CircleCard(
                        imageName: 'cough',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'When to Seek Medical Attention',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                                Text(
                                  '\nIf you develop emergency warning signs for COVID-19 get medical attention immediately. Emergency warning signs include*:',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '\n' +
                                      String.fromCharCode(0x2022) +
                                      ' Trouble breathing\n',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  String.fromCharCode(0x2022) +
                                      ' Persistent pain or pressure in the chest\n',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  String.fromCharCode(0x2022) +
                                      ' New confusion or inability to arouse\n',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  String.fromCharCode(0x2022) +
                                      ' Bluish lips or face\n',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '* This list is not all inclusive. Please consult your medical provider for any other symptoms that are severe or concerning.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ReusableContainer(
                //     imageName: 'fever',
                //     content: 'dshjas',
                //     imageHeight: MediaQuery.of(context).size.height / 5
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ReusableContainerRight(
                //     imageName: 'breath_mirror',
                //     content: 'dshjas',
                //     rotateAngle: 0.0,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ReusableContainer(
                //     imageName: 'cough',
                //     content: 'dshjas',
                //     imageHeight: MediaQuery.of(context).size.height / 5,
                //   ),
                // ),
              ],
            ),
      //     ),
      //   ),
      // ),
    );
  }
}
