import 'dart:async';

import 'Hospital.dart';
import 'dart:convert';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
import 'package:us_states/us_states.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HospitalProvider {

  final String urlSlug = dotenv.env['API_URL'];
  final String apiKey = dotenv.env['API_KEY'];
  final String jsonUrl = dotenv.env['API_JSON_URL'];

  Future<List<Hospital>> searchHospital(String type, String search) async {
    String convType = type.toLowerCase();

    if (convType == "id") {
      convType = "providerId";
    }

    String cleanedSearch = search.trim().toUpperCase();
    String endpoint;
    List<Hospital> returnHospitals;

    if (convType.contains('/')) {
      // City: [0], State [1]
      List<String> convTypeSplit = convType.split('/');
      List<String> searchSplit = search.split(',');

      if (searchSplit[1].length != 2) {
        searchSplit[1] = USStates.getAbbreviation(searchSplit[1]);
      }

      endpoint = '?${convTypeSplit[0].trim()}=${searchSplit[0].trim()}&${convTypeSplit[1].trim()}=${searchSplit[1].trim()}';

    }

    if (convType == "state") {
      if (cleanedSearch.length != 2) {
        cleanedSearch = USStates.getAbbreviation(cleanedSearch);
      }
    }

    print(convType);

    endpoint == null ? endpoint = '?$convType=$cleanedSearch': endpoint = endpoint;

    //returnHospitals = await this.getHospitals('/$convType/$cleanedSearch');



    returnHospitals = await this.getHospitalsJSON(endpoint);

    return returnHospitals;

  }

  ///XML ENDPOINT
  Future<List<Hospital>> getHospitals([String endpoint = '/']) async {
    final response = await http
        .get(Uri.parse('$urlSlug$endpoint'), headers: {"x-api-key" : apiKey});

    if (response.statusCode == 200) {

      XmlDocument doc = XmlDocument.parse(response.body);
      final List<Hospital> hospitals = doc
          .findAllElements("item")
          .map<Hospital>((e) => Hospital.fromElement(e))
          .toList();

      print(hospitals.length);

      return hospitals;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load hospitals');
    }
  }

  ///JSON ENDPOINT
  Future<List<Hospital>> getHospitalsJSON([String endpoint = '/']) async {
    final response = await http
        .get(Uri.parse('$jsonUrl$endpoint'));

    print('$jsonUrl$endpoint');

    if (response.statusCode == 200) {

      final List decode = json.decode(response.body)["data"];

      final List<Hospital> hospitals = decode.map((e) => Hospital.fromJSON(e)).toList();

      //final List<Hospital> hospitals = doc
      //    .findAllElements("item")
      //    .map<Hospital>((e) => Hospital.fromElement(e))
      //    .toList();

      //print(hospitals.length);

      return hospitals;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load hospitals');
    }
  }
}