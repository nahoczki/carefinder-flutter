import 'package:carefinderclient/Components/Modals/EditUserModal.dart';
import 'package:carefinderclient/DataProvider/Apikey.dart';
import 'package:carefinderclient/DataProvider/AuthProvider.dart';
import 'package:carefinderclient/DataProvider/User.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ApiKeyCard extends StatefulWidget {
  final Apikey _apiKey;
  final AuthProvider auth;
  final Function delete;

  ApiKeyCard(
      this._apiKey,
      this.auth,
      this.delete,{
        Key key,
      }) : super(key: key);

  @override
  _ApiKeyCardState createState() => _ApiKeyCardState();
}

class _ApiKeyCardState extends State<ApiKeyCard> {
  Icon icon = Icon(FeatherIcons.trash2, size: 20,);

  void changeIcon(bool ok, bool loading) async {
    if (!loading) {
      if (!ok) {
        this.setState(() {
          this.icon = Icon(FeatherIcons.x, color: Colors.red, size: 20);
        });
      } else {
        this.setState(() {
          this.icon = Icon(FeatherIcons.check, color: Colors.green, size: 20);
        });
      }
      await Future.delayed(const Duration(seconds: 1), (){});
      this.setState(() {
        icon = Icon(FeatherIcons.trash2, size: 20,);
      });
      return;
    }

    this.setState(() {
      this.icon = Icon(FeatherIcons.loader, color: Colors.orange, size: 20);
    });
  }

  void deleteApiKey() async {
    changeIcon(false, true);
    try {
      await widget.auth.deleteApiKey(widget._apiKey.apikey);
      changeIcon(true, false);
      await Future.delayed(const Duration(seconds: 1), (){});
      widget.delete(widget._apiKey);
    } catch (e) {
      changeIcon(false, false);
    }
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
            onPressed: () => {deleteApiKey()},
          ),
          title: Text(
            widget._apiKey.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            widget._apiKey.apikey,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ),
    );
  }
}

/*
showBarModalBottomSheet(
              context: context,
              builder: (context) => EditUserModal(widget._user, saveUser),
            )
 */
