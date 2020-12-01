import 'package:cuaderno_pedagogico/config/theme.dart';
import 'package:flutter/material.dart';

class ItemRowIndicador extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool border;

  const ItemRowIndicador(
      {Key key, @required this.title, this.onTap, this.border = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color:
                !border ? Colors.transparent : AppColors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
                width: 0.5, color: !border ? Colors.black : AppColors.green)),
        padding: const EdgeInsets.all(16),
        child: Text(
          title,
        ),
      ),
    );
  }
}
