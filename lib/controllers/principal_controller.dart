import 'package:flutter/cupertino.dart';
import 'package:listar_de_compra/models/db/db_provider.dart';
import 'package:listar_de_compra/models/item_model.dart';
import 'package:sqflite/sqflite.dart';

class PrincipalController {
  TextEditingController txttitulo = TextEditingController();
  TextEditingController txtDescricao = TextEditingController();
  TextEditingController txtDataLimite = TextEditingController();
  //metodo p/cadastra itens
  Future<void> cadastrar() async {
    ItemModel item = ItemModel();
    item.titulo = txttitulo.text;
    item.descricao = txtDescricao.text;
    item.DataLimite = txtDataLimite.text;

    //chamar o metodo adicionar
    await item.adicionar();
  }

  Future<void> remover() async {
    await ItemModel().deleteAll();
  }

  Future<List<ItemModel>> listarTudo() async {
    return await ItemModel().listarTudo();
  }

  Future<void> apagar(int id) async {
    await ItemModel().apagar(id);
  }
}
