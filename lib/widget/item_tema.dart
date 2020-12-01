import 'package:cuaderno_pedagogico/data/tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemTema extends StatelessWidget {
  final Tema tema;
  final bool options;
  const ItemTema({
    Key key,
    @required this.tema,
    this.options = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 0.4,
      child: Container(
        // height: 130,
        padding: options
            ? const EdgeInsets.fromLTRB(16, 8, 8, 16)
            : const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.3))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    tema.nombre.toUpperCase(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                options
                    ? IconButton(
                        icon: Icon(CupertinoIcons.ellipsis_vertical),
                        onPressed: () {})
                    : const SizedBox.shrink()
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text('Trimestre: ${tema.trimestre}'),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(tema.descripcion,
                    // overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.subtitle1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
