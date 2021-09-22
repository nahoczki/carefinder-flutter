import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HospitalCardSkeleton extends StatelessWidget {
  final double titleWidth;
  final double subtitleWidth;

  const HospitalCardSkeleton(
      this.titleWidth,
      this.subtitleWidth, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: ListTile(
            // leading: Icon(Icons.arrow_drop_down_circle),
            title: SkeletonAnimation(
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width * titleWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300]),
              ),
            ),
            subtitle: SkeletonAnimation(
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width * subtitleWidth,
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
