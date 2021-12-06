import 'package:carefinderclient/DataProvider/Apikey.dart';
import 'package:carefinderclient/DataProvider/AuthProvider.dart';
import 'package:carefinderclient/DataProvider/User.dart';
import 'package:flutter/material.dart';

class CreateApiKeyModal extends StatefulWidget {
  final Function _addKey;
  final AuthProvider auth;

  const CreateApiKeyModal(this._addKey, this.auth, {Key key}) : super(key: key);

  @override
  _CreateApiKeyModalState createState() => _CreateApiKeyModalState();
}

class _CreateApiKeyModalState extends State<CreateApiKeyModal> {

  String _name = "";
  String _err = "";
  bool isLoading = false;

  void createApiKey(String name) async {
    this.setState(() {
      this.isLoading = true;
    });

    try {
      Apikey created = await widget.auth.createApiKey(name);
      widget._addKey(created);
      this.setState(() {
        this.isLoading = false;
      });
      Navigator.of(context).pop();
    } catch (e) {
      this.setState(() {
        this._err = "Name is already in use";
        this.isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return SizedBox(
        height: height / 3,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter a unique name", style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 15,),
              TextField(
                onChanged: (text) {
                  setState(() {
                    _name = text;
                  });
                },
                obscureText: false,
                style: Theme.of(context).textTheme.subtitle2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).dividerColor,
                    labelText: 'Name',
                    floatingLabelBehavior: FloatingLabelBehavior.never),
              ),
              const SizedBox(height: 10),
              const Spacer(),
              InkWell(
                onTap: () => (createApiKey(_name)),
                child: Container(
                  child: Center(
                    child: isLoading ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white,))
                    : Text("Create Key",
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
              Text(_err),
            ],
          ),
        ));
  }
}
