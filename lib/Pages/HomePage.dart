import 'package:carefinderclient/Components/Hospital%20Tile/HospitalTile.dart';
import 'package:carefinderclient/DataProvider/Hospital.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import '../Components/Hospital Card/HospitalCard.dart';
import '../Components/Hospital Card/HospitalCardSkeleton.dart';
import '../Components/Hospital Tile/HospitalTileSkeleton.dart';

import '../DataProvider/HospitalProvider.dart';

class HomePage extends StatefulWidget {
  final bool isLoading;
  final List<Hospital> hospitals;
  final List<Hospital> closeHospitals;

  HomePage(this.isLoading, this.hospitals, this.closeHospitals, {Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final int increment = 10;
  bool init = false;

  List<Hospital> curLoaded = [];

  Future _loadMore() async {
    curLoaded.addAll(List.generate(
        increment, (index) => widget.hospitals[curLoaded.length + index]));

    setState(() {
      this.init = true;
    });

    print('loaded: ${curLoaded.length}');
  }

  List<Widget> loadSkeletons() {
    var rand = new Random();
    List<Widget> skeletons = [];

    for (var i = 0; i < 4; i++) {
      skeletons.add(HospitalCardSkeleton(
          (rand.nextDouble() * (0.66 - 0.33)) + 0.33,
          (rand.nextDouble() * (0.75 - 0.85)) + 0.75));
    }
    return skeletons;
  }

  @override
  Widget build(BuildContext context) {

    if (!widget.isLoading && (widget.isLoading ? init : !init)) {
      _loadMore();
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return LazyLoadScrollView(
        isLoading: widget.isLoading,
        onEndOfPage: () => _loadMore(),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(
                    top: 15, left: 20, right: 20, bottom: 15),
                width: double.infinity,
                color: Theme.of(context).secondaryHeaderColor,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage("assets/pin.png"),
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 5),
                    Text("Hospitals Near you", textAlign: TextAlign.left),
                  ],
                )),
            widget.isLoading ? Container(
                height: MediaQuery.of(context).size.height * 0.22,
                color: Theme.of(context).secondaryHeaderColor,
                padding: EdgeInsets.only(left: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HospitalTileSkeleton(),
                    HospitalTileSkeleton(),
                    HospitalTileSkeleton(),
                  ],
                ),
            ) : Container(
              height: MediaQuery.of(context).size.height * 0.22,
              color: Theme.of(context).secondaryHeaderColor,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 20.0, right: 10.0),
                itemCount: 10,
                itemBuilder: (context, position) {
                  return HospitalTile(widget.closeHospitals[position]);
                },
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: 15, left: 20, right: 20, bottom: 15),
                width: double.infinity,
                color: Theme.of(context).secondaryHeaderColor,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage("assets/hospital.png"),
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 5),
                    Text("All Hospitals", textAlign: TextAlign.left),
                  ],
                )),
            Expanded(
              child: widget.isLoading ? ListView(
                padding: EdgeInsets.only(top: 10),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: loadSkeletons(),
              ) : ListView.separated(
                itemCount: curLoaded.length,
                itemBuilder: (context, position) {
                  return HospitalCard(curLoaded[position]);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 0,
                    color: Colors.grey[500],
                  );
                },
              ),
            )
          ],
        ));
  }
}
