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

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await db.collection("user").doc("user").delete();

    prefs.remove("auth");
    return;
  }

  Future<String> getRole() async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.remove("auth");
    dynamic user = await db.collection("user").doc("user").get();
    return user["role"];
  }

  Future<User> register(String email, String password) async {
    final response = await http
        .post(Uri.parse('$urlSlug/auth/register?email=$email&password=$password'), headers: {"key": apiKey});

    //print('$urlSlug/auth/login?email=$email&password=$password');

    if (response.statusCode == 200) {
      return await login(email, password);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // TODO: Add better error messages
      throw Exception("Error Registering user");
    }
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

      return user;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // TODO: Add better error messages
      throw Exception("Error logging in user");
    }
  }

  Future<List<User>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();

    final response = await http
        .get(Uri.parse('$urlSlug/auth/users'), headers: {"key": apiKey, "Authorization" : prefs.getString("auth")});

    //print('$urlSlug/auth/login?email=$email&password=$password');

    if (response.statusCode == 200) {

      final List decode = json.decode(response.body)["data"];

      final List<User> users = decode.map((e) => User.fromJSON(e)).toList();


      return users;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // TODO: Add better error messages
      throw Exception("no permissions");
    }
  }

  Future<User> updateUserRole(String toUpdate, String newRole) async {
    final prefs = await SharedPreferences.getInstance();

    final response = await http
        .put(Uri.parse('$urlSlug/auth/updaterole?email=$toUpdate&role=$newRole'), headers: {"key": apiKey, "Authorization" : prefs.getString("auth")});

    //print('$urlSlug/auth/login?email=$email&password=$password');

    if (response.statusCode == 200) {
      final dynamic decode = json.decode(response.body)["data"];
      final User user = User.fromJSON(decode);

      return user;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // TODO: Add better error messages
      throw Exception("no permissions");
    }
  }
}