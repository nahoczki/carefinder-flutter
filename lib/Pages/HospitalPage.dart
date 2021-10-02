import 'package:carefinderclient/Components/HospitalDetailCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../DataProvider/Hospital.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;


class HospitalPage extends StatefulWidget {
  final Hospital hospital;

  HospitalPage(this.hospital, {Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  GoogleMapController mapController;
  bool _isLoading = true;

  String darkMap = '''
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.medical",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "poi.medical",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#5b2c2d"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]''';

  bool isMapLoading;

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
          leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              enableFeedback: false,
              child: Container(
                child: Icon(
                  FeatherIcons.arrowLeft,
                  size: 21.5,
                ),
              )
          ),
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
            "Hospital Info",
            style: Theme.of(context).textTheme.headline5,
          ),
          actions: [
            InkWell(
                onTap: () => (
                    MapsLauncher.launchQuery(widget.hospital.address)
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Icon(
                    Icons.directions_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 25.0,
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: Visibility(
                    visible: !_isLoading,
                    child: GoogleMap(
                      myLocationButtonEnabled: false,
                      zoomGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(widget.hospital.lat, widget.hospital.long),
                        zoom: 15,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                        mapController.setMapStyle(MediaQuery.of(context).platformBrightness == Brightness.dark ? darkMap : "");
                        setState(() {
                          _isLoading = false;
                        });
                      },
                    ),
                  )
              ),
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.hospital.name}", style: Theme.of(context).textTheme.headline5,),
                      Text("${widget.hospital.type}", style: Theme.of(context).textTheme.caption,),
                      Transform(
                        transform: Matrix4.identity()..scale(0.8),
                        child: Chip(
                          avatar: Icon(widget.hospital.emergency ? FeatherIcons.check : FeatherIcons.x, size: 20, color: Colors.white,),
                          backgroundColor: widget.hospital.emergency ? Colors.green[500] : Colors.red[500],
                          label: Text(
                            "Emergency Services",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Card(
                  elevation: 0,
                  color: Theme.of(context).canvasColor,
                  child: ListTile(
                    title: Text("Details", style: Theme.of(context).textTheme.overline),
                    dense: true,
                  )
              ),
              HospitalDetailCard(FeatherIcons.phone, "${widget.hospital.phone.replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d+)'), (Match m) => "(${m[1]}) ${m[2]}-${m[3]}")}"),
              HospitalDetailCard(FeatherIcons.user, "${widget.hospital.ownership}"),
              HospitalDetailCard(FeatherIcons.mapPin, "${widget.hospital.address ??= ""}, ${widget.hospital.city ??= ""} ${widget.hospital.state ??= ""}, ${widget.hospital.zip ??= ""}")
            ],
          ),
        )
    );
  }
}
