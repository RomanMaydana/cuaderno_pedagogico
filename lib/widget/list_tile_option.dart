import 'package:flutter/material.dart';

class ListTileOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final TextStyle style;
  final Widget trailing;

  const ListTileOption({
    Key key,
    @required this.title,
    @required this.onTap,
    this.padding =
        const EdgeInsets.only(left: 20, right: 15, top: 17, bottom: 17),
    this.style = const TextStyle(
      fontSize: 17,
      letterSpacing: -0.41,
    ),
    this.trailing,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  width: 0.5, color: Color(0xff3c3c43).withOpacity(0.2)))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // splashColor: Colors.red,
          highlightColor: Colors.white.withOpacity(0.8),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: style,
                ),
                trailing == null
                    ? Icon(
                        Icons.keyboard_arrow_right,
                        color: Color(0xff3c3c43).withOpacity(0.3),
                      )
                    : trailing
              ],
            ),
          ),
        ),
      ),
    );
  }
}
