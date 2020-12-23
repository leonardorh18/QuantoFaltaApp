
import 'package:quantofalta/error_treatment/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:quantofalta/cadastro/Cadastro.dart';

import 'package:page_transition/page_transition.dart';

import '../models/Usuario.dart';
import 'login_auth.dart';


// ignore: must_be_immutable
class Login extends StatefulWidget {
  Usuario usuario;
  Login({this.usuario});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _erro = '';
  bool logado = true;
  Usuario usuario = Usuario();
    final email = TextEditingController();
    final senha = TextEditingController();
    final emailRec = TextEditingController();
    LoginAuth loginAuth = LoginAuth();
    bool _obscureText = true;
    Failure failure = Failure();
  

  _verificarLogin(){
    if (email.text.isEmpty || email.text.contains("@") == false){
      
      setState(() {
        _erro = "Email incorreto!";
      });

    } else if(senha.text.isEmpty){
      setState(() {
        _erro = "Por favor, digite sua senha!";
      });

    }else{
      usuario.senha = senha.text.trim();
      usuario.email = email.text.trim();
      loginAuth.fazerLogin(usuario, context);
    }
  }


 _recuperarSenha()async{
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context){
              return AlertDialog(
                title: Text("Digite o email cadastrado!"),
                
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Enviaremos um email para recuperar sua senha.", style: TextStyle(fontSize: 16),),
                    TextField(
                      controller: emailRec,

                    ),
                  ], 
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: 
                    () async {
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        await _auth.sendPasswordResetEmail(email: emailRec.text.trim());
                        failure.toastError("Email enviado");
                        Navigator.of(context).pop();
                        
                        },
                    child: Text("Enviar")),
                     FlatButton(
                    onPressed: 
                    ()  {
                        Navigator.of(context).pop();
                        },
                    child: Text("Fechar"))
                ],
              );
          }
        );

   }
   void toggle(){
     setState(() {
       _obscureText = !_obscureText;
     });
   }

  
   @override
    void initState()   {
      
      
      super.initState();
      
    }
  Widget build(BuildContext context) {

    final emailField = TextField(
      obscureText: false,
      controller: email,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          helperText: "Digite seu email",

      ),
    );
    final passwordField = TextField(
      obscureText: _obscureText,
      controller: senha,
      decoration: InputDecoration(
        suffixIcon: IconButton(icon: _obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility), onPressed: toggle),
        filled: true,
        fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Senha",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
           helperText: "Digite sua senha",
      ),

    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.greenAccent[700],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: _verificarLogin,
        child: Text("Entrar",
            textAlign: TextAlign.center,

      ),
      ),
    );
    final registerButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue[700],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: (){
          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Cadastro()));
        },
          child: Text("Cadastrar",
          textAlign: TextAlign.center,

          ),
          ),
          );

          return  Scaffold(
            backgroundColor: Colors.white,
          body:  SingleChildScrollView(
            child: Center(
              child: Container(
                width:  MediaQuery.of(context).size.width + 10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 90),
                      child: SizedBox(
                          height: 255.0,
                          child: Image.asset(
                            "imagens/logo.png",
                            fit: BoxFit.contain,
                          )

                      ),
                      
                      ),
                     
                      
                      SizedBox(height: 25.0),
                      Container(
                        width: MediaQuery.of(context).size.width + 10,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                          
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(2, 6), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                                SizedBox(height: 15.0),
                                 SizedBox(
                                  width: MediaQuery.of(context).size.width/1.3,
                                  child: emailField,
                                ),
                                
                                SizedBox(height: 25.0),
                                
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/1.3,
                                  child: passwordField,
                                ),
                              
                                SizedBox(
                                  height: 25.0,
                                ),
                                SizedBox(
                                
                                  width: MediaQuery.of(context).size.width/2,
                                  child: loginButon,
                                ),
                                
                                SizedBox(
                                  height: 25.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: registerButon,
                                ),
                                
                                SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: (){
                                    _recuperarSenha();
                                  },
                                  child:Center(child: Text('Esqueci minha senha',
                                  style: TextStyle(fontSize: 17, color: Colors.black, fontStyle: FontStyle.italic)),
                                ),
                                ),
                                SizedBox(
                                  height: 25.0,
                                ),
                          ],

                        )
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
