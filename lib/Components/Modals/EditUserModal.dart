import 'package:carefinderclient/DataProvider/User.dart';
import 'package:flutter/material.dart';

class EditUserModal extends StatefulWidget {
  final User _user;
  final Function _updateRole;

  const EditUserModal(this._user, this._updateRole, {Key key}) : super(key: key);

  @override
  _EditUserModalState createState() => _EditUserModalState();
}

class _EditUserModalState extends State<EditUserModal> {

  bool isAdmin;

  void switchChanged(change) {
    this.setState(() {
      this.isAdmin = change;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return SizedBox(
        height: height / 4,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget._user.email, style: Theme.of(context).textTheme.headline5),
              Row(
                children: [
                  Text("Admin:"),
                  Switch(value: isAdmin ?? (widget._user.role == "ADMIN"), onChanged: switchChanged),
                ],
              ),
              InkWell(
                onTap: () => {
                  widget._updateRole(widget._user,
                      this.isAdmin ?? widget._user.role == "ADMIN"),
                  Navigator.of(context).pop()
                },
                child: Container(
                  child: Center(
                    child: Text("Save User",
                        style: Theme.of(context).textTheme.button),
                  ),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10.0))),
                ),
              ),
            ],
          ),
        ));
  }
}
