import 'package:flutter/material.dart';
import '../../DataProvider/Hospital.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../Pages/HospitalPage.dart';

class HospitalTile extends StatelessWidget {
  final Hospital hospital;

  const HospitalTile(this.hospital, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => (
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HospitalPage(hospital)),
          )
      ),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.35,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[500], width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Text(hospital.name, style: Theme.of(context).textTheme.headline6,),
              Spacer(),
              Container(
                width: double.infinity,
                child: Text("${(hospital.distance * 0.000621371).toStringAsFixed(1)} Miles", style: Theme.of(context).textTheme.overline, textAlign: TextAlign.right,),
              )
            ],
          )
      ),
    );
  }
}
