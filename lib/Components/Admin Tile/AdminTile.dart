import 'package:carefinderclient/DataProvider/AuthProvider.dart';
import 'package:carefinderclient/Pages/AdminPages/AdminTablePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminTile extends StatefulWidget {
  final String title;
  final AuthProvider auth;
  final String type;
  const AdminTile(this.title, this.auth, this.type, {Key key}) : super(key: key);

  @override
  _AdminTileState createState() => _AdminTileState();
}

class _AdminTileState extends State<AdminTile> {

  void onClick(BuildContext context) {
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminTablePage(widget.type, widget.auth)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => (
          onClick(context)
      ),
      child: Container(
          width: MediaQuery.of(context).size.width / 2.8,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border.all(
                color: Colors.grey[500],
                width: 0.5
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Text(widget.title, style: Theme.of(context).textTheme.headline6,),
              SizedBox(height: 50,)
            ],
          )
      ),
    );
  }
}
