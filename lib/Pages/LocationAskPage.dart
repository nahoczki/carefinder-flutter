import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';
import 'Root.dart';


class LocationAskPage extends StatelessWidget {
  const LocationAskPage ({Key key}) : super(key: key);

  Future<Navigator> _askForLocationAndPush(BuildContext context) async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        // Not Granted
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Root())
        );
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // Not granted
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Root())
        );
      }
    }

    // Granted
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Root())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              SvgPicture.asset(
                "assets/location.svg",
                width: 125,
                height: 125,
              ),
              SizedBox(height: 20),
              Text("Discover Hospitals based on your location",
                textAlign: TextAlign.center, style:
                Theme.of(context).textTheme.bodyText1,),
              SizedBox(height: 10),
              Text("In order to find hospitals accurately, "
                  "we highly recommend enabling location services to find hospitals near you!",
                  textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Spacer(),
              InkWell(
                onTap: () => (
                    _askForLocationAndPush(context)
                ),
                child: Container(
                  child: Center(
                    child: Text("Enable Location Services", style:
                    TextStyle(color: Colors.white, fontSize: 14.0)),
                  ),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () => (
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Root())
                    )
                ),
                child: Text(
                    "No, thanks",
                    style: Theme.of(context).textTheme.button),
              ),
              SizedBox(height: 30),
            ],
          ),
        )
      ),
    );
  }
}
