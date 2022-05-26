import 'dart:convert';

import 'package:listar_de_compra/models/db/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class ItemModel {
  int? id;
  String? titulo;
  String? descricao;
  String? DataLimite;
  ItemModel({this.id, this.titulo, this.descricao, this.DataLimite});

  ItemModel copyWith({
    int? id,
    String? titulo,
    String? descricao,
    String? DataLimite,
  }) {
    return ItemModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      DataLimite: DataLimite ?? this.DataLimite,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (titulo != null) {
      result.addAll({'titulo': titulo});
    }

    if (descricao != null) {
      result.addAll({'descricao': descricao});
    }
    if (DataLimite != null) {
      result.addAll({'DataLimite': DataLimite});
    }

    return result;
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id']?.toInt(),
      titulo: map['titulo'],
      descricao: map['descricao'],
      DataLimite: map['DataLimite']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemModel(id: $id, titulo: $titulo, descricao: $descricao, DataLimite: $DataLimite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel &&
        other.id == id &&
        other.titulo == titulo &&
        other.descricao == descricao &&
        other.DataLimite == DataLimite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        titulo.hashCode ^
        descricao.hashCode ^
        DataLimite.hashCode;
  }

  //metodos para manipular o bd
  Future<int> adicionar() async {
    var db = await DBProvider().database;
    var raw = await db?.rawInsert(
        "INSERT Into item (titulo, descricao , DataLimite)"
        " VALUES (?,?,?)",
        [
          titulo,
          descricao,
          DataLimite,
        ]);
    return raw!.toInt();
  }

  Future<List<ItemModel>> listarTudo() async {
    final db = await DBProvider().database;
    var res = await db!.query("Item");
    List<ItemModel> list =
        res.isNotEmpty ? res.map((c) => ItemModel.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> apagar(int id) async {
    final db = await DBProvider().database;
    return await db!.delete("item", where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await DBProvider().database;
    await db!.rawDelete("DELETE FROM item");
  }
}
