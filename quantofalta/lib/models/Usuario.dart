import 'dart:async';

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

  Future<bool> deleteMateria(Materia materia) async{
    try {
      
      Firestore db = Firestore.instance;
      print("ID DA MATERIA A SER DELETADA ---- "+ materia.id);
      await db.collection('materias').document(materia.id).delete();
      this.materias.removeWhere((element) => element.id == materia.id);
      failure.toastError("Materia deletada com sucesso!");
      return true;

    } catch (e){
      print(e);
      failure.toastError("Erro ao deletar a materia :(" );
      return false;

    }

  }
  List<Avaliacao> tratarNpd(var npd , {bool zerarNotas = false}){
    var splt = npd.split(";");
    List<Avaliacao> avaliacoes = List<Avaliacao>();
    for (int index = 0; index < splt.length -1; index ++){
        Avaliacao av = Avaliacao();
        var avaliacao = splt[index].split(",");

        av.nome = avaliacao[0];
        av.peso = double.parse(avaliacao[1]);
        av.nota = zerarNotas ? 0 : double.parse(avaliacao[2]);
        avaliacoes.add(av);
        print("-------> "+ av.nome);
        print("-------> "+ av.peso.toString());
        print("-------> "+ av.nota.toString());
    }

  
    return avaliacoes;

  }

  String criarId() {

    var rand = new Random();
    var l = new List.generate(3, (_) => rand.nextInt(99));
    String numberId = '';
    for (int i = 0; i < l.length; i++){
      numberId = numberId + l[i].toString();
    }
    String id = '';
    id = this.id + numberId;
    for (int index = 0; index < materias.length; index++){
      if (materias[index].id == id){
        criarId();
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
              Materia(nome: dados['nome'], avaliacoes: av, share_id: dados['share_id'], id: id ),
              
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
    materia.id = criarId();
    await db.collection("materias").document(materia.id).setData({
        'nome': materia.nome,
        'npd': avali,
        'user_id': id,
        'share_id': materia.id,
        'id': materia.id,
    });
    failure.toastError('Cadastrado com sucesso');
    return true;

    } catch (e){

        failure.toastError('Erro ao adicionar materia');
        return false;

    }
   

  }
    Future<bool> attMateria(String id) async{
    String avali = '';
    String concat ;
    Materia materia;
    print("Atualizando materia no firebase");
    try {
    for (int index = 0; index < materias.length; index ++){

      if (materias[index].id == id){

        materia =  materias[index];

      }
    }
      print("ID da materia encontrada --->>" + materia.id);
      materia.avaliacoes.forEach((element) {
      print(element.nome);
      print(element.peso);
      print(element.nota);
      concat = element.nome + ',' + element.peso.toString() + ',' + element.nota.toString();
      avali = concat + ";" + avali;
    });
    Firestore db = Firestore.instance;
    await db.collection('materias').document(materia.id).updateData({
      'npd': avali,
    });

    failure.toastError('Atualizado com sucesso');
    return true;

    } catch (e){

        failure.toastError('Erro ao atualizar materia');
        return false;

    }
   
  }

  Future<bool> addMateriaCodigo(String codigo) async {
    Firestore db = Firestore.instance;
    bool done = false;
    DocumentSnapshot snapshot = await db.collection("materias").document(codigo).get().timeout(Duration(seconds: 5), onTimeout: (){return null;});
    if (snapshot == null){
      print("NAO EXISTE ------- >");
      failure.toastError("Codigo não existe");
      return false;
    }
    List<Avaliacao> listaav = tratarNpd(snapshot.data['npd'], zerarNotas: true);
    String id = criarId();
    this.materias.add(Materia(avaliacoes: listaav, nome: snapshot.data['nome'], id:id, share_id: codigo));
    try {

      await db.collection('materias').document(id).setData({
      'nome' : snapshot.data['nome'],
      'npd' : snapshot.data['npd'],
      'user_id': this.id,
      'share_id': codigo,
      'id': id,
    });

    return true;
    } catch (e){


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