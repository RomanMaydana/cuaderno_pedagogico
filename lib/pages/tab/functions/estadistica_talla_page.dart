import 'package:cuaderno_pedagogico/model/provider/list_estudiantes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CuadroEdadesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas por Talla'),
      ),
      body: Consumer<ListaEstudiantesProvider>(
          builder: (_, estudiantesModel, __) {
        return Center(
          child: Column(
            children: [
              Container(
                height: 200,
                width: 400,
              ),
              Container(
                width: 400,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('4 Años')),
                        Expanded(child: Text('5 Años')),
                        Expanded(child: Text('6 Años')),
                        Expanded(child: Text('Total')),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
