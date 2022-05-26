import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sqflite/sqflite.dart';

import '../controllers/principal_controller.dart';
import 'components/itemlista.dart';
import 'components/titulo1.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  // Controller:
  var _controller = PrincipalController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/tarefa.png',
                width: 100,
                height: 100,
              ),
              Column(
                children: [
                  Titulo1(
                    txt: 'Welcome, amiguinho!',
                  ),
                  Container(
                    width: 200,
                    child: Text(
                        'Clique no botão + abaixo para adicionar eventos na sua lista de Tarefas.'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Comandos para delete no BD quando clicar em "Remover":
                      await _controller.remover();
                      setState(() {});
                    },
                    child: Text(
                      "Apagar Tudo",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              )
            ],
          ),
          // ===================
          // Listagem de compras:
          // Utilizar ListViewBuilder dentro de um FutureBuilder

          Expanded(
              // Conteúdo de Exemplo:
              child: FutureBuilder(
                  future: _controller.listarTudo(),
                  builder: (context, AsyncSnapshot? res) {
                    if (!res!.hasData) {
                      //oqsera mostradocaso ainda nao tenha dados no res
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (res.hasError) {
                      return const Center(
                        child: Text("Houve um erro!"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: res.data.length ?? 0,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onDoubleTap: () {
                                Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  title: " AVISO",
                                  desc:
                                      "Deseja remover tarefa ${res.data[i].titulo}?",
                                  buttons: [
                                    DialogButton(
                                      child: const Text(
                                        "sim",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        await _controller
                                            .apagar(res.data[i].id);
                                        //Tirar o alertar da frente
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      color: const Color.fromRGBO(
                                          0, 179, 134, 1.0),
                                    ),
                                    DialogButton(
                                      child: const Text(
                                        "não",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      color: Colors.pink,
                                    )
                                  ],
                                ).show();
                              },
                              child: ItemLista(
                                titulo: res.data[i].titulo,
                                descr: res.data[i].descricao,
                                DataLimite: res.data[i].DataLimite.toString(),
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
        onPressed: () {
          // RFLUTTER ALERT:
          Alert(
              context: context,
              title: "Adicionar Tarefas",
              content: Column(
                children: [
                  TextField(
                    controller: _controller.txttitulo,
                    maxLength: 15,
                    decoration: InputDecoration(
                      icon: Icon(Icons.article_outlined),
                      labelText: 'Titulo',
                    ),
                  ),
                  TextField(
                    controller: _controller.txtDescricao,
                    maxLength: 15,
                    decoration: InputDecoration(
                      icon: Icon(Icons.label),
                      labelText: 'Descrição',
                    ),
                  ),
                  TextField(
                    controller: _controller.txtDataLimite,
                    maxLength: 15,
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_month_sharp),
                      labelText: 'Data Limite',
                    ),
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  onPressed: () async {
                    // Comandos para inserção no BD quando clicar em "Adicionar":
                    await _controller.cadastrar();
                    Navigator.pop(context);
                    setState(() {});
                  },
                  color: Colors.pink,
                  child: Text(
                    "Adicionar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        },
      ),
    );
  }
}
