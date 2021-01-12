import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quantofalta/cadastro/Cadastro.dart';
import 'package:quantofalta/error_treatment/failure.dart';
import 'package:quantofalta/login/Login.dart';
import 'package:quantofalta/models/Avaliacao.dart';
import 'package:quantofalta/models/Materia.dart';
import 'package:quantofalta/models/Usuario.dart';

class AddMateria extends StatefulWidget {
  Usuario usuario = new Usuario();
  AddMateria(Usuario usuario){
    this.usuario = usuario;
  }

  @override
  _AddMateriaState createState() => _AddMateriaState();
}

class _AddMateriaState extends State<AddMateria> {



  final nomeMateria = TextEditingController();
  final qtdNotas = TextEditingController();
  int qntd = 1;
  TextEditingController codigo = TextEditingController();
  Failure f = Failure();
  @override
  Widget build(BuildContext context) {
  List<TextEditingController> pesos = List<TextEditingController>();
  List<TextEditingController> desc = List<TextEditingController>();


Widget contentDialog(int counter){
  return  Container( 

    width: double.maxFinite,
    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: counter ,
                      itemBuilder: (context, int index){
                        TextEditingController peso = TextEditingController();
                        TextEditingController descricao = TextEditingController();
                        pesos.add(peso);
                        desc.add(descricao);
                         int count = index + 1;
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
                              
                           ],
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
    }
  }
  return true;
}


addMateria() async{

    Materia materia = new Materia();
    materia.avaliacoes = new List<Avaliacao>();
    materia.nome = nomeMateria.text;
    for (int index = 0; index < pesos.length; index++){
      Avaliacao av = new Avaliacao(nome: desc[index].text.trim(), nota : 0, peso: double.parse(pesos[index].text.trim()));
      print(av.nome + "  ----- "+ av.peso.toString());
      materia.avaliacoes.add(av);
   
  }
  //widget.usuario.materias = new List<Materia>();
  setState(() {
     widget.usuario.materias.add(materia);
  });
  
  f.loading(context);
  await widget.usuario.addMateriaFirebase(materia);
  f.loadingClose(context);

}
addPesos(int counter) {

showDialog(
        context: context,
        builder: (BuildContext context){
            return AlertDialog(
              title: Text("Adicione pesos e nomes para as avaliações"),
              content: contentDialog(counter),
              actions:[
                FlatButton(
                  child: Text("Fechar"),
                   onPressed: (){
                  Navigator.of(context).pop();
                     },
                ),
                FlatButton(
                  child: Text("Pronto!"),
                   onPressed: ()  async {
                     
                     if (verificaAvaliacoes()){
                      await  addMateria();
                       Navigator.of(context).pop();
                     }
                  
                     },
                )
              ],
            );
        }
    );
  

}
bool materiaExiste(String codigo){
  bool exist = false;
  widget.usuario.materias.forEach((element) { 
      print(" ------------ MATERIA ID "+ element.id);
      print("---------------- CODIGO "+ codigo);
      print(" ------------ MATERIA SHARE_ID "+ element.share_id);
    if (element.id == codigo || element.share_id == codigo){
      print("--------------- ja tem essa materia");
      exist = true;
    }
  });
  return exist;
}

    return Container(
       child: SingleChildScrollView(

       child: Column(
         children: [

          Padding(
            padding: EdgeInsets.only(top: 30, left: MediaQuery.of(context).size.width/7, right: 10),
            child: Container(

             width: MediaQuery.of(context).size.width/1.3,
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
               children: [
                    
                    TextField(
                          obscureText: false,
                          controller: nomeMateria,
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
                        ),

                        SizedBox(
                          height: 50,
                        ),
                        Center(child:Text("Quantidade de avaliações", style: TextStyle(color: Colors.blue[800], fontSize: 20, fontWeight: FontWeight.w300),)),
                        Center(child:SizedBox(
                          width: 200,
                          child: NumberPicker.integer(
                            initialValue: qntd,
                            minValue: 1,
                            maxValue: 20,
                            step: 1,
                            decoration: BoxDecoration(
                                  border: new Border(
                                    top: new BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.blueAccent,
                                    ),
                                    bottom: new BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                            infiniteLoop: true,
                            onChanged: (value) => setState(() =>  qntd = value),
                          ),
                      )),

                        SizedBox(height: 30,),
                        Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.blue[700],
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: (){
                            if (qntd == 0){

                              f.toastError("Adicone quantidade de avaliações");
                              return;

                            }
                            else if (qntd <1 ){

                                f.toastError("Adicone quantidade de avaliações");
                                return;
                             
                            } else if (nomeMateria.text.trim().isEmpty) {

                               f.toastError("A materia precisa de um nome");
                               return;

                            }else {
                                 pesos = List<TextEditingController>();
                                  desc = List<TextEditingController>();
                                 addPesos(qntd);
                                

                            }
                            
                           
                          },
                            child: Text("Adicionar pesos das avaliações",
                            textAlign: TextAlign.center,

                            ),
                            ),
                        ),
                        SizedBox(height: 15,),


               ],
              
             )

          ), 
          ),

         ],
       ) ,
      )
    );
  }
}