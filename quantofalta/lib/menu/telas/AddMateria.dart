import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddMateria extends StatefulWidget {
  AddMateria({Key key}) : super(key: key);

  @override
  _AddMateriaState createState() => _AddMateriaState();
}

class _AddMateriaState extends State<AddMateria> {

  final materia = TextEditingController();
  final qtdNotas = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(

         children: [

          Padding(
            padding: EdgeInsets.only(top: 30, left: MediaQuery.of(context).size.width/7, right: 10),
            child: Container(
              color: Colors.lightBlueAccent,
             width: MediaQuery.of(context).size.width/1.3,
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                    
                    TextField(
                          obscureText: false,
                          controller: materia,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.library_books_rounded),
                            filled: true,
                            fillColor: Colors.white,
                              contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
                              hintText: "Nome da Materia",
                              border:
                              OutlineInputBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(50))),
                              helperText: "Digite o nome da materia",

                          ),
                        )
               ],
              
             )

          ), 
          ),

         ],
       ) ,
    );
  }
}