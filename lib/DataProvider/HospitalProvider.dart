import 'dart:async';

import 'Hospital.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
import 'package:us_states/us_states.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HospitalProvider {

  final String urlSlug = dotenv.env['API_URL'];
  final String apiKey = dotenv.env['API_KEY'];

  Future<List<Hospital>> searchHospital(String type, String search) async {
    String convType = type.toLowerCase();
    String cleanedSearch = search.trim();
    List<Hospital> returnHospitals;

    if (convType.contains('/')) {
      convType = convType.replaceAll('/', '');
      convType = convType.replaceAll(' ', '');
    }

    if (convType == "state") {
      if (cleanedSearch.length != 2) {
        cleanedSearch = USStates.getAbbreviation(cleanedSearch);
      }
    }

    print(convType);

    returnHospitals = await this.getHospitals('/$convType/$cleanedSearch');

    return returnHospitals;

  }

  Future<List<Hospital>> getHospitals([String endpoint = '/']) async {
    final response = await http
        .get(Uri.parse('$urlSlug$endpoint'), headers: {"x-api-key" : apiKey});

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

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
}