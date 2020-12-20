import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quantofalta/error_treatment/failure.dart';
import 'package:quantofalta/models/Avaliacao.dart';
import 'package:quantofalta/models/Materia.dart';
import 'package:quantofalta/models/Usuario.dart';


class EditMateria extends StatefulWidget {
  Usuario usuario;
  EditMateria(this.usuario);

  @override
  _EditMateriaState createState() => _EditMateriaState();
}

class _EditMateriaState extends State<EditMateria> {
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
                    child:Card(
                    elevation: 10,
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(materia.nome, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Icon(Icons.edit, size: 40,),
                              ),

                               SizedBox(width: 20,),
                            
                              GestureDetector(

                                child: Icon(Icons.delete, size: 40, color: Colors.red[700],),
                              ),
                             SizedBox(width: 20,),
                              GestureDetector(
                                onTap: (){
                                  Clipboard.setData(ClipboardData(text: materia.id));
                                  Failure failure = Failure();
                                  failure.toastError(materia.id + " COPIADO!!");
                                },
                                child: Icon(Icons.copy, size: 40, color: Colors.green[700],),
                              )
                            ],
                          ),
                          

                        ],
                      ),
                  ));
          }),
        ),

    );
  }
}