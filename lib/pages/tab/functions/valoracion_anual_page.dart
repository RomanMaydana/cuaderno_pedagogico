import 'package:cuaderno_pedagogico/config/theme.dart';
import 'package:cuaderno_pedagogico/model/provider/list_estudiantes_provider.dart';
import 'package:cuaderno_pedagogico/pages/tab/call_list/call_list_page.dart';
import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ValoracionAnualPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Valoración Anual'),
      ),
      body: Consumer<ListaEstudiantesProvider>(
          builder: (_, estudiantesModel, __) {
        return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) {
              final estudiante = estudiantesModel.estudiantes[index];

              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(width: 0.5, color: Colors.black)),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${estudiante.nroLista}. ${estudiante.nombre}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ButtonAsistencia(
                      color: AppColors.green,
                      letra: 'Valorar',
                      // llamoLista: fueValorado,
                      llamoLista: true,
                      onTap: () async {
                        Navigator.pushNamed(
                            context, AppRoutes.valoracionAnualByEstudiante,
                            arguments: estudiante);
                      },
                    ),
                  ],
                ),
              );
            },
            itemCount: estudiantesModel.estudiantes.length,
            separatorBuilder: (_, __) {
              return const SizedBox(
                height: 16,
              );
            });
      }),
    );
  }
}
