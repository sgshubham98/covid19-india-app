import 'package:covid19_app/screens/state_wise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid19_app/services/data_model.dart';
import 'package:covid19_app/screens/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  DataModel model = DataModel();

  @override
  void initState() {
    super.initState();
    getModelData();
    // getStateData();
  }

  void getModelData() async {
    var apiData = await model.getApiData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen(
            modelData: apiData,
          );
        },
      ),
    );
  }

  // void getStateData() async {
  //   var apiData = await model.getApiData();
  //   StateScreen(
  //     stateData: apiData,
  //   );
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) {
  //         return StateScreen(
  //           stateData: apiData,
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}
