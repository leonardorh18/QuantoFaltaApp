
import 'package:quantofalta/login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../error_treatment/Failure.dart';
import '../menu/Home.dart';
import '../models/Usuario.dart';

class LoginAuth{
    Failure failure = Failure();
    



   Future verificarLogin(Usuario usuario, context) async{
    print("VERIFICANDO LOGIN DO PERFIL ..............................");
    
  
   FirebaseAuth auth = FirebaseAuth.instance;
   FirebaseUser user = await auth.currentUser();
   
   if (user != null){
     print("USUARIO VERIFICADO E LOGADO");
      await usuario.setDados(user.email, usuario, user.uid);
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Home(usuario: usuario, indexAtual: 0)));
      
      

   }else{
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Login(usuario: usuario)));
   }

   
 }

fazerLogin(Usuario usuario, context){
    
     failure.loading(context);
    FirebaseAuth auth = FirebaseAuth.instance;
   
    auth.signInWithEmailAndPassword(email: usuario.email, password: usuario.senha).then((firebaseUser) async {
      FirebaseUser user = await auth.currentUser();
      await usuario.setDados(user.email, usuario, user.uid);
      failure.loadingClose(context);
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Home(usuario: usuario, indexAtual: 0,)));

    }).catchError((e){
          failure.loadingClose(context);
          print("---------->>>>> Erro login: "+ e.toString());
          

          
            failure.errorTreatment(e.toString());
          
    });

  }



}
