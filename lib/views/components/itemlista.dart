import 'package:flutter/material.dart';

import 'titulo1.dart';

class ItemLista extends StatelessWidget {
  final String titulo;
  final String descr;
  final String DataLimite;

  const ItemLista(
      {Key? key,
      required this.titulo,
      required this.DataLimite,
      required this.descr})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Titulo1(txt: titulo),
                Text('Descricao: $descr'),
                Text('Data Limite: $DataLimite'),
              ],
            ),
            Icon(
              Icons.check,
              size: 40,
              color: Colors.pink,
            )
          ],
        ),
      ),
    );
  }
}
