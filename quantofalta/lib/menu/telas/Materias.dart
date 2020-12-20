import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:quantofalta/models/Avaliacao.dart';
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

  double total = 0;
  Widget contentDialog(List<Avaliacao> avaliacoes){
  return  Container( 

    width: double.maxFinite,
    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: avaliacoes.length ,
                      itemBuilder: (context, int index){
                        Avaliacao av = avaliacoes[index];
                        total = total +  av.nota * av.peso;
                         return Column(
                           children: [
                             Text(
                                av.nome + " Nota: " +av.nota.toString() + " Peso: "+ av.peso.toString(), style: TextStyle(color: Colors.grey[600], fontSize: 20),
                             ),
                              SizedBox(height: 15,),
                              index == avaliacoes.length -1 ? Text("Media final até agora: "+ total.toString(), style: TextStyle(color: Colors.red[600], fontSize: 20)) : SizedBox(height: 5,)
                           ]
                           
                         );
                      }));
}
    mostrarNotas(List<Avaliacao> avaliacoes){
      showDialog(
              context: context,
              builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Avaliações"),
                    content: contentDialog(avaliacoes),
                    actions:[
                      FlatButton(
                        child: Text("Fechar"),
                        onPressed: (){
                        Navigator.of(context).pop();
                          },
                      ),
                    ],
                  );
              }
          );

    }
    return  Container(

        child: Flexible(
          child: ListView.builder(
            
            itemCount: widget.usuario.materias.length,
            itemBuilder: (context, index){
              Materia materia = widget.usuario.materias[index];
              String qntdAv = materia.avaliacoes.length > 1 ? " avaliações" : " avaliação";
              return  Padding(
                    padding: EdgeInsets.only(top:15),
                    child:GestureDetector( 
                    onTap: (){
                      mostrarNotas(materia.avaliacoes);
                    },
                    child:Card(
                    elevation: 20,
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(materia.nome, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                          SizedBox(height: 10,),
                          Text("Você tem "+materia.avaliacoes.length.toString() + qntdAv + " nessa matéria", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[700]),),

                        ],
                      ),
                  ))
                  );
          }),
        ),

    );
  }
}