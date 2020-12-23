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
  
  List<TextEditingController> pesos = List<TextEditingController>();
  List<TextEditingController> desc = List<TextEditingController>();
  List<TextEditingController> notas = List<TextEditingController>();
  int count = 0;
  String materiaAtual = '';
  Failure f = Failure();
  Widget contentDialog(List<Avaliacao> avaliacoes){
  return  Container( 
   width: double.maxFinite,
    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: avaliacoes.length ,
                      itemBuilder: (context, int index){
                        count =  index + 1;
                        TextEditingController peso = TextEditingController();
                        TextEditingController descricao = TextEditingController();
                        TextEditingController nota = TextEditingController();
                        Avaliacao av = avaliacoes[index];
                        peso.text = av.peso.toString();
                        descricao.text = av.nome;
                        nota.text = av.nota.toString();
                        notas.add(nota);
                        pesos.add(peso);
                        desc.add(descricao);
                         return Column(
                           children: [
                            Text(
                               'Avaliação ' +  count.toString(), style: TextStyle(color: Colors.blue, fontSize: 20),
                             ),
                              TextField(
                              obscureText: false,
                              keyboardType:  TextInputType.number,
                              controller: pesos[index],
                              decoration: InputDecoration(
                                labelText: "Peso avaliação " + count.toString(),
                                suffixIcon: Icon(Icons.note),
                                filled: true,
                                fillColor: Colors.white,
                                  contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 20.0, 10.0),
                                  hintText: "Peso " + count.toString(),
                                  border:
                                  OutlineInputBorder(borderRadius: BorderRadius.horizontal()),
                                  

                              ),
                              ),
                              SizedBox(height: 15,),
                              TextField(
                              obscureText: false,
                              controller: desc[index],
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.edit),
                                filled: true,
                                fillColor: Colors.white,
                                  labelText: "Descrição avaliação " + count.toString(),
                                  contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 20.0, 10.0),
                                  hintText: "Avaliação " + count.toString(),
                                  border:
                                  OutlineInputBorder(borderRadius: BorderRadius.horizontal()),
                                  

                              ),
                              ),
                               SizedBox(height: 15,),
                              TextField(
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              controller: notas[index],
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.edit),
                                filled: true,
                                fillColor: Colors.white,
                                  labelText: "Nota avaliação " + count.toString(),
                                  contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 20.0, 10.0),
                                  hintText: "Nota " + count.toString(),
                                  border:
                                  OutlineInputBorder(borderRadius: BorderRadius.horizontal()),
                                  

                              ),
                              ),
                           ]
                           
                         );
                      }));
}
bool verificaAvaliacoes(){
  for (int index = 0; index < pesos.length; index++){

    if (pesos[index].text.trim().isEmpty ){
      f.toastError("Algum peso esta vazio");
      return false;

    } else if (double.parse(pesos[index].text.trim()) <= 0){
      f.toastError("Os pesos precisam ser maiores do que 0");
      return false;
    } else if (double.parse(pesos[index].text.trim()) > 1){
      f.toastError("Os pesos precisam ser menores do que 1");
      return false;
    } else if(double.parse(notas[index].text.trim()) > 10 || double.parse(notas[index].text.trim()) < 0){

        f.toastError("A nota deve estar entre 0 e 10");
        return false;
    }
  }
  return true;
}

attAvaliacoes(Materia materia) async {
  for (int index =0 ; index < materia.avaliacoes.length; index++){

      materia.avaliacoes[index].nota = double.parse(notas[index].text.trim());
      materia.avaliacoes[index].peso = double.parse(pesos[index].text.trim());
      materia.avaliacoes[index].nome = desc[index].text.trim();

  }
  print("ID DA MATERIA --------> "+ materia.id);
  widget.usuario.attMateria(materia.id);
}
    mostrarNotas(Materia materia){
      showDialog(
              context: context,
              builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Avaliações"),
                    content: contentDialog(materia.avaliacoes),
                    actions:[
                      FlatButton(
                        child: Text("Fechar"),
                        onPressed: (){
                        Navigator.of(context).pop();
                          },
                      ),
                      FlatButton(
                        child: Text("Atualizar"),
                        onPressed: () async{
                        bool done = verificaAvaliacoes();
                        done ? await attAvaliacoes(materia) : f.toastError("Nao foi possivel atualizar essa materia");
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
                                onTap: (){
                                  setState(() {
                                    materiaAtual = materia.nome;
                                  });
                                  mostrarNotas(materia);
                                },
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