import 'package:carefinderclient/DataProvider/Hospital.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../Pages/HospitalPage.dart';

class HospitalCard extends StatelessWidget {
  final Hospital _hospital;

  const HospitalCard(
      this._hospital, {
        Key key,
      }) : super(key: key);

  void onClick(BuildContext context) {
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HospitalPage(_hospital)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Theme.of(context).canvasColor,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: ListTile(
            onTap: () => (
              onClick(context)
            ),
            enableFeedback: true,
            // leading: Icon(Icons.arrow_drop_down_circle),
            title: Text(
              _hospital.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              _hospital.address,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ),
    );
  }
}