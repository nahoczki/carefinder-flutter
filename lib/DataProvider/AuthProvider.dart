import 'package:carefinderclient/DataProvider/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstore/localstore.dart';
import 'dart:convert';
import 'dart:async';

class AuthProvider {
  final String apiKey = dotenv.env['API_KEY'];
  final String urlSlug = dotenv.env['API_URL'];
  final db = Localstore.instance;

  Future<String> getEmail() async {
    dynamic user = await db.collection("user").doc("user").get();
    return user["email"];
  }

  Future<String> getRole() async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.remove("auth");
    dynamic user = await db.collection("user").doc("user").get();
    return user["role"];
  }


  Future<User> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final response = await http
        .post(Uri.parse('$urlSlug/auth/login?email=$email&password=$password'), headers: {"key": apiKey});

    print('$urlSlug/auth/login?email=$email&password=$password');

    if (response.statusCode == 200) {

      final dynamic decode = json.decode(response.body)["data"];
      final String jwt = response.headers["authorization"];
      final User user = User.fromJSON(decode);

      // Store JWT in localstorage
      prefs.setString("auth", jwt);

      // Store userdata locally
      db.collection("user").doc("user").set({
        "email" : user.email,
        "role" : user.role
      });



      //final List<Hospital> hospitals = doc
      //    .findAllElements("item")
      //    .map<Hospital>((e) => Hospital.fromElement(e))
      //    .toList();

      //print(hospitals.length);

      return user;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // TODO: Add better error messages
      throw Exception("Error logging in user");
    }
  }
}