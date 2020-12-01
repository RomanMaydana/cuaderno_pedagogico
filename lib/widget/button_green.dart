import 'package:flutter/material.dart';

class ButtonGreen extends StatelessWidget {
  const ButtonGreen(
      {Key key, @required this.onTap, @required this.title, this.active = true})
      : super(key: key);

  final VoidCallback onTap;
  final String title;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: FlatButton(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: active ? onTap : null,
          disabledColor: Color(0xffdcdcdc),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
    );
  }
}
