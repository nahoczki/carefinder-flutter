import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String _err = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";

  void signUp(String email, String password) async {

    if (_password != _confirmPassword) {
      setErr('Passwords do not match');
      return;
    }

  }

  void setErr(String msg) {
    setState(() {
      _err = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          leading: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                enableFeedback: false,
                child: const Icon(
                  FeatherIcons.arrowLeft,
                  size: 30.0,
                )),
          )),
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 10),
                Text(
                  "create an account to keep track of your notes between different devices",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      _email = text;
                    });
                  },
                  obscureText: false,
                  style: Theme.of(context).textTheme.subtitle2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).dividerColor,
                      labelText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      _password = text;
                    });
                  },
                  obscureText: true,
                  style: Theme.of(context).textTheme.subtitle2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).dividerColor,
                      labelText: 'Password',
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      _confirmPassword = text;
                    });
                  },
                  obscureText: true,
                  style: Theme.of(context).textTheme.subtitle2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).dividerColor,
                      labelText: 'Confirm Password',
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => (signUp(_email, _password)),
                  child: Container(
                    child: Center(
                      child: Text("Create an account",
                          style: Theme.of(context).textTheme.button ),
                    ),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
                Text(_err),
                const SizedBox(height: 70),
              ],
            ),
          )),
    );
  }
}
