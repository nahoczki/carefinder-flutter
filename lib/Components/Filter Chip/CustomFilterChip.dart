import 'package:flutter/material.dart';

class CustomFilterChip extends StatelessWidget {
  final String title;
  final String selected;

  const CustomFilterChip(this.title, this.selected, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.transparent : title == selected ? Theme.of(context).colorScheme.primary : Colors.grey[500],
      shape: StadiumBorder(
          side: BorderSide(
            color: MediaQuery.of(context).platformBrightness != Brightness.dark ? Colors.transparent : title == selected ? Theme.of(context).colorScheme.primary : Colors.grey[500],
          )
      ),
      label: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w500),
      ),
    );
  }
}
