import 'package:covid19_app/screens/precautions_screen.dart';
import 'package:covid19_app/screens/symptoms_screen.dart';
import 'package:covid19_app/widgets/reusable_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/widgets/display_card.dart';
import 'package:covid19_app/utilities/constants.dart';
import 'package:covid19_app/services/data_model.dart';
import 'package:covid19_app/screens/state_wise.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    this.modelData,
  });

  final modelData;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  DataModel model = new DataModel();

  final fromDate = DateTime(2020, 01, 30);
  final toDate = DateTime.now().subtract(Duration(days: 1));
  DateTime now;
  int currentIndex = 0;
  final List<Widget> page = [
    HomeScreen(),
    StateScreen(),
    SymptomsScreen(),
  ];

  List caseTimeSeries, totalConfirmedList, totalRecoveredList, totalDeathsList;
  List<DataPoint<DateTime>> chartList;

  int confirmedDelta, deceasedDelta, recoveredDelta;
  int confirmed, deceased, recovered, active;
  String lastupdatedtime, currentTime;

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    updateUI(widget.modelData);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void updateUI(apiData) {
    setState(() {
      animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
      )..addListener(() => setState(() {}));
      currentTime = null;
      now = DateTime.now();
      caseTimeSeries = [];
      totalConfirmedList = [];
      chartList = [];
      totalDeathsList = [];
      totalRecoveredList = [];
      animation = null;
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
      currentTime = DateFormat.jm().format(now);
      /* Overall data */
      lastupdatedtime = apiData['statewise'][0]['lastupdatedtime'].substring(0, 10) + ' ';
      lastupdatedtime += currentTime;
      confirmedDelta = int.parse(apiData['statewise'][0]['deltaconfirmed']);
      deceasedDelta = int.parse(apiData['statewise'][0]['deltadeaths']);
      recoveredDelta = int.parse(apiData['statewise'][0]['deltarecovered']);
      confirmed = int.parse(apiData['statewise'][0]['confirmed']);
      deceased = int.parse(apiData['statewise'][0]['deaths']);
      active = int.parse(apiData['statewise'][0]['active']);
      recovered = confirmed - active - deceased;
      /* Overall data ends */
      
      /* Data for chart */
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
        totalConfirmedList.add(int.parse(caseTimeSeries[i]['totalconfirmed']));
        totalDeathsList.add(int.parse(caseTimeSeries[i]['totaldeceased']));
        totalRecoveredList.add(int.parse(caseTimeSeries[i]['totalrecovered']));
      }
      /* Data for chart ends */
      
      animation = CurvedAnimation(
        parent: animationController,
        curve: Curves.ease,
      );
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: kAppBarTitle,
          ),
          body: currentIndex == 0
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.0,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
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
                                      GestureDetector(
                                        child: Container(
                                          child: Text(
                                            'Tap to know more',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            currentIndex = 2;
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
                                left: 4,
                                bottom: 4,
                                child: Transform.rotate(
                                  angle: 0.0,
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/coronavirus.png'),
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
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
                                child: RotationTransition(
                                  turns: animation,
                                  child: Icon(
                                    Icons.refresh,
                                    color: kTitleColor,
                                  ),
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
                              delta: (confirmed >=
                                          totalConfirmedList[
                                              totalConfirmedList.length - 1]
                                      ? '+'
                                      : '-') +
                                  confirmedDelta.toString(),
                              text: 'INFECTED',
                              color: kConfirmedColor,
                              deltaColor: kConfirmedDeltaColor,
                              cardColor: kConfirmedCardColor,
                            ),
                            DisplayCard(
                              value: recovered,
                              delta: (recovered >=
                                          totalRecoveredList[
                                              totalRecoveredList.length - 1]
                                      ? '+'
                                      : '-') +
                                  recoveredDelta.toString(),
                              text: 'RECOVERY',
                              color: kRecoveredColor,
                              deltaColor: kRecoveredDeltaColor,
                              cardColor: kRecoveredCardColor,
                            ),
                            DisplayCard(
                              value: deceased,
                              delta: (deceased >=
                                          totalDeathsList[
                                              totalDeathsList.length - 1]
                                      ? '+'
                                      : '-') +
                                  deceasedDelta.toString(),
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
                            height: MediaQuery.of(context).size.height / 3,
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
                                  label: '\nactive\n',
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
                                backgroundColor: Colors.white10,
                                // displayYAxis: true,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        ReusableContainer(
                          content: 'Precautions to be taken',
                          buttonText: 'Tap to know more',
                          onTap: () {
                            setState(() {
                              currentIndex = 3;
                            });
                          },
                          left: 6.0,
                          bottom: 1.0,
                          imageName: 'hand_wash',
                          imageHeight: MediaQuery.of(context).size.height / 6,
                        ),
                      ],
                    ),
                  ),
                )
              : (currentIndex == 1
                  ? StateScreen(stateData: widget.modelData)
                  : (currentIndex == 3)
                      ? PrecautionsScreen()
                      : SymptomsScreen()),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: currentIndex,
            showElevation: true,
            itemCornerRadius: 20.0,
            curve: Curves.easeInBack,
            onItemSelected: (index) => setState(() {
              currentIndex = index;
            }),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.apps),
                title: Text('Home'),
                activeColor: Colors.red,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.location_city),
                title: Text('State Wise'),
                activeColor: Colors.red,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.local_hospital),
                title: Text(
                  'Medical',
                ),
                activeColor: Colors.red,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.healing),
                title: Text('Precautions'),
                activeColor: Colors.red,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.developer_mode),
                title: Text('About'),
                activeColor: Colors.red,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey,
              ),
            ],
          ),
          drawerDragStartBehavior: DragStartBehavior.start,
        ),
      ),
    );
  }
}
