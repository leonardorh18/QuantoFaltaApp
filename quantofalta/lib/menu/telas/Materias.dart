import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quantofalta/models/Materia.dart';
import 'package:quantofalta/models/Usuario.dart';

class Materias extends StatefulWidget {
  Usuario usuario;
  Materias(Usuario usuario){
    this.usuario = usuario;
  }

  @override
  _MateriasState createState() => _MateriasState();
}

class _MateriasState extends State<Materias> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 300,
        child: Flexible(
          child: ListView.builder(
            
            itemCount: widget.usuario.materias.length,
            itemBuilder: (context, index){
              Materia materia = widget.usuario.materias[index];
              return  Card(

                    elevation: 10,
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(materia.nome),
                        ],
                      ),
                  );
          }),
        ),

    );
  }
}