import 'package:carefinderclient/Components/Hospital%20Card/HospitalCard.dart';
import 'package:carefinderclient/DataProvider/AuthProvider.dart';
import 'package:carefinderclient/DataProvider/Hospital.dart';
import 'package:carefinderclient/DataProvider/HospitalProvider.dart';
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
  //final apiKeyProvider = new ApiKeyProvider();

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
            )
        ),
        body: Container(
      child: FutureBuilder(
          future: widget.type == "hospitals" ? hospitalProvider.getHospitalsJSON() : widget.auth.getEmail(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              List<Hospital> hospitals = snapshot.data as List<Hospital>;

              return Container(
                child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: hospitals.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HospitalCard(hospitals[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 10,
                        color: Colors.grey,
                      );
                    })
              );
            } else {
              return LoadingPage();
            }
          })
    )
    );
  }
}
