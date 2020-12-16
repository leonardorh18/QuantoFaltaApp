import 'package:flutter/cupertino.dart';

class Materias extends StatefulWidget {
  Materias({Key key}) : super(key: key);

  @override
  _MateriasState createState() => _MateriasState();
}

class _MateriasState extends State<Materias> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(

         children: [

           Text("Materias")
         ],
       ),
    );
  }
}