import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quantofalta/error_treatment/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:quantofalta/models/Avaliacao.dart';
import 'package:quantofalta/models/Materia.dart';


class Usuario {
  String nome;
  String email;
  String senha;
  Failure failure = Failure();
  String id;
  List<Materia> materias = List<Materia>();
  
  addNewMateria(Materia materia){
    this.materias.add(materia);
  }

  Usuario({this.id, this.nome,  this.email}){

    this.materias = List<Materia>();

  }

  List<Avaliacao> tratarNpd(var npd){
    var splt = npd.split(";");
    List<Avaliacao> avaliacoes = List<Avaliacao>();
    for (int index = 0; index < splt.length -1; index ++){
        Avaliacao av = Avaliacao();
        var avaliacao = splt[index].split(",");
        av.nome = avaliacao[0];
        av.peso = double.parse(avaliacao[1]);
        av.nota = double.parse(avaliacao[2]);
        avaliacoes.add(av);
    }

  
    return avaliacoes;

  }

  getListMaterias() async {
  Firestore db = Firestore.instance;
  QuerySnapshot  snapshot = await db.collection("materias").where('user_id', isEqualTo: id).getDocuments();
      for (DocumentSnapshot item in snapshot.documents){
          var dados = item.data;
          var id = item.documentID;
          var npd = dados['npd'];
          List<Avaliacao> av = tratarNpd(npd);
          this.materias.add(
            Materia(nome: dados['nome'],avaliacoes: av ),
            
          );


        }

  }
  Future<bool> addMateriaFirebase(Materia materia) async{
    String avali = '';
    String concat ;
    print("Adicionando materia no firebase");
    try {

      materia.avaliacoes.forEach((element) {
        print(element.nome);
        print(element.peso);
        print(element.nota);
        concat = element.nome + ',' + element.peso.toString() + ',' + element.nota.toString();
        avali = concat + ";" + avali;
      });
    Firestore db = Firestore.instance;
    await db.collection("materias").document().setData({
        'nome': materia.nome,
        'npd': avali,
        'user_id': id,
    });
    failure.toastError('Cadastrado com sucesso');
    return true;

    } catch (e){

        failure.toastError('Erro ao adicionar materia');
        return false;

    }
   

  }
  Map<String, dynamic> toMap(){

    Map <String, dynamic> map = {
      'email': this.email,
      'nome': this.nome,  
    };

    return map;
  }


   setDados(String email, Usuario usuario, String id) async{
     try{
      Firestore db = Firestore.instance;
      DocumentSnapshot snapshot = await db.collection("usuarios").document(id).get();

      usuario.nome = snapshot.data['nome'];
      usuario.email = email;
      usuario.id =  id;
      usuario.materias = List<Materia>();

     }catch (e) {
       failure.toastError("Nao foi possivel carregar os dados");

     }
  await  getListMaterias();
    
  }
   
}