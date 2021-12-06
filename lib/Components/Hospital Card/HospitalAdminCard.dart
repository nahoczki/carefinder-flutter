import 'package:carefinderclient/DataProvider/Hospital.dart';
import 'package:carefinderclient/DataProvider/HospitalProvider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../Pages/HospitalPage.dart';

class HospitalAdminCard extends StatefulWidget {
  final Hospital _hospital;
  final Function delete;
  final HospitalProvider hospitalProvider = new HospitalProvider();

  HospitalAdminCard(
      this._hospital,
      this.delete, {
        Key key,
      }) : super(key: key);

  @override
  _HospitalAdminCardState createState() => _HospitalAdminCardState();
}

class _HospitalAdminCardState extends State<HospitalAdminCard> {
  Icon icon = Icon(FeatherIcons.trash);

  void changeIcon(bool ok) async {
    if (!ok) {
      this.setState(() {
        this.icon = Icon(FeatherIcons.x, color: Colors.red,);
      });
    } else {
      this.setState(() {
        this.icon = Icon(FeatherIcons.check, color: Colors.green,);
      });
    }

    await Future.delayed(const Duration(seconds: 1), (){});
    icon = Icon(FeatherIcons.trash);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).canvasColor,
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: ListTile(
          enableFeedback: true,
          trailing: IconButton(
            icon: icon,
            onPressed: () => {widget.delete(widget._hospital, changeIcon)},
          ),
          title: Text(
            widget._hospital.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            widget._hospital.address,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ),
    );
  }
}
