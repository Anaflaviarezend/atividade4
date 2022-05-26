import 'package:flutter/material.dart';

class Titulo1 extends StatelessWidget {
  final String txt;

  const Titulo1({Key? key, required this.txt}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    );
  }
}
