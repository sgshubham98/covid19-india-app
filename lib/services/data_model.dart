import 'package:covid19_app/services/networking.dart';

final String covid19IndiaApiUrl = 'https://api.covid19india.org/data.json#';

class DataModel {
  
  Future<dynamic> getApiData() async {  
    NetworkingHelper networkHelper = NetworkingHelper(covid19IndiaApiUrl);
    var data = await networkHelper.getData();
    return data;
  }

}