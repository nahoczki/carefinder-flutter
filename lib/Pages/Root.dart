import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../DataProvider/HospitalProvider.dart';
import '../DataProvider/Hospital.dart';

import 'HomePage.dart';
import 'MapPage.dart';
import 'SearchPage.dart';

class Root extends StatefulWidget {

  Root({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final HospitalProvider provider = new HospitalProvider();
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

    setState(() {
      this._isLoading = false;
    });
  }

  Future<void> _setCloseHospitals(List<Hospital> hospitals) async {
    _locationData = await location.getLocation();

    _closeHospitals.sort((a, b) => (a.compareTo(b, new LatLng(_locationData.latitude, _locationData.longitude))));

    //print(hospitals[0].name);
    return;
  }

  Route _createRouteToSearch() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const SearchPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
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
            // InkWell(
            //     onTap: () => (
            //         setState(() {
            //           this._tab = (this._tab == "Home") ? "Map" : "Home";
            //         })
            //     ),
            //     child: Container(
            //       child: Icon(
            //         (this._tab == "Home") ? FeatherIcons.map : FeatherIcons.list,
            //         size: 22.0,
            //       ),
            //     )),
            InkWell(
              onTap: () => (
              Navigator.of(context).push(_createRouteToSearch())
              ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Icon(
                    FeatherIcons.search,
                    size: 22.0,
                  ),
                ))
          ],
        ),
        body: (this._tab == "Home") ? HomePage(_isLoading, _hospitals, _closeHospitals) : MapPage(_hospitals)
    );
  }
}