import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:cuaderno_pedagogico/widget/list_tile_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UtilitariosPage extends StatelessWidget {
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
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Utilitarios'),
            backgroundColor: Colors.white,
            border: Border.all(color: Colors.white, width: 0.0),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildTitle('ESTUDIANTES'),
                ListTileOption(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.registroEstudiantes);
                  },
                  title: 'Filiar Estudiantes',
                ),
                ListTileOption(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.registroEstudiantes);
                  },
                  title: 'Listar Estudiantes',
                ),
                _buildTitle('PROFESOR'),
                ListTileOption(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.registroIndicador);
                  },
                  title: 'Registrar Indicadores',
                ),
                ListTileOption(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.listarIndicadores);
                  },
                  title: 'Listar Indicadores',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
