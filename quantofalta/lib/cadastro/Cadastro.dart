import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import 'package:quantofalta/models/Usuario.dart';
import 'cadastro_register.dart';
import 'package:quantofalta/error_treatment/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Cadastro extends StatefulWidget {

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  
  

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  String _preencher = '';
  Usuario usuario = Usuario();
  CadastroRegister cadastroRegister = CadastroRegister();


 bool validarCampos(){
         if (emailController.text.isEmpty ==  true||
          passwordController.text.isEmpty ==  true ||
          nomeController.text.isEmpty ==  true ) {
        setState(() {
          _preencher = "Preencha todos os campos!";
        });
        return false;
      } else{
        
        usuario.email = emailController.text.trim();
        usuario.senha = passwordController.text.trim();
        usuario.nome = nomeController.text.trim();
        cadastroRegister.verificarEmailETelefone(usuario, context);
        return true;
      }

    }


  @override
  Widget build(BuildContext context) {



    final emailField = TextField(
      obscureText: false,
      controller: emailController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
          helperText: "Teu email porfavorzinho :)",
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final nomeField = TextField(

      obscureText: false,
      controller: nomeController,
      maxLength: 30,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: "Nome",
          helperText: "Nome que vai aparecer no app :)",
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nome Completo",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: false,
      controller: passwordController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
          helperText: "Crie sua senha super secreta!",
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Crie sua senha",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final registerButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue[700],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: (){
          
         validarCampos();
          
        },
        child: Text("Cadastrar",
          textAlign: TextAlign.center,

        ),
      ),
    );
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[400], 
        title: Text("Cadastro"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 90,),
               
                Center(
                  child:Text(_preencher,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ))
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: nomeField,
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: emailField,
                ),


                Padding(
                  padding: EdgeInsets.all(15),
                  child: passwordField,
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: registerButon,
                ),

              ],
            ),
          ),

      ),
    );
  }
}
