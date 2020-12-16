import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';



  class Failure {


  String errorTreatment(String erro, {context})  {
    print('----------->>'+ erro);
    if(erro.contains("password is invalid")){
      toastError("Senha incorreta");
      print("senha incorreta");
      return "Senha incorreta!";
    }
    else if (erro.contains("already in use")){
      toastError("Email em uso");
      print("Email em uso");
      erroDialog('Email já esta em uso. Clique em "esqueci minha senha" no tela de login ou cadastre outro email', context);
      return "Email já está em uso.";
    }
      else if (erro.contains('ERROR_USER')){
         toastError("Email não cadastrado");
      return 'Email nao cadastrado';
    } else if(erro.contains('ERROR_INVALID_VERIFICATION_CODE')){
      toastError("Código inválido");
        return 'Código inválido';
    } else if (erro.contains('We have blocked all requests from this device')){
      toastError("Detectamos atividade suspeita. Tente novamente mais tarde!");
    } else if (erro.contains('The email address is badly formatted')){
        toastError("Email escrito incorretamente");
    }
    else{
      toastError(erro);
         return 'erro';
    }

  }
erroDialog(String erro, context) {
showDialog(
        context: context,
        builder: (BuildContext context){
            return AlertDialog(
              title: Text("Aviso"),
              content: Container(
                height: 130,
                child: SingleChildScrollView(child: Column(
                  children: <Widget>[
                    Text(erro),
                    
                  
                  ],
                  )
                ),
              ),
                    
                actions:[
                FlatButton(
                  child: Text("Fechar"),
                   onPressed: (){
                  Navigator.of(context).pop();
                     },
                ),
               
              ],
            );
        }
    );
  

}
  void toastError(String erro) {
     
          Fluttertoast.showToast(
          msg: erro,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 7,
          fontSize: 20,
          backgroundColor: Colors.greenAccent[200],
          textColor: Colors.black);
      
      }
       void completeFormulario() {
     
          Fluttertoast.showToast(
          msg: 'Complete todos os campos!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 4,
          backgroundColor: Colors.greenAccent[200],
          textColor: Colors.black);
      
      }
      void erroVaga() {
     
          Fluttertoast.showToast(
          
          msg: 'Erro ao criar a vaga',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 4,
          backgroundColor: Colors.greenAccent[200],
          textColor: Colors.black);
      
      }

      loadingClose(context){
        Navigator.of(context).pop();
      }

    
      loading(context) {
     
         showDialog(
                  context: context,
                  builder: (BuildContext context){
                      return SpinKitThreeBounce(color: Colors.orange[800]);
                  }
              );
      
      }
       loadingImage(context) {
     
         showDialog(
                  context: context,
                  builder: (BuildContext context){
                      return SpinKitDualRing(color: Colors.orange[800]);
                  }
              );
      
      }
      void erroAlterarDados() {
     
          Fluttertoast.showToast(
          msg: 'Erro ao alterar os dados :(',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 4,
          backgroundColor: Colors.greenAccent[200],
          textColor: Colors.black);
      
      }
      void vagaExcluida() {
     
          Fluttertoast.showToast(
          msg: 'A vaga foi excluida com sucesso!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 4,
          backgroundColor: Colors.greenAccent[200],
          textColor: Colors.black);
      
      }
      void vagaCriada() {
     
          Fluttertoast.showToast(
          msg: 'Vaga criada com sucesso!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 4,
          backgroundColor: Colors.greenAccent[200],
          textColor: Colors.black);
      
      }
      void dadosAlterados() {
     
          Fluttertoast.showToast(
          msg: 'Alteração feita com sucesso!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 4,
          backgroundColor: Colors.greenAccent[200],
          textColor: Colors.black);
      
      }



}