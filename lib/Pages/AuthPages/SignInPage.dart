import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../DataProvider/AuthProvider.dart';
import '../Root.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final AuthProvider provider = new AuthProvider();

  String _err = "";
  String _email = "";
  String _password = "";

  void signIn(String email, String password) async {
    try {
      final retUser = await provider.login(email, password);
      print(retUser);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Root()), (_) => false);
    } catch (e) {
      print(e.toString());
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
                  "Sign In",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 10),
                Text(
                  "sign in to your account",
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
                const Spacer(),
                InkWell(
                  onTap: () => (signIn(_email, _password)),
                  child: Container(
                    child: Center(
                      child: Text("Sign In",
                          style: Theme.of(context).textTheme.button),
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
