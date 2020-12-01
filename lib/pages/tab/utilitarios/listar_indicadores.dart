import 'package:cuaderno_pedagogico/model/provider/indicadores_provider.dart';
import 'package:cuaderno_pedagogico/widget/item_row_indicador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListarIndicadores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Indicadores')),
        body: Consumer<IndicadoresProvider>(
          builder: (_, model, __) {
            return model.indicadores != null
                ? ListView.separated(
                    padding: const EdgeInsets.all(32),
                    separatorBuilder: (_, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: model.indicadores.length,
                    itemBuilder: (_, index) {
                      final indicador = model.indicadores[index];
                      return ItemRowIndicador(
                        title: indicador.nombre,
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}
