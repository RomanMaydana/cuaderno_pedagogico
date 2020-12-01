import 'dart:io';

import 'package:cuaderno_pedagogico/config/theme.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final File file;
  final String url;
  final VoidCallback onTap;

  const CircleImage({Key key, this.file, this.url, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      child: file == null && url == null
          ? GestureDetector(
              onTap: onTap,
              child: Container(
                height: 106,
                width: 106,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.lightGrey),
                    borderRadius: BorderRadius.circular(50)),
                child:
                    Icon(Icons.camera_alt_rounded, color: AppColors.lightGrey),
              ))
          : Container(
              height: 95,
              width: 95,
              child: Stack(
                children: [
                  Container(
                    height: 92,
                    width: 92,
                    child: ClipOval(
                      child: file != null
                          ? Image.file(
                              file,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              url,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 20,
                      child: IconButton(
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: onTap),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
