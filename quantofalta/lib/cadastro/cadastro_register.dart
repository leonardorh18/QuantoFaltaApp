

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import '../error_treatment/Failure.dart';
import '../login/Login.dart';
import '../models/Usuario.dart';

class CadastroRegister {

  final _codeController =  TextEditingController();
 String verificationId;
  Failure failure = Failure();
  
verificarEmailETelefone(Usuario usuario, context) async {
     Firestore db = Firestore.instance;
     QuerySnapshot emails = await db.collection('usuarios').where('email', isEqualTo: usuario.email).getDocuments();
     List <DocumentSnapshot> emailIsValid = emails.documents;
      print(emailIsValid);
     if (emailIsValid.isEmpty){
       _cadastrar(usuario, context);
     } else if (emailIsValid.isNotEmpty){
        failure.toastError('Email ja cadastrado'); 
     }

}
_cadastrar(Usuario usuario, context) async{
      
       
      
        FirebaseAuth auth = FirebaseAuth.instance;
        auth.createUserWithEmailAndPassword(
          email: usuario.email,
          password: usuario.senha,

        ).then((firebaseUser) async {
          Firestore db = Firestore.instance;
          final FirebaseUser user = await auth.currentUser();
          db.collection("usuarios").document(user.uid).setData(usuario.toMap());

            
              failure.toastError('Cadastrado com sucesso');
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Login()));
           

        }).catchError((e) {
          print(e.toString());
          
            Navigator.of(context).pop();
            failure.errorTreatment(e.toString(), context: context);
            

         

        });
      
    }
    
   
   
  

}