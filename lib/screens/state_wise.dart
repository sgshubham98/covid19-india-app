import 'package:covid19_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class StateScreen extends StatefulWidget {
  StateScreen({
    this.stateData,
  });

  final stateData;

  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  List stateWiseList;
  List<DataRow> dataCellsList;
  var dataRow;

  @override
  void initState() {
    super.initState();
    updateUI(widget.stateData);
  }

  void updateUI(apiData) {
    setState(() {
      dataCellsList = [];
      if (apiData == null) {
        stateWiseList = null;
        return;
      }
      stateWiseList = apiData['statewise'];
      for (int i = 1; i < stateWiseList.length; i++) {
        String state = stateWiseList[i]['state'];
        String confirmed = stateWiseList[i]['confirmed'];
        String active = stateWiseList[i]['active'];
        String deaths = stateWiseList[i]['deaths'];
        dataRow = DataRow(
          cells: [
            DataCell(
              Text(state),
            ),
            DataCell(
              Text(confirmed),
            ),
            DataCell(
              Text(active),
            ),
            DataCell(
              Text(deaths),
            ),
          ],
        );
        dataCellsList.add(dataRow);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'State Wise Data',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: kTitleColor,
              ),
            ),
            SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24.0,
                columns: [
                  DataColumn(
                    
                    label: Text('State'),
                  ),
                  DataColumn(
                    label: Text('Infected'),
                  ),
                  DataColumn(
                    label: Text('Active'),
                  ),
                  DataColumn(
                    label: Text('Deaths'),
                  ),
                ],
                rows: dataCellsList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
