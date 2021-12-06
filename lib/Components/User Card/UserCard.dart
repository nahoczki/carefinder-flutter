import 'package:carefinderclient/Components/Modals/EditUserModal.dart';
import 'package:carefinderclient/DataProvider/AuthProvider.dart';
import 'package:carefinderclient/DataProvider/User.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UserCard extends StatefulWidget {
  final User _user;
  final AuthProvider auth;

  UserCard(
      this._user,
      this.auth, {
        Key key,
      }) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  Icon icon = Icon(FeatherIcons.edit, size: 20,);

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
        icon = Icon(FeatherIcons.edit, size: 20,);
      });
      return;
    }

    this.setState(() {
      this.icon = Icon(FeatherIcons.loader, color: Colors.orange, size: 20);
    });
  }

  void saveUser(User user, bool isAdmin) async {
    this.changeIcon(false, true);

    try {
      User newUser = await widget.auth.updateUserRole(user.email, isAdmin ? "ADMIN" : "USER");
      this.changeIcon(true, false);
      this.setState(() {
        widget._user.role = newUser.role;
      });
    } catch (e) {
      this.changeIcon(false, false);
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
            onPressed: () => showBarModalBottomSheet(
              context: context,
              builder: (context) => EditUserModal(widget._user, saveUser),
            ),
          ),
          title: Text(
            widget._user.email,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            widget._user.role,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ),
    );
  }
}
