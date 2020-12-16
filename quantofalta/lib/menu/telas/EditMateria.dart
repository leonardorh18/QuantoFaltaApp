import 'package:flutter/cupertino.dart';

class EditMateria extends StatefulWidget {
  EditMateria({Key key}) : super(key: key);

  @override
  _EditMateriaState createState() => _EditMateriaState();
}

class _EditMateriaState extends State<EditMateria> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child:Column(

         children: [

           Text("Edit materia")
         ],
       ),
    );
  }
}