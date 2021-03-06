import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HospitalTileSkeleton extends StatelessWidget {
  const HospitalTileSkeleton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        gradientColor: Theme.of(context).secondaryHeaderColor,
        shimmerColor: Theme.of(context).canvasColor,
        curve: Curves.easeInOut,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.35,
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).canvasColor),
        ));
  }
}
