


import 'package:quantofalta/login/Login.dart';
import 'package:quantofalta/models/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'telas/AddMateria.dart';
import 'telas/Materias.dart';
import 'telas/EditMateria.dart';

class Home extends StatefulWidget {
  final Usuario usuario;
  
  Home({this.usuario});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   
  int _indexAtual = 0;


  @override
   void initState(){

     super.initState();
    //ads futuras
   }
   @override
    void dispose() {
    //ads futuras
    
    super.dispose();
  }
  Widget build(BuildContext context) {
  
  List<Widget> listaTelas = [
      Materias(),
      AddMateria(),
      EditMateria(),
  ];
 
    return Scaffold(
      appBar: AppBar(title: Text('Bem vindo, '+widget.usuario.nome, style: TextStyle(color: Colors.white),),
       backgroundColor: Colors.blue[700], 
      iconTheme: IconThemeData(color: Colors.black),
      
      ),
      body: Column(children: [

          listaTelas[_indexAtual]
      ],),

          bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indexAtual,
          onTap: (indice){

            setState(() {
              _indexAtual = indice;
            }
            );

          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
          iconSize: 30,
          
          items: [
            BottomNavigationBarItem(
              title: Text("Materias"),
              icon: Icon(Icons.library_books),
            ),
            BottomNavigationBarItem(
              title: Text("Adicionar Materia"),
              icon: Icon(Icons.plus_one),
            ),

            BottomNavigationBarItem(
              title: Text("Editar"),
              icon: Icon(Icons.edit),
            ),
            
            

          ]

      ),
        
      
    );
    
  }
}