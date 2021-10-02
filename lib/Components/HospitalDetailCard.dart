import 'package:flutter/material.dart';

class HospitalDetailCard extends StatelessWidget {

  final IconData icon;
  final String text;

  const HospitalDetailCard(
      this.icon, this.text, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).canvasColor,
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
        elevation: 0,
        child: Row(
          children: [
            Icon(icon, size: 20),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                        text,
                        softWrap: true,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle2
                    )
                )
            ),
          ],
        )
    );
  }
}