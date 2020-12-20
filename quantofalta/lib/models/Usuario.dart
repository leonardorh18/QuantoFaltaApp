import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quantofalta/error_treatment/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:quantofalta/models/Avaliacao.dart';
import 'package:quantofalta/models/Materia.dart';
import 'dart:math';


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
        print("-------> "+ av.nome);
        print("-------> "+ av.peso.toString());
        print("-------> "+ av.nota.toString());
    }

  
    return avaliacoes;

  }
  Future<String> criarId() async{
  Firestore db = Firestore.instance;
  var rand = new Random();
  var l = new List.generate(10, (_) => rand.nextInt(500));
  String numberId = '';
  for (int i = 0; i < l.length; i++){
    numberId = numberId + l[i].toString();
  }
  String id = this.id + numberId;
  QuerySnapshot  snapshot = await db.collection("materias").where('user_id', isEqualTo: id).getDocuments();
        for (DocumentSnapshot item in snapshot.documents){
          var dados = item.data;
          if (dados['id'] == id){
            await criarId();
          }
        }
        return id;

  }
  Future<List<Materia>> getListMaterias() async {
  Firestore db = Firestore.instance;
  List<Materia> materias = List<Materia>();
  QuerySnapshot  snapshot = await db.collection("materias").where('user_id', isEqualTo: id).getDocuments();
      for (DocumentSnapshot item in snapshot.documents){
          var dados = item.data;
          var id = item.documentID;
          var npd = dados['npd'];
          List<Avaliacao> av = tratarNpd(npd);
          materias.add(
            Materia(nome: dados['nome'], avaliacoes: av, id: dados['id'] ),
            
          );
        }

    return materias;
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
    materia.id = await criarId();
    await db.collection("materias").document().setData({
        'nome': materia.nome,
        'npd': avali,
        'user_id': id,
        'id': materia.id,
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

     }catch (e) {
       failure.toastError("Nao foi possivel carregar os dados");

     }

  usuario.materias = await getListMaterias();
  //print("TESTE ----" +usuario.materias[0].avaliacoes[0].nome);
    
  }
   
}