import 'package:carefinderclient/Pages/LocationAskPage.dart';
import 'package:carefinderclient/Pages/Root.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Splash extends HookWidget {
  const Splash({Key key}) : super(key: key);

  Future<bool> _allowLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      return false;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController();

    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: Lottie.asset(
          "assets/logo.json",
          width: 125,
          height: 125,
          controller: animationController,
          onLoaded: (composition) {
            animationController.addStatusListener((status) async {
              if (status == AnimationStatus.completed) {
                bool allowed = await _allowLocation();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => allowed ? Root() : LocationAskPage()));
              }
            });
            // Configure the AnimationController with the duration of the
            // Lottie file and start the animation.
            animationController
              ..duration = composition.duration
              ..forward();
          },
        ),
      )
    );
  }
}
