
import 'package:carefinderclient/Components/Admin%20Tile/AdminTile.dart';
import 'package:carefinderclient/DataProvider/AuthProvider.dart';
import 'package:flutter/material.dart';

import 'AuthPages/StartPage.dart';

class UserPage extends StatefulWidget {
  final AuthProvider auth;
  UserPage(this.auth, {Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  void signOut() async {
    await widget.auth.signOut();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => StartPage()), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
              future: widget.auth.getEmail(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data, style: Theme.of(context).textTheme.headline5);
                } else {
                  return Text("");
                }
              }),
          SizedBox(height: 5,),
          FutureBuilder(
              future: widget.auth.getRole(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data, style: Theme.of(context).textTheme.overline);
                } else {
                  return Text("");
                }
              }),
          SizedBox(height: 50,),
          FutureBuilder(
              future: widget.auth.getRole(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == "ADMIN") {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Admin Controls", style: Theme.of(context).textTheme.overline),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            AdminTile("User Management", widget.auth, "users"),
                            AdminTile("Hospital Management", widget.auth, "hospitals"),
                            AdminTile("API keys Management", widget.auth, "apikeys"),
                          ],
                        )
                      ],
                    ),
                  );
                } else if(snapshot.hasData && snapshot.data == "USER") {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Developer Settings", style: Theme.of(context).textTheme.overline),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AdminTile("API keys", widget.auth, "apikeys"),
                        ],
                      )
                    ],
                  );
                } else {
                  return Text("");
                }
              }),
          Spacer(),
          InkWell(
            onTap: () => (signOut()),
            child: Container(
              child: Center(
                child: Text("Sign Out",
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
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
