import 'package:flutter/material.dart';
import 'package:covid19_app/widgets/display_card.dart';
import 'package:covid19_app/utilities/constants.dart';
import 'package:covid19_app/services/data_model.dart';
import 'package:covid19_app/screens/state_wise.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:bezier_chart/bezier_chart.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    this.modelData,
  });

  final modelData;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataModel model = new DataModel();

  final fromDate = DateTime(2020, 01, 30);
  final toDate = DateTime.now().subtract(Duration(days: 1));
  int currentIndex = 0;

  List caseTimeSeries;
  List<DataPoint<DateTime>> chartList;

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
      caseTimeSeries = [];
      chartList = [];
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
      recovered = confirmed - active - deceased;
      caseTimeSeries = apiData['cases_time_series'];
      for (int i = 0; i < caseTimeSeries.length; i++) {
        chartList.add(
          DataPoint<DateTime>(
            value: double.parse(caseTimeSeries[i]['totalconfirmed']) -
                double.parse(caseTimeSeries[i]['totaldeceased']) -
                double.parse(caseTimeSeries[i]['totalrecovered']),
            xAxis: DateTime(2020, 01, 30).add(Duration(days: i)),
          ),
        );
      }

      print(chartList);
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'COVID-19 India',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: kTitleColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 5.0,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Text(
                                    'Symptoms of COVID-19',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.44,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  child: Text(
                                    'Tap to know more',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => StateScreen(
                                              stateData: widget.modelData),
                                        ),
                                      );
                                    });
                                  },
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
                        Positioned(
                          left: 2,
                          bottom: 2,
                          child: Transform.rotate(
                            angle: 0.0,
                            child: Image(
                              image:
                                  AssetImage('assets/images/coronavirus.png'),
                              height: MediaQuery.of(context).size.height / 7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Covid 19 Latest Update',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: kTitleColor),
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.refresh,
                            color: kTitleColor,
                          ),
                          onTap: () async {
                            var apiData = await model.getApiData();
                            updateUI(apiData);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      'Last updated : $lastupdatedtime',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      DisplayCard(
                        value: confirmed,
                        delta: confirmedDelta,
                        text: 'INFECTED',
                        color: kConfirmedColor,
                        deltaColor: kConfirmedDeltaColor,
                        cardColor: kConfirmedCardColor,
                      ),
                      DisplayCard(
                        value: recovered,
                        delta: recoveredDelta,
                        text: 'RECOVERED',
                        color: kRecoveredColor,
                        deltaColor: kRecoveredDeltaColor,
                        cardColor: kRecoveredCardColor,
                      ),
                      DisplayCard(
                        value: deceased,
                        delta: deceasedDelta,
                        text: 'DEATHS',
                        color: kDeathColor,
                        deltaColor: kDeathDeltaColor,
                        cardColor: kDeathCardColor,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Active Cases',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: kTitleColor,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: BezierChart(
                        fromDate: fromDate,
                        bezierChartScale: BezierChartScale.WEEKLY,
                        toDate: toDate,
                        selectedDate: toDate,
                        series: [
                          BezierLine(
                            lineColor: kTitleColor,
                            lineStrokeWidth: 2.0,
                            // label: 'active',
                            data: chartList,
                          ),
                        ],
                        config: BezierChartConfig(
                          bubbleIndicatorColor: kTitleColor,
                          bubbleIndicatorValueStyle: TextStyle(
                            color: Colors.white,
                          ),
                          bubbleIndicatorLabelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          bubbleIndicatorTitleStyle: TextStyle(
                            color: Colors.white,
                          ),
                          snap: false,
                          pinchZoom: true,
                          showVerticalIndicator: false,
                          showDataPoints: true,
                          backgroundColor: kChartBackgroundColor,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // bottomNavigationBar: BottomNavyBar(
        //   selectedIndex: currentIndex,
        //   showElevation: true,
        //   itemCornerRadius: 20.0,
        //   curve: Curves.easeInBack,
        //   onItemSelected: (index) => setState(() {
        //     currentIndex = index;
        //   }),
        //   items: [
        //     BottomNavyBarItem(
        //       icon: Icon(Icons.apps),
        //       title: Text('Home'),
        //       activeColor: Colors.red,
        //       textAlign: TextAlign.center,
        //     ),
        //     BottomNavyBarItem(
        //       icon: Icon(Icons.people),
        //       title: Text('Users'),
        //       activeColor: Colors.purpleAccent,
        //       textAlign: TextAlign.center,
        //     ),
        //     BottomNavyBarItem(
        //       icon: Icon(Icons.message),
        //       title: Text(
        //         'Messages',
        //       ),
        //       activeColor: Colors.pink,
        //       textAlign: TextAlign.center,
        //     ),
        //     BottomNavyBarItem(
        //       icon: Icon(Icons.settings),
        //       title: Text('Settings'),
        //       activeColor: Colors.blue,
        //       textAlign: TextAlign.center,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
