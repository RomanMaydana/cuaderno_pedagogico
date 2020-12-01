import 'package:cuaderno_pedagogico/model/provider/list_estudiantes_provider.dart';
import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:cuaderno_pedagogico/widget/alert_app.dart';
import 'package:cuaderno_pedagogico/widget/list_tile_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../services/pdf_service.dart' as pdf;

class FuncionesPage extends StatelessWidget {
  Widget _buildTitle(String title) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 15, color: Color(0xff6d6d72)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
        largeTitle: Text('Funciones'),
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.white, width: 0.0),
      ),
      SliverToBoxAdapter(
          child: Column(children: [
        _buildTitle('ACTIVIDADES'),
        ListTileOption(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.temas);
          },
          title: 'Temas',
        ),
        ListTileOption(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.calificarTema);
          },
          title: 'Calificar Tema',
        ),
        ListTileOption(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.trimestres);
          },
          title: 'Centralizador Por Trimestre',
        ),
        ListTileOption(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.valoracionAnual);
          },
          title: 'Valoracion Anual',
        ),
        ListTileOption(
          onTap: () async {
            final estudiantes =
                ListaEstudiantesProvider.of(context).estudiantes;
            // try {
            await pdf.generatePdf(estudiantes: estudiantes);
            showDialog(
                context: context,
                builder: (_) {
                  return Alert(
                      title: 'Pdf Creado',
                      content: 'El Pdf fue creado correctamente.');
                });
            // } catch (e) {
            //   print(e);
            // }
          },
          title: 'Generar Centralizador Anual',
        ),
      ]))
    ]));
  }
}
