import 'package:carefinderclient/DataProvider/AuthProvider.dart';
import 'package:carefinderclient/Pages/UserPage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../DataProvider/HospitalProvider.dart';
import '../DataProvider/Hospital.dart';

import 'HomePage.dart';
//import 'MapPage.dart';
import 'SearchPage.dart';

class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final HospitalProvider provider = new HospitalProvider();
  final AuthProvider authProvider = new AuthProvider();
  final Location location = new Location();
  final int increment = 10;
  LocationData _locationData;

  String _tab = "Home";
  bool _isLoading = true;

  List<Hospital> _hospitals = [];
  List<Hospital> _closeHospitals = [];

  @override
  void initState() {
    super.initState();
    provider.getHospitalsJSON().then((hospitals) => {_viewLoader(hospitals)});
  }

  void _viewLoader(List<Hospital> hospitals) async {
    setState(() {
      this._hospitals = hospitals;
      this._closeHospitals = [...hospitals];
    });

    await _setCloseHospitals(hospitals);

    HapticFeedback.lightImpact();
    setState(() {
      this._isLoading = false;
    });
  }

  void onClick(BuildContext context) {
    HapticFeedback.lightImpact();
    Navigator.of(context).push(_createRouteToSearch());
  }

  void changeTabTo(String tab) {
    this.setState(() {
      _tab = tab;
    });
  }

  Future<void> _setCloseHospitals(List<Hospital> hospitals) async {
    _locationData = await location.getLocation();

    _closeHospitals.sort((a, b) => (a.compareTo(
        b, new LatLng(_locationData.latitude, _locationData.longitude))));

    //print(hospitals[0].name);
    return;
  }

  Route _createRouteToSearch() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SearchPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
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
            this._tab,
            style: Theme.of(context).textTheme.headline5,
          ),
          actions: [
            Visibility(
              child: InkWell(
                  onTap: () => (onClick(context)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 1.0),
                    child: Icon(
                      FeatherIcons.search,
                      size: 22.0,
                    ),
                  )),
              visible: (this._tab == "Home"),
            ),
            InkWell(
                onTap: () =>
                    (changeTabTo((this._tab == "Home") ? "User" : "Home")),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Icon(
                    (this._tab == "Home")
                        ? FeatherIcons.user
                        : FeatherIcons.home,
                    size: 22.0,
                  ),
                ))
          ],
        ),
        body: (this._tab == "Home")
            ? HomePage(_isLoading, _hospitals, _closeHospitals)
            : UserPage(authProvider));
  }
}
