import 'package:cuaderno_pedagogico/data/tema.dart';
import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:cuaderno_pedagogico/widget/item_tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemasPage extends StatefulWidget {
  @override
  _TemasPageState createState() => _TemasPageState();
}

class _TemasPageState extends State<TemasPage> {
  final model = TemasModel();
  @override
  void initState() {
    model.loadingTemas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Text('Temas'),
        actions: [
          IconButton(
              icon: Icon(CupertinoIcons.add),
              onPressed: () async {
                final tema = await Navigator.of(context)
                    .pushNamed<Tema>(AppRoutes.addTema);
                print(tema?.toMap());
                if (tema != null) {
                  model.addTema(tema);
                }
              })
        ],
      ),
      body: AnimatedBuilder(
          animation: model,
          builder: (_, __) {
            return model.temas != null
                ? ListView.separated(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, bottom),
                    separatorBuilder: (_, __) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: model.temas.length,
                    itemBuilder: (_, index) {
                      final tema = model.temas[index];
                      return ItemTema(
                        tema: tema,
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

class TemasModel extends ChangeNotifier {
  List<Tema> temas;
  final db = DataBase();

  loadingTemas() async {
    try {
      final result = await db.getTemas();
      if (temas == null) {
        temas = [];
      }
      temas.addAll(result);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addTema(Tema tema) {
    temas.insert(0, tema);
    notifyListeners();
  }
}
