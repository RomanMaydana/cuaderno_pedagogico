import 'package:cuaderno_pedagogico/config/theme.dart';
import 'package:flutter/material.dart';

import 'button_green.dart';

class Alert extends StatelessWidget {
  final bool isInformation;
  final String title;
  final String content;
  final VoidCallback onTap;
  const Alert(
      {Key key,
      this.isInformation = true,
      @required this.title,
      @required this.content,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      // titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      content: Container(
          width: MediaQuery.of(context).size.width - 24,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                    color: AppColors.veryLightGrey,
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.cancel_rounded,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            letterSpacing: 0.09,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xff443a50)),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        content,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            letterSpacing: 0.06),
                      ),
                    ],
                  )),
              SizedBox(
                height: 27,
              ),
              isInformation
                  ? ButtonGreen(
                      onTap: onTap != null
                          ? onTap
                          : () {
                              Navigator.pop(context);
                            },
                      title: 'Listo!')
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 128,
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).primaryColor)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)))),
                        SizedBox(
                          width: 14,
                        ),
                        SizedBox(
                            width: 128,
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                onPressed: () {},
                                color: AppColors.red,
                                child: Text('Cancel',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))))
                      ],
                    ),
              SizedBox(
                height: 32,
              ),
            ],
          )),
    );
  }
}
