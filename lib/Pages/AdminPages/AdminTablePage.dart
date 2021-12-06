import 'package:carefinderclient/Components/Hospital%20Card/HospitalAdminCard.dart';
import 'package:carefinderclient/Components/Hospital%20Card/HospitalCard.dart';
import 'package:carefinderclient/Components/User%20Card/UserCard.dart';
import 'package:carefinderclient/DataProvider/AuthProvider.dart';
import 'package:carefinderclient/DataProvider/Hospital.dart';
import 'package:carefinderclient/DataProvider/HospitalProvider.dart';
import 'package:carefinderclient/DataProvider/User.dart';
import 'package:carefinderclient/Pages/LoadingPage.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';

class AdminTablePage extends StatefulWidget {
  final String type;
  final AuthProvider auth;

  AdminTablePage(this.type, this.auth, {Key key}) : super(key: key);

  @override
  _AdminTablePageState createState() => _AdminTablePageState();
}

class _AdminTablePageState extends State<AdminTablePage> {
  final hospitalProvider = new HospitalProvider();

  List<Hospital> hospitals = [];
  List<User> users = [];
  bool isLoading = true;
  bool authorized = false;

  //final apiKeyProvider = new ApiKeyProvider();

  @override
  void initState() {
    super.initState();
    widget.auth.getRole().then((role) => {
      if (role == "ADMIN") {
        this.setState(() {
          authorized = true;
        })
      }
    });

    try {
      switch (widget.type) {
        case "apikeys": return;
        case "hospitals":
          hospitalProvider.getHospitalsJSON().then((hospitals) => {
            this.setState(() {
              this.hospitals = hospitals;
              this.isLoading = false;
            })
          });
          return;
        case "users":
          widget.auth.getAllUsers().then((users) => {
            this.setState(() {
              this.users = users;
              this.isLoading = false;
            })
          });
      }

    } catch (e) {
      this.setState(() {
        authorized = true;
      });
    }


  }

  void deleteHospital(Hospital del, Function res) async {
    final ok = await hospitalProvider.deleteHospital(del.providerId);
    res(ok);
    if (ok) {
      await Future.delayed(const Duration(seconds: 1), (){});
      this.setState(() {
        hospitals.remove(del);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Container(
                color: Theme.of(context).dividerColor,
                height: 1.0,
                width: double.infinity,
              ),
            ),
            centerTitle: false,
            title: Text(
              "Manage ${widget.type}",
              style: Theme.of(context).textTheme.headline5,
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  enableFeedback: false,
                  child: const Icon(
                    FeatherIcons.arrowLeft,
                    size: 25.0,
                  )),
            )),
        body: isLoading ? LoadingPage()
            : !authorized ? Center(child: Text("You do no have permission to view this page."))
            : widget.type == "hospitals" ? Container(
            child: Container(
                child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: hospitals.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HospitalAdminCard(hospitals[index], deleteHospital);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 10,
                        color: Colors.grey,
                      );
                    })
            )
        ) : widget.type == "users" ? Container(
            child: Container(
                child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UserCard(users[index], widget.auth);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 10,
                        color: Colors.grey,
                      );
                    })
            )
        ) : Container(
            child: Container(
                child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UserCard(users[index], widget.auth);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 10,
                        color: Colors.grey,
                      );
                    })
            )
        )
    );
  }
}
