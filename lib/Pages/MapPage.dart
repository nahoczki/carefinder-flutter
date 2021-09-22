import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:fluster/fluster.dart';

import '../DataProvider/Hospital.dart';
import '../Components/Map Marker/MapMarker.dart';

class MapPage extends StatefulWidget {
  final List<Hospital> hospitals;

  const MapPage(this.hospitals, {Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool _isLoading = false;

  final Location _location = new Location();
  LocationData _locationData;

  LatLng _initialLocation = LatLng(0, 0);
  GoogleMapController _mapController;

  final List<MapMarker> markers = [];
  List<Marker> googleMarkers;

  final List<LatLng> _markerLocations = [
    LatLng(41.147125, -8.611249),
    LatLng(41.145599, -8.610691),
  ];

  Fluster<MapMarker> fluster;


  @override
  void initState() {
    // TODO: implement initState
    // setState(() {
    //   this._markers = _generateMarkers(widget.hospitals);
    // });

    for (LatLng markerLocation in _markerLocations) {
      markers.add(
        MapMarker(
          id: _markerLocations.indexOf(markerLocation).toString(),
          icon: BitmapDescriptor.defaultMarker,
          position: markerLocation,
        ),
      );
    }

    fluster = Fluster<MapMarker>(
      minZoom: 20, // The min zoom at clusters will show
      maxZoom: 25, // The max zoom at clusters will show
      radius: 150, // Cluster radius in pixels
      extent: 2048, // Tile extent. Radius is calculated with it.
      nodeSize: 64, // Size of the KD-tree leaf node.
      points: markers, // The list of markers created before
      createCluster: ( // Create cluster marker
          BaseCluster cluster,
          double lng,
          double lat,
          ) => MapMarker(
        id: cluster.id.toString(),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarker,
        isCluster: cluster.isCluster,
        clusterId: cluster.id,
        pointsSize: cluster.pointsSize,
        childMarkerId: cluster.childMarkerId,
      ),
    );

    googleMarkers = fluster
        .clusters([-180, -85, 180, 85], 15)
        .map((cluster) => cluster.toMarker())
        .toList();


    super.initState();
  }



  void _onMapCreated(GoogleMapController _cntlr) async {
    setState(() {
      this._isLoading = true;
    });

    _mapController = _cntlr;
    _locationData = await _location.getLocation();


    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(_locationData.latitude, _locationData.longitude), zoom: 15),
      ),
    );

    setState(() {
      this._isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _isLoading ? SafeArea(
            top: false,
            child: Container(
                child: Center(
                    child: Transform(
                      transform: Matrix4.identity()..scale(0.8),
                      child: CircularProgressIndicator(
                        value: 50,
                      ),
                    )
                )
            ))
            : SizedBox(height: 0, width: 0,),
        Container(
          child: GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: googleMarkers.toSet(),
            initialCameraPosition: CameraPosition(
              target: _initialLocation,
              zoom: 15,
            ),
            onMapCreated: _onMapCreated,
          ),
        )
      ],
    );
  }
}
