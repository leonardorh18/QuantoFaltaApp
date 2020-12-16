import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quantofalta/error_treatment/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class Usuario {
  String nome;
  String telefone;
  String email;
  String senha;
  Failure failure = Failure();
  String id;
  

  Usuario({this.id, this.nome, this.telefone, this.email, });


    Map<String, dynamic> toMap(){

    Map <String, dynamic> map = {
      'email': this.email,
      'nome': this.nome,
      'telefone': this.telefone,

      
    };
    return map;
  }
  saveName(Usuario usuario) async {
     Firestore db = Firestore.instance;
     await db.collection('usuarios').document(usuario.id).updateData({
       'nome': usuario.nome
     });

  }
  changePassword(Usuario usuario, context) async {
      failure.loading(context);
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.updatePassword(usuario.senha).then((_){
      print("Succesfull changed password");
      failure.toastError("Senha alterada com sucesso. Pode levar um tempo para que seja atualizada");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      failure.toastError("Houve um erro ao alterar a senha :(");
     
    });
    Navigator.of(context).pop();
 

  }
   setDados(String email, Usuario usuario, String id) async{
     Firestore db = Firestore.instance;
    DocumentSnapshot snapshot = await db.collection("usuarios").document(id).get();

      usuario.nome = snapshot.data['nome'];
      usuario.telefone = snapshot.data['telefone'];
      usuario.email = email;
      usuario.id =  id;


   
    
  }
   
}